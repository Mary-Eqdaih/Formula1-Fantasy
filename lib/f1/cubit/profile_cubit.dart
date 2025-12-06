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
          .upload(path, imageFile);// https://eifbpydagmgzilcphuwi.supabase.co/storage/v1/object/public/avatars/1765041249476_34.jpg

      final imageUrl = await Supabase.instance.client.storage
          .from("avatars")
          .getPublicUrl(path);


      // Create a new model with old data + new photo URL
      final updatedProfile = ProfileModel(
        name: currentState.profileModel.name,
        email: currentState.profileModel.email,
        bio: currentState.profileModel.bio,
        photoUrl: imageUrl,
      );

      // Use updateUserData which handles state emitting
      await updateUserData(updatedProfile);
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }

  // Future deleteImage() async {
  //   // ممكن من فوق اعرف متغير للباث واحد واحط بالدوال الاتنين او اجيبه من
  //   // imageUrl
  //   if (imageUrl == null) return;
  //   // https://eifbpydagmgzilcphuwi.supabase.co/storage/v1/object/public/avatars/1765041249476_34.jpg
  //   final imagePath = imageUrl!.split("/").last;
  //   await Supabase.instance.client.from("avatars").remove();
  // }
}
