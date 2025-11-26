import 'package:flutter/material.dart';
import 'package:formula1_fantasy/f1/data/models/teams_model.dart';
import 'package:formula1_fantasy/f1/presentation/providers/f1_provider.dart';
import 'package:formula1_fantasy/routes/routes.dart';
import 'package:provider/provider.dart';  // Make sure to import your TeamsModel class

class ProfileFavoriteTeamWidget extends StatelessWidget {
  final TeamsModel team;

  const ProfileFavoriteTeamWidget({super.key, required this.team});

  @override
  Widget build(BuildContext context) {
    var teamsProvider = Provider.of<F1Provider>(context);

    const darkBg = Color(0xFF0F0F10);

    return InkWell(
      onTap: (){
        Navigator.pushNamed(context, Routes.teamDetails,arguments: team);
      },
      child: Card(

        color: darkBg,
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12), // Margin between the cards
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between name and points
            children: [
              // Team Name
              Text(
                team.teamName, // Display team name
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              // Team Points
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Text(
              "${team.points} points", // Display points
              style: TextStyle(color: Colors.yellow, fontSize: 14),
            ),
            SizedBox(width: 10,),
            IconButton(
              onPressed: () {
              if (teamsProvider.favs.contains(team)) {
                teamsProvider.removeFromFavorites(team);
              } else {
                teamsProvider.addToFavorites(team);
              }
            },
                icon: Icon(Icons.minimize,fontWeight: FontWeight.w900,))

          ],)
            ],
          ),
        ),
      ),
    );
  }
}
