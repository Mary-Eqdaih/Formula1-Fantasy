

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formula1_fantasy/f1/cubit/standings_states.dart' ;
import 'package:formula1_fantasy/f1/data/models/driver_standings_model.dart';
import 'package:formula1_fantasy/f1/data/remote/driver_standings_api.dart';

class StandingsCubit extends Cubit<StandingsStates> {
  StandingsCubit() : super(StandingsInitialState());

  List<DriverStandingModel> standings = [];

  Future<void> fetchStandings() async {
    emit(StandingsLoadingState());
    try {
      standings = await DriverStandingsApi.fetchSeasonStandings();
      emit(StandingsSuccessState(standings));
    } catch (e) {
      emit(StandingsErrorState(e.toString()));
    }
  }
}
