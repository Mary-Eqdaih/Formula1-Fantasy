import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formula1_fantasy/f1/cubit/profile_cubit.dart';
import 'package:formula1_fantasy/f1/cubit/profile_states.dart';
import 'package:formula1_fantasy/f1/presentation/screens/home/home.dart';
import 'package:formula1_fantasy/f1/presentation/screens/leaderboard/leaderboard.dart';
import 'package:formula1_fantasy/f1/presentation/screens/settings/settings.dart';
import 'package:formula1_fantasy/routes/routes.dart';
import '../../../../l10n/app_localizations.dart';
import '../fantasy/fantasy.dart';
import '../teams/teams.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final List<Widget> screens = [
      Home(),
      Teams(),
      Leaderboard(),
      Fantasy(),
      Settings(),
    ];
    const f1Red = Color(0xFFE10600);
    const darkBg = Color(0xFF0F0F10);

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: darkBg,
        selectedItemColor: f1Red,
        unselectedItemColor: Colors.white60,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => selectedIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_filled),
            label: l10n.navHome,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.flag),
            label: l10n.navTeams,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.leaderboard),
            label: l10n.navLeaderboard,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.emoji_events),
            label: l10n.navFantasy,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: l10n.navSettings,
          ),
        ],
      ),
      backgroundColor: darkBg,
      floatingActionButton: selectedIndex == 3 || selectedIndex == 4
          ? null
          : FloatingActionButton(
              backgroundColor: f1Red,
              onPressed: () => Navigator.pushNamed(context, Routes.notes),
              child: const Icon(Icons.note_add, color: Colors.white),
            ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: darkBg,
        elevation: 0,
        title: Row(
          children: [
            SvgPicture.asset('assets/images/F1_logo.svg', height: 28),
            const SizedBox(width: 8),
            Text(
              l10n.appTitle,
              style: const TextStyle(
                fontFamily: 'TitilliumWeb',
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications, color: Colors.white),
          ),
          BlocBuilder<ProfileCubit, ProfileStates>(
            builder: (BuildContext context, ProfileStates state) {
              if (state is ProfileLoadingState) {
                return CircularProgressIndicator(color: f1Red);
              }
              if (state is ProfileSuccessState) {
                return InkWell(
                  onTap: () => Navigator.pushNamed(context, Routes.profile),
                  child: CircleAvatar(
                    radius: 10,
                    backgroundImage: state.profileModel.photoUrl!.isEmpty
                        ? const AssetImage('assets/person.jpeg')
                        : NetworkImage(state.profileModel.photoUrl!)
                              as ImageProvider,
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) async {
              if (value == 'about') {
                Navigator.pushNamed(context, Routes.aboutF1);
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'about',
                child: ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: Text(l10n.commonAboutF1),
                ),
              ),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: screens[selectedIndex],
      ),
    );
  }
}
