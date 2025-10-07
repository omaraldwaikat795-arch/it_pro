import 'package:flutter/material.dart';

class BypassStop extends StatefulWidget {
  const BypassStop({super.key});

  @override
  State<BypassStop> createState() => _BypassStopState();
}

class _BypassStopState extends State<BypassStop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Bypass stop", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF1E5AA8),
      ),
    );
  }
}
