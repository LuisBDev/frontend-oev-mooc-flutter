class User {
  final int id;
  final String name;
  final String lastName;
  final String type;
  final String email;
  final String phone;
  final String secondEmail;
  final String college;
  final String profilePicture;

  User(
      {required this.name,
      required this.id,
      required this.lastName,
      required this.type,
      required this.email,
      required this.phone,
      required this.secondEmail,
      required this.college,
      required this.profilePicture});
  bool get isStudent {
    return type == 'teacher';
  }
}
