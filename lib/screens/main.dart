import 'package:flutter/material.dart';
import 'package:it_pro/core/units/db_helper.dart';
import 'package:it_pro/screens/Approvals.dart';
import 'package:it_pro/screens/Cache_reports.dart';
import 'package:it_pro/screens/Powers.dart';
import 'package:it_pro/screens/Quantity_reports.dart';
import 'package:it_pro/screens/SQLite.dart';
import 'package:it_pro/screens/Total_sales.dart';
import 'package:it_pro/screens/data_screen.dart';
import 'package:it_pro/screens/login.dart';
import 'package:it_pro/screens/login2.dart';
import 'package:it_pro/screens/save_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Login2(),
    );
  }
}
