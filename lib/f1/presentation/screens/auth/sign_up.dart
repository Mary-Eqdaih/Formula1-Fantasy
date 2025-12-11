import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formula1_fantasy/f1/cubit/auth_cubit.dart';
import 'package:formula1_fantasy/f1/cubit/auth_state.dart';
import 'package:formula1_fantasy/f1/cubit/profile_cubit.dart';
import 'package:formula1_fantasy/f1/data/models/profile_model.dart';
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
          decoration: BoxDecoration(
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
                padding: EdgeInsets.symmetric(horizontal: 24),
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
                        SizedBox(height: 10),
                        Text(
                          "Fantasy",
                          style: TextStyle(
                            fontFamily: "TitilliumWeb",
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                        ),
                        SizedBox(height: 30),
                        Text(
                          "Welcome To Formula 1",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                        SizedBox(height: 30),

                        CustomTextField(
                          preIcon:Icon( Icons.person),
                          isPassword: false,
                          hint: "Username",
                          controller: usernameController,
                          validator: (username) {
                            if (username == null || username.isEmpty) {
                              return 'Please enter your email';
                            }

                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        CustomTextField(
                          preIcon: Icon(Icons.email),
                          isPassword: false,
                          hint: "Email",
                          controller: emailController,
                          validator: (email) {
                            if (email == null || email.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!emailRegex.hasMatch(email)) {
                              return 'Enter a valid email address';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),

                        CustomTextField(
                          suffixIcon: IconButton(onPressed: (){
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          }, icon: Icon(_isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,)),
                          preIcon:Icon( Icons.password),
                          isPassword: !_isPasswordVisible,
                          hint: "Password",
                          controller: passwordController,
                          validator: (password) {
                            if (password == null || password.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (!passwordRegex.hasMatch(password)) {
                              return 'Password must have upper, lower, number, and special character';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        CustomTextField(
                          preIcon: Icon(Icons.password),
                          suffixIcon: IconButton(onPressed: (){
                            setState(() {
                              _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                            });
                          }, icon: Icon(_isConfirmPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,)),
                          controller: confirmPasswordController,
                          isPassword: !_isConfirmPasswordVisible,
                          hint: "Confirm Password",
                          validator: (confirm) {
                            if (confirm == null || confirm.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (confirm != passwordController.text) {
                              return "Passwords doesn't match";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already Have an Account?",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.signIn);
                              },
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.9,
                                  color: f1Red,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
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
                                      child: CircularProgressIndicator(),
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
                                      onPressed: () {
                                        signUp(context);
                                      },
                                      child: const Text(
                                        "Sign Up",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    );
                            },
                          ),
                        ),
                        SizedBox(height: 20),
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
      bio: "",
      photoUrl: "",
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
