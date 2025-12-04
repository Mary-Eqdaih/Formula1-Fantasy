import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formula1_fantasy/f1/cubit/profile_states.dart';
import 'package:formula1_fantasy/f1/data/firebase/firestore.dart';
import 'package:formula1_fantasy/f1/data/models/profile_model.dart';

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
      //  Update Firestore
      await FirestoreService.updateUserData(profileModel, uid);
      //  Update FirebaseAuth displayName so Home using currentUser.displayName sees change
      await FirebaseAuth.instance.currentUser!
          .updateDisplayName(profileModel.name);

      await FirebaseAuth.instance.currentUser!.reload();

      emit(ProfileSuccessState(profileModel));
    } catch (e) {
      emit(ProfileErrorState(e.toString()));
    }
  }

}
