import '../data/models/fantasy_model.dart';

class FantasyState {
  final List<FantasyDriversModel> selectedDrivers;
  final double budget;
  final bool isSaved;

  const FantasyState({
    required this.selectedDrivers,
    required this.budget,
    this.isSaved = false,
  });

  // How much of the budget has been spent
  // sum = 0; for each driver: sum += driver.price
  double get spent => selectedDrivers.fold(0.0, (sum, d) => sum + d.price);

  // Remaining budget
  double get remaining => budget - spent;

  // Is the team complete (exactly 5 drivers)?
  bool get isComplete => selectedDrivers.length == 5;

  // Is a specific driver already selected?
  bool isSelected(String driverId) {
    for (var d in selectedDrivers) {
      if (d.id == driverId) return true;
    }
    return false;
  }

  FantasyState copyWith({
    List<FantasyDriversModel>? selectedDrivers,
    double? budget,
    bool? isSaved,
  }) {
    return FantasyState(
      selectedDrivers: selectedDrivers ?? this.selectedDrivers,
      budget: budget ?? this.budget,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}
