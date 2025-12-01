import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formula1_fantasy/f1/cubit/notes_states.dart';
import 'package:formula1_fantasy/f1/data/local/notes_DB.dart';
import 'package:formula1_fantasy/f1/data/models/notes_model.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitialState());

  List<NotesModel> notes = [];

  Future<void> fetchNotes() async {
    emit(NotesLoadingState());
    notes = await NotesDB.getNoteFromDB();
    emit(NotesSuccessState(notes));
  }

  Future<void> addNote(NotesModel note) async {
    int id = await NotesDB.insertNoteToDB(note);
    note = NotesModel(
      title: note.title,
      content: note.content,
      date: note.date,
      id: id,
    );
    notes.add(note);
    emit(NotesSuccessState(List.from(notes)));
  }

  Future<void> updateNote(NotesModel updated) async {
    await NotesDB.updateNoteFromDB(updated);
    int index = notes.indexWhere((n) => n.id == updated.id);
    if (index != -1) notes[index] = updated;
    emit(NotesSuccessState(List.from(notes)));
  }

  void deleteNote(NotesModel note) {
    NotesDB.deleteNoteFromDB(note);
    notes.removeWhere((n) => n.id == note.id);
    emit(NotesSuccessState(List.from(notes)));
  }
}
