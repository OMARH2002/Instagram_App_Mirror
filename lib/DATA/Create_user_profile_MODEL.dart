class CreateUserProfileModel {
  String name;
  String username;
  String? website;
  String bio;
  String email;
  String gender;
  String phone;
  String userID;
  String category;

  CreateUserProfileModel({
    required this.name,
    required this.username,
    this.website,
    required this.bio,
    required this.email,
    required this.gender,
    required this.phone,
    required this.userID,
    required this.category
  });

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
      category: json['category']

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
      'userID':userID,
      'category':category
    };
  }
}