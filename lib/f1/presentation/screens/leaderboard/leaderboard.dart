import 'package:flutter/material.dart';
import 'package:formula1_fantasy/f1/presentation/providers/f1_provider.dart';
import 'package:formula1_fantasy/f1/presentation/widgets/leaderboard_widget.dart';
import 'package:provider/provider.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {

  @override
  Widget build(BuildContext context) {
    var driversStandingsProvider = Provider.of<F1Provider>(context);
    const darkBg = Color(0xFF0F0F10);
    const f1Red = Color(0xFFE10600);


    return Consumer<F1Provider>(
      builder: (context,provider,child){
        if(provider.driversStanding.isEmpty){
          return Scaffold(
            backgroundColor: darkBg,
            appBar: AppBar(
              backgroundColor: darkBg,
              title: Text(
                "Leaderboard",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            body: const Center(child: CircularProgressIndicator(color: f1Red,)),
          );
        }
        return Scaffold(
            backgroundColor: darkBg,
            appBar: AppBar(
              backgroundColor: darkBg,

              title: Text(
                "Leaderboard",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            body: ListView.builder(
                itemCount: driversStandingsProvider.driversStanding.length,
                itemBuilder: (context,index){
                  return LeaderboardWidget(rank: index+1, driver: driversStandingsProvider.driversStanding[index]);
                })
        );
      },

    );
  }
}
