class LoginModel {
  final String email;
  final String passwordHash;

  LoginModel({
    required this.email,
    required this.passwordHash,
  });

  Map<String, dynamic> toJson() {
    return {
      "Email": email,
      "PasswordHash": passwordHash,
    };
  }
}