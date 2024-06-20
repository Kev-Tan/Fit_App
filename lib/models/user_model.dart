class UserModel {
  String uid;
  String? username;
  String? email;

  UserModel({required this.uid, this.username, this.email});

  factory UserModel.fromMap(Map<String, dynamic> data, String uid) {
    return UserModel(
      uid: uid,
      username: data['username'],
      email: data['email'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
    };
  }
}
