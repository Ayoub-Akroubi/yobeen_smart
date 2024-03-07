// ignore_for_file: prefer_if_null_operators, non_constant_identifier_names

class LoginRequestModel {
  late String email_tel;
  late String password;
  LoginRequestModel({
    required this.email_tel,
    required this.password,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'email_tel': email_tel.trim(),
      'password': password.trim(),
    };
    return map;
  }
}

class LoginResponseModel {
  final String token;
  final String error;

  LoginResponseModel({required this.token, required this.error});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      token: json["token"] != null ? json["token"] : "",
      error: json["erreur"] != null ? json["erreur"] : "",
    );
  }
}
