import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:it_pro/core/const/api_const2.dart';
import 'package:it_pro/core/units/shared_preferance.dart';
import 'package:it_pro/feature/auth/presentation/view/login/login2.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPassword = true;
  bool isLoading = false;

  Future<void> loginUser() async {
    final username = userController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter username and password"),
          backgroundColor: Color(0xFF1E5AA8),
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final uri = Uri.parse(ApiConst2.Login).replace(
        queryParameters: {
          "userName": username,
          "password": password,
          "Demo": "false",
          "UK": "ffffffff-a91f-16b6-0000-00004f47da4b",
          "CompName": "Demo",
        },
      );

      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse.containsKey("Table") &&
            jsonResponse["Table"] is List &&
            (jsonResponse["Table"] as List).isNotEmpty) {
          final user = jsonResponse["Table"][0];

           await SharedPreferencesHelper.saveString("id", user["Id"].toString());
          await SharedPreferencesHelper.saveString("name", user["Name"] ?? "");
          await SharedPreferencesHelper.saveString("username", user["UserName"] ?? "");
          await SharedPreferencesHelper.saveString("password", user["Password"] ?? "");
          await SharedPreferencesHelper.saveString("salesManName", user["SalesManName"] ?? "");
          await SharedPreferencesHelper.saveString("salesManPhone", user["SalesManPhone"] ?? "");
          await SharedPreferencesHelper.saveString("supervisorName", user["SupervisorName"] ?? "");
          await SharedPreferencesHelper.saveString("supervisorPhone", user["SupervisorPhone"] ?? "");

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Login Successfully"),
              backgroundColor:Color(0xFF1E5AA8),
            ),
          );

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Login2()),
          );
        } else {
           ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Username or password is incorrect"),
              backgroundColor: Color(0xFF1E5AA8),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Login failed: ${response.statusCode}"),
            backgroundColor: Color(0xFF1E5AA8),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: $e"),
          backgroundColor: Color(0xFF1E5AA8),
        ),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
        backgroundColor: const Color(0xFF1E5AA8),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Image.asset(
                  'assest/image/download.png',
                  width: width,
                  height: height * 0.3,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: userController,
                  decoration: InputDecoration(
                    labelText: "Username",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: passwordController,
                  obscureText: isPassword,
                  decoration: InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        isPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () => setState(() => isPassword = !isPassword),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                isLoading
                    ? const CircularProgressIndicator()
                    : SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: loginUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1E5AA8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
