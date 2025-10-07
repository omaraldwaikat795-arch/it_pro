import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:it_pro/core/const/api_const.dart';
import 'package:it_pro/core/units/shared_preferences.dart';

//import 'package:it_pro/screens/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveData extends StatefulWidget {
  const SaveData({super.key});

  @override
  State<SaveData> createState() => _SaveDataState();
}

class _SaveDataState extends State<SaveData> {
  @override
  Future<void> getdata() async {
    print("getdata");

    try {
      SharedPreferencesHelper.getString("token");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SaveData()),
      );
    } catch (e) {}
  }

  Widget build(BuildContext context) {
    return Scaffold(body: Column());
  }
}
