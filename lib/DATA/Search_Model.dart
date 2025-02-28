class User {
  final String uid;
  final String username;
  final String email;
  final String avatar;
  final String bio;
  final List<String> followers;
  final List<String> following;

  User({
    required this.uid,
    required this.username,
    required this.email,
    required this.avatar,
    required this.bio,
    required this.followers,
    required this.following,
  });

  factory User.fromFirestore(Map<String, dynamic> data, String id) {
    return User(
      uid: id,
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      avatar: data['avatar'] ?? '',
      bio: data['bio'] ?? '',
      followers: List<String>.from(data['followers'] ?? []),
      following: List<String>.from(data['following'] ?? []),
    );
  }
}