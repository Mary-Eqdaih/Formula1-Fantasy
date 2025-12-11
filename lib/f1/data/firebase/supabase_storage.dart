//
// import 'dart:io';
// import 'package:firebase_storage/supabase_storage.dart';
// import 'package:image_picker/image_picker.dart';
//
// class ImageService {
//   // Function to pick an image from the gallery
//   Future<String?> pickImage() async {
//     final ImagePicker _picker = ImagePicker();
//     // Pick an image from the gallery
//     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//
//     if (image != null) {
//       return image.path;  // Return the file path of the selected image
//     }
//     return null;
//   }
//
//   // Function to upload an image to Firebase Storage and return the URL
//   Future<String?> uploadProfileImage(File imageFile) async {
//     try {
//       // Generate a unique file name for the image
//       String fileName = 'profile_pictures/${DateTime.now().millisecondsSinceEpoch}.jpg';
//
//       // Upload the image to Firebase Storage
//       Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
//       UploadTask uploadTask = storageReference.putFile(imageFile);
//
//       // Wait for the upload to complete
//       TaskSnapshot snapshot = await uploadTask;
//
//       // Get the image URL after upload
//       String downloadUrl = await snapshot.ref.getDownloadURL();
//
//       return downloadUrl;
//     } catch (e) {
//       print("Error uploading image: $e");
//       return null;
//     }
//   }
// }
