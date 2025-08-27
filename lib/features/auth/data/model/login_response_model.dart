class LoginResponseModel {
  int? status;
  String? message;
  String? token;
  String? userName;

  LoginResponseModel({this.status, this.message, this.token, this.userName});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    userName = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['token'] = token;
    data['user_name'] = userName;
    return data;
  }
}
