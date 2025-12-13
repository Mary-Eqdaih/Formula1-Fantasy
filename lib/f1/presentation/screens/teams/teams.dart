import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formula1_fantasy/f1/cubit/favs_cubit.dart';
import 'package:formula1_fantasy/f1/cubit/teams_cubit.dart';
import 'package:formula1_fantasy/f1/cubit/teams_states.dart';
import 'package:formula1_fantasy/f1/presentation/widgets/teams_widget.dart';

class Teams extends StatelessWidget {
  const Teams({super.key});

  @override
  Widget build(BuildContext context) {
    const darkBg = Color(0xFF0F0F10);
    const f1Red = Color(0xFFE10600);
    return Scaffold(
      backgroundColor: darkBg,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: darkBg,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Teams",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: (){
          context.read<TeamsCubit>().fetchTeams();
          return Future.delayed(Duration(seconds: 1));
        },
        color: f1Red,
        child: BlocBuilder<TeamsCubit, TeamsState>(
          builder: (context, state) {
            if (state is TeamsLoadingState) {
              return const Center(child: CircularProgressIndicator(color: f1Red));
            }

            if (state is TeamsSuccessState) {
              final favoritesCubit = context.read<FavoritesCubit>();
              favoritesCubit.setTeams(state.teams);
              // state.teams is the list of teams that were successfully fetched from the TeamsCubit
              // store this list of teams in the FavoritesCubit
              favoritesCubit.loadFavorites();
              return ListView.builder(
                itemCount: state.teams.length,
                itemBuilder: (context, index) {
                  return TeamsWidget(team: state.teams[index]);
                },
              );
            }


            if (state is TeamsErrorState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Can't Load Teams",
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

                        context.read<TeamsCubit>().fetchTeams();
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

            return const SizedBox.shrink(); // Fallback for other states
          },
        ),
      ),
    );
  }
}
