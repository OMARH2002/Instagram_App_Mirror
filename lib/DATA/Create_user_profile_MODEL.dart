class CreateUserProfile {
  String name;
  String username;
  String website;
  String bio;
  String email;
  String gender;
  int phone;

  CreateUserProfile({
    required this.name,
    required this.username,
    required this.website,
    required this.bio,
    required this.email,
    required this.gender,
    required this.phone,
  });

  factory CreateUserProfile.fromJson(Map<String, dynamic> json) {
    return CreateUserProfile(
      name: json['name'],
      username: json['username'],
      website: json['website'],
      bio: json['bio'],
      email: json['email'],
      gender: json['gender'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'website': website,
      'bio': bio,
      'email': email,
      'gender': gender,
      'phone': phone,
    };
  }
}