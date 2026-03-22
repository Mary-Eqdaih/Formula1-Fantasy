import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formula1_fantasy/f1/cubit/auth_cubit.dart';
import 'package:formula1_fantasy/f1/cubit/fav_states.dart';
import 'package:formula1_fantasy/f1/cubit/favs_cubit.dart';
import 'package:formula1_fantasy/f1/cubit/profile_cubit.dart';
import 'package:formula1_fantasy/f1/cubit/profile_states.dart';
import 'package:formula1_fantasy/f1/data/models/profile_model.dart';
import 'package:formula1_fantasy/f1/presentation/widgets/Custom_text_field.dart';
import 'package:formula1_fantasy/f1/presentation/widgets/teams_profile_widget.dart';
import 'package:formula1_fantasy/l10n/app_localizations.dart';
import 'package:formula1_fantasy/routes/routes.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    const f1Red = Color(0xFFE10600);
    const darkBg = Color(0xFF0F0F10);
    const gray = Color(0xFF424242);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) async {
              switch (value) {
                case 'about':
                  Navigator.pushNamed(context, Routes.aboutF1);
                  break;
                case 'signOut':
                  await context.read<AuthCubit>().signOut();
                  if (context.mounted) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Routes.signIn,
                      (route) => false,
                    );
                  }
                  break;
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
              PopupMenuItem(
                value: 'signOut',
                child: ListTile(
                  leading: const Icon(Icons.logout),
                  title: Text(l10n.commonSignOut),
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: darkBg,
      body: RefreshIndicator(
        color: f1Red,
        onRefresh: () async {
          await context.read<ProfileCubit>().fetchUserData();
          if (context.mounted) {
            await context.read<FavoritesCubit>().loadFavorites();
          }
        },
        child: BlocBuilder<ProfileCubit, ProfileStates>(
          builder: (context, state) {
            if (state is ProfileErrorState) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Center(
                      child: Text(
                        l10n.profileFailedLoad,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              );
            }
            if (state is ProfileLoadingState) {
              return const Center(
                child: CircularProgressIndicator(color: f1Red),
              );
            }
            if (state is ProfileSuccessState) {
              final profile = state.profileModel;
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Center(
                  child: Column(
                    children: [
                      // Avatar
                      const SizedBox(height: 20),
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: gray,
                            backgroundImage:
                                (profile.photoUrl == null ||
                                    profile.photoUrl!.isEmpty)
                                ? const AssetImage("assets/person.jpeg")
                                      as ImageProvider
                                : NetworkImage(profile.photoUrl!),
                          ),
                          Positioned(
                            bottom: -5,
                            right: -5,
                            child: CircleAvatar(
                              backgroundColor: f1Red,
                              radius: 18,
                              child: IconButton(
                                iconSize: 18,
                                onPressed: () {
                                  context.read<ProfileCubit>().uploadImage();
                                },
                                icon: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      // name
                      Text(
                        profile.name ?? l10n.profileNoName,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      // bio
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          profile.bio ?? l10n.profileNoBio,
                          style: const TextStyle(
                            color: Colors.yellow,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Edit Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: f1Red,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 8,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onPressed: () {
                          nameController.text = profile.name ?? '';
                          bioController.text = profile.bio ?? '';

                          showDialog(
                            context: context,
                            builder: (dialogContext) {
                              return AlertDialog(
                                backgroundColor: darkBg,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                title: Text(
                                  l10n.profileEditTitle,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                content: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        l10n.profileEditName,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      CustomTextField(
                                        controller: nameController,
                                        hint: l10n.profileEditName,
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        l10n.profileEditBio,
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      CustomTextField(
                                        controller: bioController,
                                        hint: l10n.profileEditBio,
                                      ),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(dialogContext),
                                    child: Text(
                                      l10n.profileCancel,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      final updatedModel = ProfileModel(
                                        name: nameController.text,
                                        bio: bioController.text,
                                        email: profile.email,
                                        photoUrl: profile.photoUrl,
                                      );
                                      context
                                          .read<ProfileCubit>()
                                          .updateUserData(updatedModel);
                                      Navigator.pop(dialogContext);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: f1Red,
                                    ),
                                    child: Text(
                                      l10n.profileSave,
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              l10n.profileEdit,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 18,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Favorites
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Card(
                          color: gray,
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      l10n.profileFavoriteTeams,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(Icons.favorite, color: f1Red),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                BlocBuilder<FavoritesCubit, FavoritesStates>(
                                  builder: (context, favState) {
                                    if (favState is FavoritesSuccessState) {
                                      if (favState.favs.isEmpty) {
                                        return Center(
                                          child: Text(
                                            l10n.profileFavoritesEmpty,
                                            style: const TextStyle(
                                              color: Colors.white70,
                                            ),
                                          ),
                                        );
                                      }
                                      return Column(
                                        children: favState.favs.map((team) {
                                          return ProfileFavoriteTeamWidget(
                                            team: team,
                                          );
                                        }).toList(),
                                      );
                                    }
                                    return const SizedBox(height: 50);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
