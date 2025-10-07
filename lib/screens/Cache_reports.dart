import 'package:flutter/material.dart';

class CacheReports extends StatefulWidget {
  const CacheReports({super.key});

  @override
  State<CacheReports> createState() => _CacheReportsState();
}

class _CacheReportsState extends State<CacheReports> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Cache reports",style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF1E5AA8),
        
      ),
    );
  }
}
