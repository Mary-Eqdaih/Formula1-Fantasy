import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formula1_fantasy/f1/data/models/teams_model.dart';
import 'package:formula1_fantasy/f1/presentation/providers/f1_provider.dart';
import 'package:formula1_fantasy/routes/routes.dart';
import 'package:provider/provider.dart';

class TeamsWidget extends StatelessWidget {
  const TeamsWidget({
    super.key,
    required this.model,
    this.isUsedInFavorites = false,
  });
  final TeamsModel model;
  final bool isUsedInFavorites;

  @override
  Widget build(BuildContext context) {
    var teamsProvider = Provider.of<F1Provider>(context);
    const cardColor = Color(0xFF18191A);
    const f1Red = Color(0xFFE10600);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.teamDetails, arguments: model);
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
                child: model.logo.endsWith('.svg')
                    ? SvgPicture.asset(model.logo, fit: BoxFit.contain)
                    : Image.asset(model.logo, fit: BoxFit.contain),
              ),
              const SizedBox(width: 25),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      model.teamName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'TitilliumWeb',
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      model.nationality,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontFamily: 'TitilliumWeb',
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "points : ${model.points}",
                      style: const TextStyle(
                        color: Colors.white70,
                        fontFamily: 'TitilliumWeb',
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {
                  if (teamsProvider.favs.contains(model)) {
                    teamsProvider.removeFromFavorites(model);
                  } else {
                    teamsProvider.addToFavorites(model);
                  }
                },
                icon: teamsProvider.favs.contains(model)
                    ? isUsedInFavorites
                          ? Icon(Icons.favorite, color: f1Red)
                          : Icon(Icons.favorite, color: f1Red)
                    : Icon(Icons.favorite_border),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
