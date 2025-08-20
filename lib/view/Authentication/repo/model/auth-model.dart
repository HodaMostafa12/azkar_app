class UserModel {
  final String id;
  final String email;
  final String username;

  UserModel({required this.id, required this.email, required this.username});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      username: map['username']?? ''
    );
  }
}
