import 'package:formula1_fantasy/f1/data/models/driver_model.dart';

abstract class DriversStates {}

class DriversInitialState extends DriversStates {}

class DriversLoadingState extends DriversStates {}

class DriversSuccessState extends DriversStates {
  final Map<String, List<DriverModel>> driversByTeam;
  DriversSuccessState(this.driversByTeam);
}

class DriversErrorState extends DriversStates {
  final String message;
  DriversErrorState(this.message);
}
