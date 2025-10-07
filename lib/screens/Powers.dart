 import 'package:flutter/material.dart';
import 'package:it_pro/screens/Approvals.dart';
import 'package:it_pro/screens/Bypass_stop.dart';
import 'package:it_pro/screens/Off_track.dart';
import 'package:it_pro/screens/Returned.dart';
import 'package:it_pro/screens/login.dart';
import 'package:it_pro/screens/login2.dart';

class Powers extends StatefulWidget {
   const Powers({super.key});

   @override
   State<Powers> createState() => _PowersState();
 }

 class _PowersState extends State<Powers> {
   @override
   Widget build(BuildContext context) {
     var height = MediaQuery.of(context).size.height;
     var width = MediaQuery.of(context).size.width;
     return  Scaffold  (
appBar: AppBar(
  title: Text("Powers",style: TextStyle(color: Colors.white),),
  backgroundColor: Color(0xFF1E5AA8),
),
       body: Padding(
         padding: const EdgeInsets.all(20.0),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.stretch,
           children: [
             InkWell(
               onTap: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => Returned()),
                 );
               },
               child: Container(
                 height: height * 0.07,
                 decoration: BoxDecoration(
                   color: Color(0xFF1E5AA8),
                   borderRadius: BorderRadius.circular(10),
                 ),
                 child: Center(
                   child: Text(
                     "مرتجع",
                     style: TextStyle(
                       color: Colors.white,
                       fontSize: 19,
                     ),
                   ),
                 ),
               ),
             ),
             SizedBox(height: 20),
             InkWell(
               onTap: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => OffTrack()),
                 );
               },
               child: Container(
                 height: height * 0.07,
                 decoration: BoxDecoration(
                   color: Color(0xFF1E5AA8),
                   borderRadius: BorderRadius.circular(10),
                 ),
                 child: Center(
                   child: Text(
                     "خارج المسار",
                     style: TextStyle(
                       color: Colors.white,
                       fontSize: 19,
                     ),
                   ),
                 ),
               ),
             ),
             SizedBox(height: 20),
             InkWell(
               onTap: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => BypassStop()),
                 );
               },
               child: Container(
                 height: height * 0.07,
                 decoration: BoxDecoration(
                   color: Color(0xFF1E5AA8),
                   borderRadius: BorderRadius.circular(10),
                 ),
                 child: Center(
                   child: Text(
                     " تجاوز سقف العميل",
                     style: TextStyle(
                       color: Colors.white,
                       fontSize: 19,
                     ),
                   ),
                 ),
               ),
             ),
           ],
         ),
       ),

     );
   }
 }
