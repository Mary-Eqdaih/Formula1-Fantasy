import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:formula1_fantasy/f1/data/models/notes_model.dart';
import 'package:formula1_fantasy/f1/data/models/profile_model.dart';

class FirestoreService {
  static const String userCollection = "Users";
  static const String notesCollection = "notes";

  // id is document id ... to know where to store data exactly
  static saveUserData(Map<String, dynamic> data, String id) async {
    await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(id)
        .set(data);
  }

  static Future<ProfileModel> fetchUserData(String id) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(id)
        .get();
    if (doc.exists) {
      var data = doc.data() as Map<String, dynamic>;
      var profileModel = ProfileModel.fromJson(data);
      return profileModel;
    } else {
      throw Exception("User Data Not Found");
    }
  }

  static updateUserData(ProfileModel newProfileModel, String id) async {
    await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(id)
        .update(newProfileModel.toMap());
  }

  static Future<void> updatePhotoUrl(String uid, String newPhotoUrl) async {
    try {
      await FirebaseFirestore.instance
          .collection(userCollection)
          .doc(uid)
          .update({
        'photoUrl': newPhotoUrl,
      });
      print("Profile photo updated successfully!");
    } catch (e) {
      print("Error updating profile photo: $e");
      throw Exception("Failed to update profile photo");
    }
  }

  static Future<void> deleteUserData(String uid) async {
    try {
      await FirebaseFirestore.instance
          .collection(userCollection)
          .doc(uid)
          .delete();
      print("User data deleted successfully!");
    } catch (e) {
      print("Error deleting user data: $e");
      throw Exception("Failed to delete user data");
    }
  }

  // Favorites Persistence in firestore
  static Future<void> updateFavorites(String uid, List<String> favoriteIds) async {
    await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(uid)
        .update({'favorites': favoriteIds});
  }

  // Notes Persistence (Sub-collection) in firestore
  static Future<void> addNoteToCloud(String uid, NotesModel note) async {
    // We use the local ID as the document ID to keep them synced
    await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(uid)
        .collection(notesCollection)
        .doc(note.id.toString())
        .set(note.toJson());
  }

  static Future<void> updateNoteInCloud(String uid, NotesModel note) async {
    await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(uid)
        .collection(notesCollection)
        .doc(note.id.toString())
        .update(note.toJson());
  }

  static Future<void> deleteNoteFromCloud(String uid, int noteId) async {
    await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(uid)
        .collection(notesCollection)
        .doc(noteId.toString())
        .delete();
  }

  static Future<List<NotesModel>> fetchNotesFromCloud(String uid) async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(uid)
        .collection(notesCollection)
        .get();

    return querySnapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      // Ensure the ID from the document is put back into the model
      data['id'] = int.parse(doc.id);
      return NotesModel.fromJson(data);
    }).toList();
  }
}
