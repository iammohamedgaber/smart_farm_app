class RegisterModel {
  final String username;
  final String email;
  final String passwordHash;

  RegisterModel({
    required this.username,
    required this.email,
    required this.passwordHash,
  });

  Map<String, dynamic> toJson() {
    return {"Username": username, "Email": email, "PasswordHash": passwordHash};
  }
}
