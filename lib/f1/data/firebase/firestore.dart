import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:formula1_fantasy/f1/data/models/profile_model.dart';

class FirestoreService {
  static const String userCollection = "Users";

  // id is document id ... to know where to store data exactly
  static saveUserData(Map<String, dynamic> data, String id) async {
    await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(id)
        .set(data);
  }
  //   writes data in users collection (as a map) ... with doc id ... used when signing up

  static Future<ProfileModel> fetchUserData(String id) async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection(userCollection)
        .doc(id)
        .get();
    if (doc.exists) {
      var data = doc.data() as Map<String, dynamic>;
      var profileModel = ProfileModel.fromJson(data);
      // takes data (map<String,dynamic>) and convert it to dart object (ProfileModel)
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
    // convert dart object into map to save to fire store as a map
  }
}

