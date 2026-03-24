import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formula1_fantasy/f1/cubit/notes_states.dart';
import 'package:formula1_fantasy/f1/data/local/notes_DB.dart';
import 'package:formula1_fantasy/f1/data/models/notes_model.dart';
import 'package:formula1_fantasy/f1/data/firebase/firestore.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitialState());

  List<NotesModel> notes = [];

  String? get _userId => FirebaseAuth.instance.currentUser?.uid;

  Future<void> fetchNotes() async {
    final uid = _userId;
    if (uid == null) {
      emit(NotesInitialState());
      return;
    }

    // Only show loading if we don't have notes yet to avoid flickering
    if (notes.isEmpty) {
      emit(NotesLoadingState());
    }

    try {
      // 1. Try to load from local DB first
      notes = await NotesDB.getNoteFromDB(uid);

      if (notes.isNotEmpty) {
        // If we have local data, show it immediately for a fast experience
        emit(NotesSuccessState(List.from(notes)));
      } else {
        // 2. If local is empty, we MUST check the cloud before showing the "Empty" message
        final cloudNotes = await FirestoreService.fetchNotesFromCloud(uid);
        
        if (cloudNotes.isNotEmpty) {
          // Save cloud notes to local DB so they are available offline next time
          for (var note in cloudNotes) {
            await NotesDB.insertNoteToDB(note);
          }
          // Re-fetch from local to get the correct IDs
          notes = await NotesDB.getNoteFromDB(uid);
        }
        
        // Now emit success. If notes is still empty, the UI will show the "No race notes" message.
        emit(NotesSuccessState(List.from(notes)));
      }
    } catch (e) {
      print("Fetch error: $e");
      if (notes.isEmpty) {
        emit(NotesErrorState("Failed to load notes: $e"));
      }
    }
  }

  Future<void> addNote(String title, String content, String date) async {
    final uid = _userId;
    if (uid == null) return;

    final tempNote = NotesModel(
      title: title,
      content: content,
      date: date,
      userId: uid,
    );

    try {
      // 1. Save locally first to get an ID
      int id = await NotesDB.insertNoteToDB(tempNote);
      
      final newNote = NotesModel(
        title: title,
        content: content,
        date: date,
        userId: uid,
        id: id,
      );
      
      // 2. Update UI IMMEDIATELY (Optimistic Update)
      notes.insert(0, newNote); // Put the newest note at the top
      emit(NotesSuccessState(List.from(notes)));
      
      // 3. Sync to cloud in background
      FirestoreService.addNoteToCloud(uid, newNote).catchError((e) {
        print("Cloud sync failed: $e");
      });
    } catch (e) {
      print("Add note error: $e");
      emit(NotesErrorState("Could not save note locally"));
    }
  }

  Future<void> updateNote(NotesModel updated) async {
    final uid = _userId;
    if (uid == null) return;

    try {
      // 1. Update UI immediately
      int index = notes.indexWhere((n) => n.id == updated.id);
      if (index != -1) {
        notes[index] = updated;
        emit(NotesSuccessState(List.from(notes)));
      }

      // 2. Update locally
      await NotesDB.updateNoteFromDB(updated);
      
      // 3. Update cloud in background
      FirestoreService.updateNoteInCloud(uid, updated).catchError((e) {
        print("Cloud update failed: $e");
      });
    } catch (e) {
      print("Update note error: $e");
    }
  }

  void deleteNote(NotesModel note) async {
    final uid = _userId;
    if (uid == null) return;

    try {
      // 1. Update UI immediately
      notes.removeWhere((n) => n.id == note.id);
      emit(NotesSuccessState(List.from(notes)));

      // 2. Delete locally
      await NotesDB.deleteNoteFromDB(note);
      
      // 3. Delete from cloud in background
      FirestoreService.deleteNoteFromCloud(uid, note.id).catchError((e) {
        print("Cloud delete failed: $e");
      });
    } catch (e) {
      print("Delete note error: $e");
    }
  }
}
