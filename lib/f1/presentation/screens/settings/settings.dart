import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formula1_fantasy/f1/cubit/auth_cubit.dart';
import 'package:formula1_fantasy/f1/cubit/profile_cubit.dart';
import 'package:formula1_fantasy/f1/cubit/profile_states.dart';
import 'package:formula1_fantasy/f1/presentation/widgets/Custom_text_field.dart';
import 'package:formula1_fantasy/f1/presentation/widgets/settings_widget.dart';
import 'package:formula1_fantasy/routes/routes.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    const darkBg = Color(0xFF0F0F10);
    const cardColor = Color(0xFF18191A);
    const f1Red = Color(0xFFE10600);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: darkBg,
        title: Text(
          "Settings",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
          ),
        ),
      ),
      backgroundColor: darkBg,
      body: RefreshIndicator(
        color: f1Red,
        onRefresh: () {
          context.read<ProfileCubit>().fetchUserData();
          return Future.delayed(Duration(seconds: 1));
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, Routes.profile);
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      BlocBuilder<ProfileCubit, ProfileStates>(
                        builder: (context, state) {
                          if (state is ProfileLoadingState) {
                            return CircularProgressIndicator(color: f1Red);
                          }
                          if (state is ProfileSuccessState) {
                            return CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  state.profileModel.photoUrl!.isEmpty
                                  ? AssetImage("assets/person.jpeg")
                                  : NetworkImage(state.profileModel.photoUrl!),
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                      const SizedBox(width: 20),
                      BlocBuilder<ProfileCubit, ProfileStates>(
                        builder: (context, state) {
                          if (state is ProfileSuccessState) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${state.profileModel.name}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${state.profileModel.email}",
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            );
                          }

                          if (state is ProfileErrorState) {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Can't Load Profile",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(height: 10),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: f1Red,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 15,
                                      ),
                                    ),
                                    onPressed: () {
                                      context
                                          .read<ProfileCubit>()
                                          .fetchUserData();
                                    },
                                    child: const Text(
                                      "Refresh",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              SettingsWidget(
                cardTitle: "Notifications",
                onTap: () {
                  Navigator.pushNamed(context, Routes.notifications);
                },
                title: 'Notification Settings',
                icon: Icons.notifications,
              ),
              SettingsWidget(
                cardTitle: "Privacy Settings",
                onTap: () {},
                title: 'Privacy ',
                icon: Icons.lock_outline,
              ),
              SettingsWidget(
                cardTitle: "Change of Language",
                onTap: () {},
                title: 'Language ',
                icon: Icons.language,
              ),
              SettingsWidget(
                cardTitle: "Favorite Teams",
                onTap: () {
                  Navigator.pushNamed(context, Routes.favs);
                },
                title: 'Favorites ',
                icon: Icons.favorite,
              ),
              SettingsWidget(
                cardTitle: "Send Us Feedback",
                onTap: () {},
                title: 'Other ',
                icon: Icons.wechat_outlined,
              ),
              SettingsWidget(
                color: f1Red,
                cardTitle: "Delete",
                onTap: () {
                  promptForPasswordAndDelete(context);
                },
                title: 'Delete Account ',
                icon: Icons.delete_forever,
              ),

              const SizedBox(height: 20),
              const Divider(color: Colors.white60), // Divider
              const SizedBox(height: 20),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: f1Red,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () {
                  context.read<AuthCubit>().signOut();
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.signIn,
                    (r) => false,
                  );
                },
                child: const Text(
                  'Sign Out',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );



  }

  Future<void> promptForPasswordAndDelete(BuildContext context) async {
    final passwordController = TextEditingController();
    final _formKey = GlobalKey<FormState>();
    bool _isPasswordVisible = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Color(0xFF0F0F10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text("Confirm Account Deletion", style: TextStyle(color: Colors.white)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Please enter your password to confirm deletion.", style: TextStyle(color: Colors.white)),
                  SizedBox(height: 10),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          preIcon: Icon(Icons.lock,),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              // Toggle password visibility
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          controller: passwordController,
                          isPassword: !_isPasswordVisible,
                          hint: 'Enter Your Password',
                          validator: (confirm) {
                            if (confirm == null || confirm.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Cancel", style: TextStyle(color: Colors.white)),
                            ),
                            TextButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  final password = passwordController.text;
                                  if (password.isNotEmpty) {
                                    final errorMessage = await context.read<AuthCubit>().deleteAccount(password);
                                    // TODO: make sure it deletes user from firestore also
                                    // DONE
                                    if (errorMessage != null) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(errorMessage)),
                                      );
                                    } else {
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        Routes.signIn,
                                            (r) => false,
                                      );
                                    }
                                  }
                                }
                              },
                              child: const Text("Delete", style: TextStyle(color: Color(0xFFE10600))),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

}

