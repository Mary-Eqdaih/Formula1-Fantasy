import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formula1_fantasy/f1/cubit/auth_cubit.dart';
import 'package:formula1_fantasy/f1/presentation/widgets/settings_widget.dart';
import 'package:formula1_fantasy/routes/routes.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    const darkBg = Color(0xFF0F0F10);
    const cardColor = Color(0xFF18191A);
    const f1Red = Color(0xFFE10600);

    return Scaffold(
      appBar: AppBar(
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
      body: SingleChildScrollView(
        child: Column(

          children: [
            InkWell(
              onTap: (){
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
                    const CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(
                        "https://images.unsplash.com/photo-1602043410209-d57816124451?q=80&w=1332&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          FirebaseAuth.instance.currentUser!.displayName!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          FirebaseAuth.instance.currentUser!.email!,
                          style: TextStyle(color: Colors.white70, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),


            SettingsWidget(
              cardTitle: "Notifications",
              onTap: () {},
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

            ),    SettingsWidget(
              cardTitle: "Send Us Feedback",
              onTap: () {},
              title: 'Other ',
              icon: Icons.wechat_outlined,

            ), SettingsWidget(
              color: f1Red,
              cardTitle: "Delete",
              onTap: () {},
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
    );
  }
}
