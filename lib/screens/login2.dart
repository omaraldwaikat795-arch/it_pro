import 'package:flutter/material.dart';
import 'package:it_pro/screens/Approvals.dart';
import 'package:it_pro/screens/Powers.dart';

class Login2 extends StatefulWidget {
  const Login2({super.key});

  @override
  State<Login2> createState() => _Login2State();
}

class _Login2State extends State<Login2> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Home", style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Color(0xFF1E5AA8),
      ),
      body: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 13, left: 20),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Approvals()),
                );
              },
              child: Container(
                height: height * 0.07,
                width: width * 0.4,
                decoration: BoxDecoration(
                  color: Color(0xFF1E5AA8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Center(
                    child: Text(
                      "التقارير",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: 20),
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 17),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Powers()),
                );
              },
              child: Container(
                height: height * 0.07,
                width: width * 0.4,
                decoration: BoxDecoration(
                  color: Color(0xFF1E5AA8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Center(
                    child: Text(
                      "الموافقات",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
