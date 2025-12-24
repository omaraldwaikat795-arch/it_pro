import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:it_pro/feature/auth/presentation/cubit/login_cubit.dart';
import 'package:it_pro/feature/auth/presentation/view/Report/custamers.dart';
import 'package:it_pro/feature/auth/presentation/view/login/Login.dart';
import 'package:it_pro/feature/auth/presentation/view/login/login2.dart';
import 'package:it_pro/feature/auth/presentation/view/Report/Report.dart';
import 'package:it_pro/feature/auth/presentation/view/Report/Sales_reports.dart';

Future<void> main() async {
  debugPaintSizeEnabled = false;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider<LoginCubit>(create: (context) => LoginCubit())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: Custamers(),
      ),
    );
  }
}
