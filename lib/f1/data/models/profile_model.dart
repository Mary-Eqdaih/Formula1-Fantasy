class ProfileModel {
  String? name;
  String? email;
  String? bio;
  String? photoUrl;

  ProfileModel({this.name, this.email, this.bio,
    this.photoUrl
  });
  ProfileModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    bio = json['bio'];
    photoUrl = json['photoUrl'];
    }
  // Data returned from firestore is a map ... so we have to convert it to dart object (ProfileModel)

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['bio'] = bio;
    data['photoUrl'] = photoUrl;
    return data;
  }

  //   to save or update data in firestore so we convert it to a map
}

