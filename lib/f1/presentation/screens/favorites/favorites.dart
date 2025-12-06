import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formula1_fantasy/f1/cubit/auth_cubit.dart';
import 'package:formula1_fantasy/f1/cubit/fav_states.dart';
import 'package:formula1_fantasy/f1/cubit/favs_cubit.dart';
import 'package:formula1_fantasy/f1/cubit/profile_cubit.dart';
import 'package:formula1_fantasy/f1/cubit/profile_states.dart';
import 'package:formula1_fantasy/f1/presentation/widgets/teams_widget.dart';
import 'package:formula1_fantasy/routes/routes.dart';

class Favorites extends StatelessWidget {
  const Favorites({super.key});

  @override
  Widget build(BuildContext context) {
    const darkBg = Color(0xFF0F0F10);
    const f1Red = Color(0xFFE10600);


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
            icon: Icon(Icons.notifications, color: Colors.white),
          ),
          BlocBuilder<ProfileCubit,ProfileStates>(
            builder: (BuildContext context, ProfileStates state) {
              if(state is ProfileLoadingState){
                return CircularProgressIndicator(color: f1Red,);
              }
              if(state is ProfileSuccessState){
                return InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.profile);
                  },
                  child: CircleAvatar(
                    radius: 10,
                    backgroundImage: state.profileModel.photoUrl==null?AssetImage("assets/person.jpeg"):
                    NetworkImage(
                        state.profileModel.photoUrl!
                    ),
                  ),
                );
              }
              return SizedBox.shrink();
            },

          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) async {
              switch (value) {
                case 'about':
                  Navigator.pushNamed(context, Routes.aboutF1); // open About F1
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
      body:
           BlocBuilder<FavoritesCubit,FavoritesStates>(
             builder: (context,state ){
               if(state is FavoritesSuccessState){
                 if(state.favs.isEmpty){
                   return Center(child: Text("Nothing Added To Favorites",style: TextStyle(color: Colors.white),),);
                 }

                 return   Padding(
                   padding: const EdgeInsets.all(16.0),
                   child: Column(
                     children: [
                       const Padding(
                         padding: EdgeInsets.all(16.0),
                         child: Align(alignment: AlignmentGeometry.topLeft,
                           child: Text(
                             "Your Favorite Teams",  // Title for the screen
                             style: TextStyle(
                               color: Colors.white,
                               fontSize: 22,
                               fontWeight: FontWeight.bold,
                             ),
                           ),
                         ),
                       ),
                       Expanded(
                         child: ListView.builder(
                           itemCount: state.favs.length,
                           itemBuilder: (context, index) {
                             return TeamsWidget(team: state.favs[index],isUsedInFavorites: true, );
                           },
                         ),
                       ),
                     ],
                   ),
                 );
               }
               return SizedBox.shrink();
             },

           ),


    );
  }
}
