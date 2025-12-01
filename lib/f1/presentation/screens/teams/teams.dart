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
      body: BlocBuilder<TeamsCubit, TeamsState>(
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
            return const Center(
              child: Text(
                'Could not load teams.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return const SizedBox.shrink(); // Fallback for other states
        },
      ),
    );
  }
}
