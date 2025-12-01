import 'package:formula1_fantasy/f1/data/models/teams_model.dart';

abstract class FavoritesStates {}

class FavoritesInitialState extends FavoritesStates {}
class FavoritesLoadingState extends FavoritesStates {}

class FavoritesSuccessState extends FavoritesStates {
  final List<TeamsModel> favs;
  FavoritesSuccessState(this.favs);
}

class FavoritesErrorState extends FavoritesStates {
  final String message;
  FavoritesErrorState(this.message);
}
