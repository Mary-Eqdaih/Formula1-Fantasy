import 'package:formula1_fantasy/f1/data/models/driver_standings_model.dart';

abstract class StandingsStates {}

class StandingsInitialState extends StandingsStates {}

class StandingsLoadingState extends StandingsStates {}

class StandingsSuccessState extends StandingsStates {
  final List<DriverStandingModel> standings;
  StandingsSuccessState(this.standings);
}

class StandingsErrorState extends StandingsStates {
  final String message;
  StandingsErrorState(this.message);
}
