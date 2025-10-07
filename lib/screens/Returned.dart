import 'package:flutter/material.dart';

class Returned extends StatefulWidget {
  const Returned({super.key});

  @override
  State<Returned> createState() => _ReturnedState();
}

class _ReturnedState extends State<Returned> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Returned",style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF1E5AA8),
      ),
    );
  }
}
