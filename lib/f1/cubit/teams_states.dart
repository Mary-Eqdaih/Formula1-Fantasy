import 'package:formula1_fantasy/f1/data/models/teams_model.dart';

abstract class TeamsState {}

class TeamsInitialState extends TeamsState {}

class TeamsLoadingState extends TeamsState {}

class TeamsSuccessState extends TeamsState {
  final List<TeamsModel> teams;
  TeamsSuccessState(this.teams);
}

class TeamsErrorState extends TeamsState {
  final String message;
  TeamsErrorState(this.message);
}
