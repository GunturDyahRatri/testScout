class LoginRequest {
  LoginRequest({
    required this.username,
    required this.password,
  });

  String username;
  String password;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = username;
    map['password'] = password;
    return map;
  }
}