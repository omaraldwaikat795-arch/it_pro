import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
 import 'package:it_pro/feature/auth/presentation/state/login_state.dart';
import 'package:it_pro/feature/login/model/login_model.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(OnInitialLoginState());

  void login({required String username, required String password}) async {
    emit(OnLoadingLoginState());

    try {
       final url = Uri.parse(
        "http://itprojo.dyndns.org:122/api/ITProJo?"
            "userName=$username&password=$password&Demo=false"
            "&UK=ffffffff-a91f-16b6-0000-00004f47da4b&CompName=Demo",
      );

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data.containsKey("Table") && (data["Table"] as List).isNotEmpty) {
          final userJson = data["Table"][0];
          final userModel = LoginModel.fromJson(userJson);


          emit(OnLoadedLoginState(user: userModel));
        } else {
          emit(OnErrorLoginState("No user found in response"));
        }
      } else {
        emit(OnErrorLoginState("Error: ${response.statusCode}"));
      }
    } catch (e) {
      emit(OnErrorLoginState(e.toString()));
    }
  }
}
