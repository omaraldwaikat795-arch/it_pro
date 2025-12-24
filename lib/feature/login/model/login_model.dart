    import 'package:it_pro/feature/login/model/user_model.dart' show UserModel;

    class LoginModel {
      List<UserModel>? table;

      LoginModel({this.table});

      LoginModel.fromJson(Map<String, dynamic> json) {
        if (json['Table'] != null) {
          table = <UserModel>[];
          json['Table'].forEach((v) {
            table!.add(UserModel.fromJson(v));
          });
        }
      }
    }