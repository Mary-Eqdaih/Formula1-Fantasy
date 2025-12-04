
import 'package:formula1_fantasy/f1/data/models/profile_model.dart';

class ProfileStates {}

class ProfileInitialState extends ProfileStates {}

class ProfileLoadingState extends ProfileStates {}
class ProfileErrorState extends ProfileStates {
  String error;
  ProfileErrorState(this.error);
}

class ProfileSuccessState extends ProfileStates {
  ProfileModel profileModel;
  ProfileSuccessState(this.profileModel);
}
/**
 * ProfileSuccessState: This state represents the success state when the profile data has
 * been successfully fetched. It contains the ProfileModel (which holds the data) as an argument
 *  meaning that this state will carry the profile data to the UI to be displayed.
 */
// When the data is successfully fetched from a data source (e.g., Firestore or an API),
// the state needs to pass this data to the UI.
// ProfileSuccessState doesn't just indicate that the operation was successful;
// it also carries the data that was fetched.
