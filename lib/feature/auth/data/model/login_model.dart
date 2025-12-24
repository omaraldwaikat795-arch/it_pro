// import 'package:it_pro/feature/auth/data/model/user_model.dart';
// import 'package:it_pro/feature/login/model/user_model.dart';
//
// class LoginModel {
//   bool? result;
//   String? accessToken;
//   String? refreshToken;
//   UserModel? response_body;
//
//   LoginModel({this.result, this.accessToken, this.refreshToken, this.response_body});
//
//   LoginModel.fromJson(Map<String, dynamic> json) {
//     result = json['result'];
//     accessToken = json['access_token'];
//     refreshToken = json['refresh_token'];
//     response_body = json['user'] != null ? new UserModel.fromJson(json['user']) : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['result'] = this.result;
//     data['access_token'] = this.accessToken;
//     data['refresh_token'] = this.refreshToken;
//     if (this.response_body != null) {
//       data['user'] = this.response_body!.toJson();
//     }
//     return data;
//   }
// }