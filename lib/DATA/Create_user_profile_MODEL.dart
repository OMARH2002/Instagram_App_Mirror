class CreateUserProfileModel {
  String name;
  String username;
  String website;
  String bio;
  String email;
  String gender;
  String phone;
  String userID;
  String category;
  String? avatar; // New field for avatar URL

  CreateUserProfileModel({
    required this.name,
    required this.username,
    required this.website,
    required this.bio,
    required this.email,
    required this.gender,
    required this.phone,
    required this.userID,
    required this.category,
    this.avatar, // Make avatar optional
  });

  // Convert Firestore JSON to CreateUserProfileModel
  factory CreateUserProfileModel.fromJson(Map<String, dynamic> json) {
    return CreateUserProfileModel(
      name: json['name'],
      username: json['username'],
      website: json['website'],
      bio: json['bio'],
      email: json['email'],
      gender: json['gender'],
      phone: json['phone'],
      userID: json['userID'],
      category: json['category'],
      avatar: json['avatar'], // Load avatar from Firestore
    );
  }

  // Convert CreateUserProfileModel to JSON for Firestore
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'username': username,
      'website': website,
      'bio': bio,
      'email': email,
      'gender': gender,
      'phone': phone,
      'userID': userID,
      'category': category,
      'avatar': avatar, // Save avatar URL in Firestore
    };
  }
}
