import 'package:flutter/material.dart';
import 'package:it_pro/core/units/shared_preferences.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({super.key});

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  String? id;
  String? username;
  String? email;
  String? phone;
  String? role;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  Future<void> getData() async{
    id = await SharedPreferencesHelper.getString("id");
    username = await SharedPreferencesHelper.getString("name");
    email = await SharedPreferencesHelper.getString("email");
    phone = await SharedPreferencesHelper.getString("phone");
    role = await SharedPreferencesHelper.getString("role");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: Text("data"),
),
      body: Center(
        child: Column(
          children: [
         Text("id is : $id"),
         Text("UserName is : $username"),
         Text("email is : $email"),
         Text("phone is : $phone"),
         Text("role is : $role"),
            ElevatedButton(onPressed: (){getData();}, child: Text("refresh"))

          ],
        ),
      ),
    );
  }
}
