import 'package:formula1_fantasy/f1/data/models/notes_model.dart';

abstract class NotesState {}

class NotesInitialState extends NotesState {}

class NotesLoadingState extends NotesState {}

class NotesSuccessState extends NotesState {
  final List<NotesModel> notes;
  NotesSuccessState(this.notes);
}

class NotesErrorState extends NotesState {
  final String message;
  NotesErrorState(this.message);
}
