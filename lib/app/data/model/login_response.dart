class LoginResponse {
  String? token;
  int? code;
  String? message;

  LoginResponse({this.token, this.code, this.message});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    code = json['code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = token;
    data['code'] = code;
    data['message'] = message;

    return data;
  }
}