import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formula1_fantasy/f1/cubit/fav_states.dart';
import 'package:formula1_fantasy/f1/data/local/local_storage.dart' show LocalStorageData;
import 'package:formula1_fantasy/f1/data/models/teams_model.dart';
import 'package:formula1_fantasy/f1/data/firebase/firestore.dart';

class FavoritesCubit extends Cubit<FavoritesStates> {
  FavoritesCubit() : super(FavoritesInitialState());

  List<TeamsModel> favs = [];
  List<TeamsModel> teams = [];

  String? get _userId => FirebaseAuth.instance.currentUser?.uid;

  void setTeams(List<TeamsModel> loadedTeams) {
    teams = loadedTeams;
  }

  Future<void> loadFavorites() async {
    final uid = _userId;
    if (uid == null) return;
    
    // 1. Load from local storage
    final savedIds = await LocalStorageData.loadFavorites(uid);

    favs = teams.where((t) => savedIds.contains(t.constructorId)).toList();
    emit(FavoritesSuccessState(favs));
  }

  Future<void> addToFavorites(TeamsModel team) async {
    if (!favs.contains(team)) {
      favs.add(team);
      await saveFavorites();
      emit(FavoritesSuccessState(List.from(favs)));
    }
  }

  Future<void> removeFromFavorites(TeamsModel team) async {
    favs.remove(team);
    await saveFavorites();
    emit(FavoritesSuccessState(List.from(favs)));
  }

  Future<void> saveFavorites() async {
    final uid = _userId;
    if (uid == null) return;

    final ids = favs.map((t) => t.constructorId).toList();

    await LocalStorageData.saveFavorites(uid, ids);
    await FirestoreService.updateFavorites(uid, ids);
  }
}
