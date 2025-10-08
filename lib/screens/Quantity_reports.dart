 import 'package:flutter/material.dart';

class QuantityReports extends StatefulWidget {
   const QuantityReports({super.key});
 
   @override
   State<QuantityReports> createState() => _QuantityReportsState();
 }
 
 class _QuantityReportsState extends State<QuantityReports> {
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text("Quantity reports",style: TextStyle(color: Colors.white),),
         backgroundColor: Color(0xFF1E5AA8),
       ),

     );
   }
 }
 