import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formula1_fantasy/f1/cubit/standings_cubit.dart';
import 'package:formula1_fantasy/f1/cubit/standings_states.dart';
import 'package:formula1_fantasy/f1/presentation/widgets/leaderboard_widget.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  @override
  Widget build(BuildContext context) {
    const darkBg = Color(0xFF0F0F10);
    const f1Red = Color(0xFFE10600);

    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        backgroundColor: darkBg,
automaticallyImplyLeading: false,
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
      body: RefreshIndicator(
        color: f1Red,
        onRefresh: (){
          context.read<StandingsCubit>().fetchStandings();
          return Future.delayed(Duration(seconds: 1));
        },
        child: BlocBuilder<StandingsCubit, StandingsStates>(
          builder: (context, state) {
            if (state is StandingsInitialState) {
              return const SizedBox.shrink();
            }

            if (state is StandingsLoadingState) {
              return const Center(child: CircularProgressIndicator(color: f1Red));
            }

            if (state is StandingsSuccessState) {
              return ListView.builder(
                itemCount: state.standings.length,
                itemBuilder: (context, index) {
                  return LeaderboardWidget(
                    rank: index + 1,
                    driver: state.standings[index],
                  );
                },
              );
            }

            if (state is StandingsErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                     "Can't Load Leaderboard",
                      style: const TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: 10,),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: f1Red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                      ),
                      onPressed: () {

                        context.read<StandingsCubit>().fetchStandings();
                      },
                      child: const Text(
                        "Refresh",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
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
