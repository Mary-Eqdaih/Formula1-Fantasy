

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formula1_fantasy/f1/cubit/teams_states.dart';
import 'package:formula1_fantasy/f1/data/models/teams_model.dart';
import 'package:formula1_fantasy/f1/data/remote/teams_api.dart';

class TeamsCubit extends Cubit<TeamsState> {
  TeamsCubit() : super(TeamsInitialState());

  List<TeamsModel> teams = [];

  Future<void> fetchTeams() async {
    emit(TeamsLoadingState());
    try {
      teams = await TeamsApi().fetchTeams();
      emit(TeamsSuccessState(teams));
    } catch (e) {
      emit(TeamsErrorState(e.toString()));
    }
  }
}
