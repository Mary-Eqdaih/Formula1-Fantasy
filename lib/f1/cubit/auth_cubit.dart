import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formula1_fantasy/f1/cubit/auth_state.dart';
import 'package:formula1_fantasy/f1/data/firebase/firebase.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  // Check if logged in
  checkIfLoggedIn() {
    if (FirebaseAuth.instance.currentUser != null) {
      emit(AuthSuccessState(FirebaseAuth.instance.currentUser!));
    }
    //   is a getter that returns the currently signed-in user(User) in your app, or null if no user is signed in.
  }

  // Sign in
  Future<void> signIn(String email, String password) async {
    emit(AuthLoadingState());
    try {
      final credential = await FirebaseAuthServices.signIn(email, password);
      emit(AuthSuccessState(credential!.user!));
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(e.toString()));
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }

      return;
    }
  }

  // Sign

  // AuthCubit
  signUp(String email, String password, String username) async {
    emit(AuthLoadingState());
    try {
      final credential = await FirebaseAuthServices.signUp(
        email,
        password,
        username,
      );
      emit(AuthSuccessState(credential.user!));
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(e.message ?? 'Registration failed'));
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuthServices.signOut();
      emit(AuthInitialState());
    } catch (e) {
      emit(AuthErrorState('Error signing out: $e'));
    }
  }

  Future<String?> deleteAccount(String password) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        return "No user is currently signed in."; // Error message if no user is logged in
      }

      // Create a credential to re-authenticate
      final cred = EmailAuthProvider.credential(email: user.email!, password: password);

      // Re-authenticate the user before deleting
      await user.reauthenticateWithCredential(cred);

      // If re-authentication is successful, delete the account
      await user.delete();
      await FirebaseAuthServices.signOut();
      emit(AuthInitialState()); // Emit initial state after deletion
      return null; // Return null on success (indicating no error)

    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password' || e.code == 'invalid-credential') {
        return 'The password you entered is incorrect. Please try again.'; // Message for wrong password
      }
      return e.message; // Return other Firebase error messages
    } catch (e) {
      // Catch any other general errors
      return 'An unexpected error occurred: ${e.toString()}';
    }
  }




}
