import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formula1_fantasy/f1/cubit/fav_states.dart';
import 'package:formula1_fantasy/f1/cubit/favs_cubit.dart';
import 'package:formula1_fantasy/f1/data/models/teams_model.dart';
import 'package:formula1_fantasy/f1/presentation/screens/teams/teams_details.dart';

class TeamsWidget extends StatelessWidget {
  const TeamsWidget({
    super.key,
    required this.team,
    this.isUsedInFavorites = false,
  });

  final TeamsModel team;
  final bool isUsedInFavorites;

  @override
  Widget build(BuildContext context) {
    const cardColor = Color(0xFF18191A);
    const f1Red = Color(0xFFE10600);

    return BlocBuilder<FavoritesCubit, FavoritesStates>(
      builder: (context, state) {
        final cubit = context.read<FavoritesCubit>();
        final bool isFav = cubit.favs.contains(team);

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => TeamDetails(model: team)),
            );
          },
          borderRadius: BorderRadius.circular(14),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: f1Red.withOpacity(0.25), width: 1),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: team.logo.endsWith('.svg')
                        ? SvgPicture.asset(team.logo, fit: BoxFit.contain)
                        : Image.asset(team.logo, fit: BoxFit.contain),
                  ),
                  const SizedBox(width: 25),

                  // Team Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          team.teamName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontFamily: 'TitilliumWeb',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          team.nationality,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontFamily: 'TitilliumWeb',
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "points : ${team.points}",
                          style: const TextStyle(
                            color: Colors.white70,
                            fontFamily: 'TitilliumWeb',
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Favorite Button
                  IconButton(
                    onPressed: () {
                      isFav
                          ? cubit.removeFromFavorites(team)
                          : cubit.addToFavorites(team);
                    },
                    icon: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      color: isFav ? f1Red : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
