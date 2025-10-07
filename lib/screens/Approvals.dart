import 'package:flutter/material.dart';
import 'package:it_pro/screens/Cache_reports.dart';
import 'package:it_pro/screens/Quantity_reports.dart';
import 'package:it_pro/screens/Sales_reports.dart';
import 'package:it_pro/screens/login2.dart';

class Approvals extends StatefulWidget {
  const Approvals({super.key});

  @override
  State<Approvals> createState() => _ApprovalsState();
}

class _ApprovalsState extends State<Approvals> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Approvals", style: TextStyle(color: Colors.white)),
        centerTitle: true,
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
                  MaterialPageRoute(builder: (context) => SalesReports()),
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
                    "تقارير المبيعات",
                    style: TextStyle(color: Colors.white, fontSize: 19),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuantityReports()),
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
                    "تقرير الكميات",
                    style: TextStyle(color: Colors.white, fontSize: 19),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CacheReports()),
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
                    "تقرير الكاش",
                    style: TextStyle(color: Colors.white, fontSize: 19),
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
