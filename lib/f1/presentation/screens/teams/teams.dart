import 'package:flutter/material.dart';
import 'package:formula1_fantasy/f1/presentation/providers/f1_provider.dart';
import 'package:formula1_fantasy/f1/presentation/widgets/teams_widget.dart';
import 'package:provider/provider.dart';

class Teams extends StatelessWidget {
  const Teams({super.key});

  @override
  Widget build(BuildContext context) {
    var teamsProvider = Provider.of<F1Provider>(context);

    const darkBg = Color(0xFF0F0F10);
    return Consumer<F1Provider>(
      builder: (context,provider,child){
         if(provider.teams.isEmpty){
           return  Scaffold(
            backgroundColor: darkBg,
            appBar: AppBar(
              backgroundColor: darkBg,
              title: Text(
                "Teams",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
              ),
            ),
            body: const Center(
              child: CircularProgressIndicator(),  // Loading spinner
            ),
          );
        }
return  Scaffold(
           backgroundColor: darkBg,
           appBar: AppBar(
             backgroundColor: darkBg,
             title: Text(
               "Teams",
               style: TextStyle(
                 color: Colors.white,
                 fontSize: 20,
                 fontWeight: FontWeight.w600,
                 letterSpacing: 0.8,
               ),
             ),
           ),
           body: ListView.builder(
             itemCount: teamsProvider.teams.length,
             itemBuilder: (context, index) {
               return TeamsWidget(model: teamsProvider.teams[index]);
             },
           ),
         );
      },
    );
      }


  }

