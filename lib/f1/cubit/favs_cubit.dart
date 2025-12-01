
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formula1_fantasy/f1/cubit/fav_states.dart';
import 'package:formula1_fantasy/f1/data/local/local_storage.dart' show LocalStorageData;
import 'package:formula1_fantasy/f1/data/models/teams_model.dart';

class FavoritesCubit extends Cubit<FavoritesStates> {
  FavoritesCubit() : super(FavoritesInitialState());

  List<TeamsModel> favs = [];
  List<TeamsModel> teams = [];

  void setTeams(List<TeamsModel> loadedTeams) {
    teams = loadedTeams;
  }

  Future<void> loadFavorites() async {
    final savedIds = await LocalStorageData.loadFavorites();
    favs = teams.where((t) => savedIds.contains(t.constructorId)).toList();
    emit(FavoritesSuccessState(favs));
  }

  Future<void> addToFavorites(TeamsModel team) async {
    favs.add(team);
    await saveFavorites();
    emit(FavoritesSuccessState(List.from(favs)));
  }

  Future<void> removeFromFavorites(TeamsModel team) async {
    favs.remove(team);
    await saveFavorites();
    emit(FavoritesSuccessState(List.from(favs)));
  }

  Future<void> saveFavorites() async {
    final ids = favs.map((t) => t.constructorId).toList();
    await LocalStorageData.saveFavorites(ids);
  }
}
