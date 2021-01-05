class RegResponseModel {
  final String token;
  final String error;
  final int id;
  RegResponseModel({this.id, this.token, this.error});
  factory RegResponseModel.fromJson(Map<String, dynamic> json) {
    return RegResponseModel(
      id: json["id"] != null ? json["id"] : "",
      token: json["token"] != null ? json["token"] : "",
      error: json["error"] != null ? json["error"] : "",
    );
  }
}

class RegRequestModel {
  String email;
  String password;
  RegRequestModel({
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "email": email.trim(),
      "password": password.trim(),
    };
    return map;
  }
}
