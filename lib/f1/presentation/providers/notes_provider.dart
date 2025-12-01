// import 'package:flutter/material.dart';
// import 'package:formula1_fantasy/f1/data/local/notes_DB.dart';
// import 'package:formula1_fantasy/f1/data/models/notes_model.dart';
//
// class NotesProvider extends ChangeNotifier {
//   List<NotesModel> notes = [];
//
//   void addNote(NotesModel note) async {
//     int id = await NotesDB.insertNoteToDB(note);
//     note = NotesModel(
//       title: note.title,
//       content: note.content,
//       date: note.date,
//       id: id,
//     );
//     // You rebuild the NotesModel object to include the id that came from the database.
//     // in NotesModel it was 0 by default
//
//     notes.add(note);
//     notifyListeners();
//   }
//
//   void updateNote(NotesModel updatedNote) {
//     NotesDB.updateNoteFromDB(updatedNote);
//     int index = notes.indexWhere((note) => note.id == updatedNote.id);
//     if (index != -1) {
//       notes[index] = updatedNote;
//     }
//     // Looks for the position (index) of the note inside your local notes list whose id matches the one you just updated.
//     // indexWhere returns the index number of the matching item, or -1 if not found.
//     notifyListeners();
//   }
//
//   void deleteNote(NotesModel noteModel) {
//     NotesDB.deleteNoteFromDB(noteModel);
//     notes.removeWhere((note) => note.id == noteModel.id);
//     // removeWhere() goes through every note in the list and deletes any whose id matches the one you just deleted.
//     notifyListeners();
//   }
//
//   void fetchNotes() async {
//     var fetchedNotes = await NotesDB.getNoteFromDB();
//     notes = fetchedNotes;
//     notifyListeners();
//   }
//
// }
