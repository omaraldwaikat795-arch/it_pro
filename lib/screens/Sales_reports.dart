import 'package:flutter/material.dart';
import 'package:it_pro/screens/Customer_receivables.dart';
import 'package:it_pro/screens/Detailed_sales.dart';
import 'package:it_pro/screens/Material_sales.dart';
import 'package:it_pro/screens/Total_sales.dart';
import 'package:it_pro/screens/login.dart';
import 'package:it_pro/screens/login2.dart';

class SalesReports extends StatefulWidget {
  const SalesReports({super.key});

  @override
  State<SalesReports> createState() => _SalesReportsState();
}

class _SalesReportsState extends State<SalesReports> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Sales reports",style: TextStyle(color: Colors.white),),
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
                  MaterialPageRoute(builder: (context) => TotalSales()),
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
                    " تقرير مبيعات اجمالي ",
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
                  MaterialPageRoute(builder: (context) =>DetailedSales ()),
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
                    "تقرير مبيعات تفصيلي ",
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
                  MaterialPageRoute(builder: (context) => CustomerReceivables()),
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
                    "تقرير ذمم الزبائن  ",
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
                  MaterialPageRoute(builder: (context) =>  MaterialSales()),
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
                    "تقرير مبيعات المواد ",
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
