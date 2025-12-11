import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formula1_fantasy/f1/cubit/auth_cubit.dart';
import 'package:formula1_fantasy/f1/cubit/auth_state.dart';
import 'package:formula1_fantasy/f1/cubit/profile_cubit.dart';
import 'package:formula1_fantasy/f1/presentation/widgets/Custom_text_field.dart';
import 'package:formula1_fantasy/routes/routes.dart';

class SignIn extends StatefulWidget {
  SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$',
  );
  bool _isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().checkIfLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    const f1Red = Color(0xFFE10600);
    const deepRed = Color(0xFF7A0000);
    return BlocListener<AuthCubit, AuthStates>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          context.read<ProfileCubit>().fetchUserData();
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
                        // Icon(
                        //   Icons.sports_motorsports,
                        //   color: Colors.white,
                        //   size: 150,
                        // ),
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
                        SizedBox(height: 40),
                        Text(
                          "Welcome Back",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Let's Get Started",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 30),
                        CustomTextField(
                          preIcon: Icon(Icons.email),
                          isPassword: false,
                          hint: "Email",
                          controller: emailController,
                          validator: (email) {
                            if (email == null || email.isEmpty) {
                              return 'Please enter your email';
                            }

                            return null;
                          },
                        ),
                        SizedBox(height: 15),
                        CustomTextField(
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          preIcon: Icon(Icons.password),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "You Don't Have an Account?",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, Routes.signUp);
                              },
                              child: Text(
                                "Sign Up",
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
                                        login(context);
                                      },
                                      child: const Text(
                                        "Sign In",
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

  login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      context.read<AuthCubit>().signIn(
        emailController.text,
        passwordController.text,
      );
    }
  }
}

// | Step | Layer                                              | What happens                                  |
// | ---- | -------------------------------------------------- | ---------------------------------------------|
// | 1    | User taps button                                   | UI calls `AuthCubit.signIn()`                |
// | 2    | Cubit emits `AuthLoadingState`                     | UI shows spinner (BlocBuilder)               |
// | 3    | Firebase checks credentials                        | success or throws exception                  |
// | 4    | Cubit emits `AuthSuccessState` or `AuthErrorState` | UI navigates or shows error (BlocListener)   |
// | 5    | On logout, `signOut()` → `AuthInitialState`        | UI returns to login screen                   |

//| **Step** | **Layer**                         | **What Happens**                                                                                                                                                                                                                                   |
// | -------- | --------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
// | **1**    | 🖱️ **UI Layer (Widget)**         | The user taps a button → you call `context.read<AuthCubit>().signIn(email, password);` (or `signUp`) inside the button’s `onPressed`.                                                                                                               |
// | **2**    | ⚙️ **Cubit Logic Layer**          | The Cubit receives the call and immediately emits `AuthLoadingState()`. <br>➡️ This tells the UI (through `BlocBuilder`) to show a **loading spinner** instead of the button.                                                                      |
// | **3**    | ☁️ **FirebaseAuth Backend**       | The Cubit then calls `FirebaseAuth.instance.signInWithEmailAndPassword(...)`. <br>➡️ Firebase checks the credentials on its servers and returns either a **`UserCredential`** (success) or throws a **`FirebaseAuthException`** (failure).         |
// | **4**    | 🧱 **Cubit Emits a Result State** | Based on Firebase’s response: <br>• Success → `emit(AuthSuccessState(credential))` <br>• Failure → `emit(AuthErrorState(errorMessage))` <br><br>➡️ The `BlocListener` in the UI reacts: if success → navigate to Home; if error → show `SnackBar`. |
// | **5**    | 🚪 **Sign Out (Optional)**        | When the user taps "Log Out", `signOut()` is called → Firebase clears the session → Cubit emits `AuthInitialState()`.<br>➡️ The UI returns to the **Sign In** screen.                                                                              |
