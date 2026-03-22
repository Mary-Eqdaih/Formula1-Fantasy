import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formula1_fantasy/f1/cubit/auth_cubit.dart';
import 'package:formula1_fantasy/f1/cubit/auth_state.dart';
import 'package:formula1_fantasy/f1/cubit/profile_cubit.dart';
import 'package:formula1_fantasy/f1/data/models/profile_model.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../routes/routes.dart';
import '../../widgets/Custom_text_field.dart';

class SignUp extends StatefulWidget {
  SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$',
  );
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    const f1Red = Color(0xFFE10600);
    const deepRed = Color(0xFF7A0000);

    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          saveUserData(context, state.user.uid);
          Navigator.pushReplacementNamed(context, Routes.home);
        } else if (state is AuthErrorState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [f1Red, deepRed, Color(0xFF0F0F10)],
              stops: [0.0, 0.55, 1.0],
            ),
          ),
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/F1_logo.svg',
                          height: 70,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          l10n.appTitle,
                          style: const TextStyle(
                            fontFamily: 'TitilliumWeb',
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          l10n.signUpWelcome,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                          ),
                        ),
                        const SizedBox(height: 30),
                        CustomTextField(
                          preIcon: const Icon(Icons.person),
                          isPassword: false,
                          hint: l10n.signUpUsername,
                          controller: usernameController,
                          validator: (username) {
                            if (username == null || username.isEmpty)
                              return l10n.signUpEmptyUsername;
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                        CustomTextField(
                          preIcon: const Icon(Icons.email),
                          isPassword: false,
                          hint: l10n.signUpEmail,
                          controller: emailController,
                          validator: (email) {
                            if (email == null || email.isEmpty)
                              return l10n.signUpEmptyEmail;
                            if (!emailRegex.hasMatch(email))
                              return l10n.signUpInvalidEmail;
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          suffixIcon: IconButton(
                            onPressed: () => setState(
                              () => _isPasswordVisible = !_isPasswordVisible,
                            ),
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          preIcon: const Icon(Icons.lock),
                          isPassword: !_isPasswordVisible,
                          hint: l10n.signUpPassword,
                          controller: passwordController,
                          validator: (password) {
                            if (password == null || password.isEmpty)
                              return l10n.signUpEmptyPassword;
                            if (!passwordRegex.hasMatch(password))
                              return l10n.signUpInvalidPassword;
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        CustomTextField(
                          preIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () => setState(
                              () => _isConfirmPasswordVisible =
                                  !_isConfirmPasswordVisible,
                            ),
                            icon: Icon(
                              _isConfirmPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          controller: confirmPasswordController,
                          isPassword: !_isConfirmPasswordVisible,
                          hint: l10n.signUpConfirmPassword,
                          validator: (confirm) {
                            if (confirm == null || confirm.isEmpty)
                              return l10n.signUpEmptyConfirm;
                            if (confirm != passwordController.text)
                              return l10n.signUpPasswordMismatch;
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              l10n.signUpHasAccount,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            TextButton(
                              onPressed: () =>
                                  Navigator.pushNamed(context, Routes.signIn),
                              child: Text(
                                l10n.signUpSignIn,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.9,
                                  color: f1Red,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: double.infinity,
                          height: 65,
                          child: BlocBuilder<AuthCubit, AuthStates>(
                            builder: (context, state) {
                              return state is AuthLoadingState
                                  ? ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: f1Red,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                          side: BorderSide.none,
                                        ),
                                      ),
                                      onPressed: () {},
                                      child: const CircularProgressIndicator(),
                                    )
                                  : ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: f1Red,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            30,
                                          ),
                                          side: BorderSide.none,
                                        ),
                                      ),
                                      onPressed: () => signUp(context),
                                      child: Text(
                                        l10n.signUpButton,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  signUp(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().signUp(
        emailController.text,
        passwordController.text,
        usernameController.text,
      );
    }
  }

  saveUserData(BuildContext context, String id) {
    final profile = ProfileModel(
      name: usernameController.text,
      email: emailController.text,
      bio: 'Bio',
      photoUrl: '',
    );
    context.read<ProfileCubit>().saveUserData(profile);
  }
}

//      var credential = await FirebaseAuthServices.signUp(emailController.text, passwordController.text);
//      credential => It’s an instance of UserCredential
//        Firebase returns → a UserCredential object
//This object contains:
//
// UserCredential {
//   User? user;                     // The user account info
//   AdditionalUserInfo? additionalUserInfo; // extra metadata
//   AuthCredential? credential;     // For linking providers
// }
