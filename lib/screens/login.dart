import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:it_pro/core/const/api_const.dart';
import 'package:it_pro/core/units/db_helper.dart';
import 'package:it_pro/core/units/shared_preferences.dart';
import 'package:it_pro/screens/data_screen.dart';
import 'package:it_pro/screens/login.dart';
import 'package:it_pro/screens/login2.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

TextEditingController userController = TextEditingController();

TextEditingController passwordController = TextEditingController();

class _LoginState extends State<Login> {
  @override
  bool isPassword = true;
  List<String> allowedUsers = ["0790718552", "123456","0799999999", "123456","0776305523","456789"];

  void tryLogin(String input) {
    String phone = input.trim();

    if (allowedUsers.contains(phone)) {
      print("مسموح بالدخول ✅");
    } else {
      print("هذا الرقم غير مسموح ❌");
    }
  }

  Future<void> Login({required String phone, required String password}) async {
    if (!allowedUsers.contains(phone)) {
      //print("هذا المستخدم غير مسموح له بالدخول");
      return;
    }
    print("login");
    print(ApiConst.Login);
    try {
      final body = {"phone": phone, "password": password};
      final response = await http.post(
        Uri.parse(ApiConst.Login),
        body: jsonEncode({"phone": phone, "password": password}),
        headers: {'Content-Type': 'application/json'},
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        String token = result['access_token'];
        String user_id = result['user']['id'].toString();
        String user_username = result['user']['username'];
        String user_useremail = result['user']['email'];
        String user_phone = result['user']['phone'];
        String user_role = result['user']['role'];
        SharedPreferencesHelper.saveString("token", token);
        SharedPreferencesHelper.saveString("id", user_id);
        SharedPreferencesHelper.saveString("name", user_username);
        SharedPreferencesHelper.saveString("email", user_useremail);
        SharedPreferencesHelper.saveString("phone", user_phone);
        SharedPreferencesHelper.saveString("role", user_role);
        print("is tokin : $token");
        print("is user_id : $user_id");
        print("is user_username : $user_username");
        print("is user_useremail : $user_useremail");
        print("is user_phone : $user_phone");
        print("is user_role : $user_role");

        await DbHelper.dbHelper.insertItem({'name': phone, 'price': password});
        print("token is : $token");
        SharedPreferencesHelper.saveString("token", token);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DataScreen()),
        );
      }
    } catch (e) {
      print(e);
    }
  }

  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Login", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF1E5AA8),
      ),

      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.005),
              Column(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        "assest/image/download.png",
                        width: 270,
                        height: height * 0.30,
                      ),

                      SizedBox(height: 10),
                      Text(
                        "",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.002),
                  SizedBox(height: height * 0.00),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      controller: userController,
                      decoration: InputDecoration(
                        label: Text("user name"),
                        hintText: "pleas enter user",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.02),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextField(
                      obscureText: isPassword,
                      controller: passwordController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPassword = !isPassword;
                            });
                          },
                          icon: Icon(Icons.remove_red_eye),
                        ),
                        label: Text("password"),
                        hintText: "password",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.02),
                  InkWell(
                    onTap: () async {
                      if (userController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty) {
                        await Login(
                          phone: userController.text,
                          password: passwordController.text,
                        );
                      }
                    },
                    child: Container(
                      height: height * 0.05,
                      width: width * 0.88,
                      decoration: BoxDecoration(
                        color: Color(0xFF1E5AA8),
                        borderRadius: BorderRadius.circular(10),
                      ),

                      child: Center(
                        child: Text(
                          "login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
