import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formula1_fantasy/f1/cubit/profile_states.dart';
import 'package:formula1_fantasy/f1/data/firebase/firestore.dart';
import 'package:formula1_fantasy/f1/data/models/profile_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());

  saveUserData(ProfileModel profileModel) async {
    emit(ProfileLoadingState());
    try {
      await FirestoreService.saveUserData(
        profileModel.toMap(),
        FirebaseAuth.instance.currentUser!.uid,
      );

      // Firestore save successful → return the same input model
      emit(ProfileSuccessState(profileModel));
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }

  fetchUserData() async {
    emit(ProfileLoadingState());
    try {
      var profileModel = await FirestoreService.fetchUserData(
        FirebaseAuth.instance.currentUser!.uid,
      );
      emit(ProfileSuccessState(profileModel));
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }

  Future<void> updateUserData(ProfileModel profileModel) async {
    emit(ProfileLoadingState());
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;
      await FirestoreService.updateUserData(profileModel, uid);
      if (profileModel.name != null) {
        await FirebaseAuth.instance.currentUser!
            .updateDisplayName(profileModel.name);
      }
      await FirebaseAuth.instance.currentUser!.reload();

      // Refetch data to ensure consistency
      final updatedProfile = await FirestoreService.fetchUserData(uid);
      emit(ProfileSuccessState(updatedProfile));
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }
  //
  // Future<void> updateUserData(
  //   ProfileModel profileModel,
  //   String password,
  // ) async {
  //   final uid = FirebaseAuth.instance.currentUser!.uid;
  //
  //   try {
  //     final currentUser = FirebaseAuth.instance.currentUser!;
  //     final AuthCredential credential = EmailAuthProvider.credential(
  //       email: currentUser.email!,
  //       password: password,
  //     );
  //
  //     // Reauthenticate the user
  //     await currentUser.reauthenticateWithCredential(credential);
  //
  //     // Check if the email is different from the current email
  //     if (profileModel.email != null &&
  //         profileModel.email != currentUser.email) {
  //       // 1. Send verification email before updating the email
  //       await currentUser.verifyBeforeUpdateEmail(profileModel.email!);
  //
  //       // Check if the email verification is in process or completed
  //       print("Verification email sent to: ${profileModel.email}");
  //       await currentUser.reload(); // Reload to reflect the email change status
  //
  //       if (!currentUser.emailVerified) {
  //         throw Exception("Please verify your email before updating.");
  //       }
  //     }
  //
  //     // 2. Update Display Name if changed
  //     if (profileModel.name != null && profileModel.name!.isNotEmpty) {
  //       await FirebaseAuth.instance.currentUser!.updateDisplayName(
  //         profileModel.name,
  //       );
  //     }
  //
  //     // Reload user to reflect changes in the Firebase instance
  //     await currentUser.reload();
  //
  //     // 3. Update Firestore with new user profile data
  //     await FirestoreService.updateUserData(profileModel, uid);
  //
  //     // Fetch the updated profile from Firestore and emit the updated state
  //     final updatedProfile = await FirestoreService.fetchUserData(uid);
  //
  //     // Emit the updated profile data
  //     emit(ProfileSuccessState(updatedProfile));
  //
  //     print("User data updated successfully in Firebase Auth and Firestore.");
  //   } catch (e) {
  //     print("Error updating user data: $e");
  //     emit(ProfileErrorState(e.toString())); // Emit error state
  //   }
  // }

  String? imageUrl;

  Future<File?> pickImage() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image.
    // image
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return null;
    // path of image
    final File? imageFile = File(image.path);
    return imageFile;
  }

  Future<void> uploadImage() async {
    final currentState = state;
    if (currentState is! ProfileSuccessState) {
      emit(ProfileErrorState("Profile not loaded. Cannot upload image."));
      return;
    }

    emit(ProfileLoadingState());

    final imageFile = await pickImage();
    // covers/images/profile.png
    if (imageFile == null) {
      emit(currentState); // Revert to previous state if user cancels
      return;
    }

    final timeStamp = DateTime.now().millisecondsSinceEpoch.toString();
    final path = "${timeStamp}_${imageFile.path.split("/").last.toLowerCase()}";

    try {
      //  file is image itself
      //    path ... obvious ... path of image to store in supabase unique
      await Supabase.instance.client.storage
          .from("avatars")
          .upload(
            path,
            imageFile,
          ); // https://eifbpydagmgzilcphuwi.supabase.co/storage/v1/object/public/avatars/1765041249476_34.jpg

      final imageUrl = await Supabase.instance.client.storage
          .from("avatars")
          .getPublicUrl(path);

      // Create a new model with old data + new photo URL
      // Create a new ProfileModel with the updated photoUrl (preserving other data)
      final updatedProfile = ProfileModel(
        name: currentState.profileModel.name,
        email: currentState.profileModel.email,
        bio: currentState.profileModel.bio,
        photoUrl: imageUrl,
      );
      // Use updateUserData which handles state emitting
      await FirestoreService.updatePhotoUrl(
        FirebaseAuth.instance.currentUser!.uid,
        imageUrl,
      );
      emit(ProfileSuccessState(updatedProfile));
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }
}
