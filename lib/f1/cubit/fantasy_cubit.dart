import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formula1_fantasy/f1/data/models/fantasy_model.dart';

import '../data/local/local_storage.dart';
import 'fantasy_states.dart';

class FantasyCubit extends Cubit<FantasyState> {
  static const int maxDrivers = 5;
  static const double totalBudget = 100.0;

  FantasyCubit()
      : super(const FantasyState(selectedDrivers: [], budget: totalBudget)) {
    _loadSavedTeam();
  }

  String? get _userId => FirebaseAuth.instance.currentUser?.uid;

  // Toggle a driver (add if not selected, remove if selected)
  void toggleDriver(FantasyDriversModel model) {
    final current = List<FantasyDriversModel>.from(state.selectedDrivers);

    if (state.isSelected(model.id)) {
      // Remove driver
      current.removeWhere((d) => d.id == model.id);
      emit(state.copyWith(selectedDrivers: current, isSaved: false));
    } else {
      // Guard: max 5 drivers
      if (current.length >= maxDrivers) return;

      // Guard: not enough budget
      if (state.remaining < model.price) return;

      current.add(model);
      emit(state.copyWith(selectedDrivers: current, isSaved: false));
    }
  }

  Future<void> saveTeam() async {
    final uid = _userId;
    if (uid == null) return;

    final ids = state.selectedDrivers.map((d) => d.id).toList();
    await LocalStorageData.saveFantasyTeam(uid, ids);
    emit(state.copyWith(isSaved: true));
  }

  Future<void> clearTeam() async {
    final uid = _userId;
    if(uid == null) return;

    await LocalStorageData.clearTeam(uid);
    emit(const FantasyState(selectedDrivers: [], budget: totalBudget));
  }

  Future<void> _loadSavedTeam() async {
    final uid = _userId;
    if (uid == null) return;

    final ids = await LocalStorageData.loadFantasyTeam(uid);
    if (ids == null) return;

    final saved = FantasyDriverData.drivers
        .where((d) => ids.contains(d.id))
        .toList();

    emit(state.copyWith(selectedDrivers: saved, isSaved: true));
  }
}
