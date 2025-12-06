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
            const Text(
              "Fantasy",
              style: TextStyle(
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
                  Navigator.pushNamed(context, Routes.signIn);
                  break;
              }
            },
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: 'about',
                child: ListTile(
                  leading: Icon(Icons.info_outline),
                  title: Text('About F1'),
                ),
              ),
              PopupMenuItem(
                value: 'signOut',
                child: ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Sign Out'),
                ),
              ),
            ],
          ),
        ],
      ),
      backgroundColor: darkBg,
      body: BlocConsumer<ProfileCubit, ProfileStates>(
        listener: (context, state) {
          if (state is ProfileErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          if (state is ProfileErrorState) {
            return const Center(
              child: Text(
                "Failed to load profile data",
                style: TextStyle(color: Colors.red),
              ),
            );
          }
          if (state is ProfileLoadingState) {
            return const Center(child: CircularProgressIndicator(color: f1Red));
          }
          if (state is ProfileSuccessState) {

            return SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    // edit button for profile
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: TextButton(
                          onPressed: () {
                            // Reset controllers when opening dialog
                            nameController.clear();
                            emailController.clear();
                            bioController.clear();

                            showDialog(
                              context: context,
                              builder: (dialogContext) {
                                return StatefulBuilder(
                                  builder: (context, setDialogState) {
                                    return AlertDialog(
                                      backgroundColor: darkBg,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      title: const Text(
                                        "Edit profile",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.8,
                                        ),
                                      ),
                                      content: SingleChildScrollView(
                                        child: SizedBox(
                                          width: MediaQuery.of(
                                            context,
                                          ).size.width,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Stack(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 50,
                                                    backgroundColor: gray,
                                                    backgroundImage:
                                                        state.profileModel.photoUrl ==
                                                            null
                                                        ? AssetImage(
                                                            "assets/person.jpeg",
                                                          )
                                                        : NetworkImage(
                                                          state.profileModel.photoUrl!,
                                                          ),
                                                  ),
                                                  Positioned(
                                                    bottom: -10,
                                                    right: -10,
                                                    child: IconButton(
                                                      // image picker only
                                                      onPressed: () {
                                                        //   Pick Image From Gallery and upload to supabase
                                                        context
                                                            .read<
                                                              ProfileCubit
                                                            >()
                                                            .uploadImage();
                                                      },
                                                      icon: const Icon(
                                                        Icons.camera_alt,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 16),
                                              const Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "Edit Name",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              CustomTextField(
                                                controller: nameController,
                                                hint:
                                                    state.profileModel.name ??
                                                    "",
                                              ),
                                              const SizedBox(height: 16),
                                              const Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "Edit Email",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              CustomTextField(
                                                controller: emailController,
                                                hint:
                                                    state.profileModel.email ??
                                                    "",
                                              ),
                                              const SizedBox(height: 16),
                                              const Align(
                                                alignment: Alignment.topLeft,
                                                child: Text(
                                                  "Edit Bio",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              CustomTextField(
                                                controller: bioController,
                                                hint:
                                                    state.profileModel.bio ??
                                                    "Bio",
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      actionsAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(dialogContext);
                                          },
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.grey[400],
                                          ),
                                          child: const Text("Cancel"),
                                        ),
                                        // save and upload pic to supabase ... update other info to firestore
                                        ElevatedButton(
                                          onPressed: () {

                                            // Only update the fields that have changed
                                            String name =
                                                nameController.text.isNotEmpty
                                                ? nameController.text
                                                : state.profileModel.name ?? '';

                                            String email =
                                                emailController.text.isNotEmpty
                                                ? emailController.text
                                                : state.profileModel.email ??
                                                      '';

                                            String bio =
                                                bioController.text.isNotEmpty
                                                ? bioController.text
                                                : state.profileModel.bio ?? '';

                                            var updatedProfileModel =
                                                ProfileModel(
                                                  bio: bio,
                                                  name: name,
                                                  email: email,
                                                   photoUrl: state.profileModel.photoUrl
                                                  ,
                                                );

                                            context
                                                .read<ProfileCubit>()
                                                .updateUserData(
                                                  updatedProfileModel,
                                                );
                                            Navigator.pop(dialogContext);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: f1Red,
                                            foregroundColor: Colors.white,
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                          child: const Text("Save"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                          },
                          // Edit Button
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Edit",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(width: 5),
                              Icon(Icons.edit, color: Colors.white),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Avatar
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: gray,
                      backgroundImage:
                         state.profileModel.photoUrl == null
                          ? AssetImage("assets/person.jpeg")
                          : NetworkImage(
                           state.profileModel.photoUrl!,
                            ),
                    ),
                    const SizedBox(height: 20),
                    // name
                    Text(
                      state.profileModel.name ?? "No Name",
                      style: const TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    const SizedBox(height: 5),
                    // email
                    Text(
                      state.profileModel.email ?? "No Email",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    // bio
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                      child: Text(
                        state.profileModel.bio ?? "No Bio",
                        style: const TextStyle(
                          color: Colors.yellow,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 5),
                    // favs
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
                              const Row(
                                children: [
                                  Text(
                                    'Favorite Teams',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  Icon(Icons.favorite, color: f1Red),
                                ],
                              ),
                              const SizedBox(height: 10),
                              BlocBuilder<FavoritesCubit, FavoritesStates>(
                                builder: (context, favState) {
                                  if (favState is FavoritesSuccessState) {
                                    if (favState.favs.isEmpty) {
                                      return const Center(
                                        child: Text(
                                          "Nothing Added To Favorites",
                                          style: TextStyle(color: Colors.white),
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
                                  return const SizedBox.shrink();
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
    );
  }
}
