import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formula1_fantasy/f1/cubit/drivers_states.dart';
import 'package:formula1_fantasy/f1/data/models/driver_model.dart';
import 'package:formula1_fantasy/f1/data/remote/drivers_api.dart';

class DriversCubit extends Cubit<DriversStates> {
  DriversCubit() : super(DriversInitialState());

  Map<String, List<DriverModel>> driversByTeam = {};

  Future<void> fetchDriversFor(String constructorId) async {
    emit(DriversLoadingState());

    try {
      if (!driversByTeam.containsKey(constructorId)) {
        driversByTeam[constructorId] =
        await DriversApi().fetchDrivers(constructorId);
      }

      emit(DriversSuccessState(driversByTeam));
    } catch (e) {
      emit(DriversErrorState(e.toString()));
    }
  }
}
