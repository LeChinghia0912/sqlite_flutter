class Auth {
  String? userName;
  String? password;
  String? token;

  Auth({this.userName, this.password,  this.token});

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      userName: json['userName'],
      password: json['password'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'password': password,
      'token': token,
    };
  }
}
