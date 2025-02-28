class UserModel {
  final String uid;
  final String name;
  final String username;
  final String avatar;


  UserModel({
    required this.uid,
    required this.name,
    required this.username,
    required this.avatar,

  });

  // Convert UserModel to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'username': username,
      'avatar': avatar,


    };
  }

  // Factory constructor to create a UserModel from Firestore
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      username: map['username'] ?? '',
      avatar: map['avatar'] ?? '',

    );
  }
}
