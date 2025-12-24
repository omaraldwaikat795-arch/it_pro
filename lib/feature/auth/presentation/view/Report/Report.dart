import 'package:flutter/material.dart';
import 'package:it_pro/feature/auth/presentation/view/Report/Sales_reports.dart';


class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ApprovalsState();
}

class _ApprovalsState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Report", style: TextStyle(color: Colors.white)),
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
            //   onTap: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => QuantityReports()),
            //     );
            //   },
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
              // onTap: () {
              //   Navigator.pushReplacement(
              //     context,
              //     MaterialPageRoute(builder: (context) => CacheReports()),
              //   );
              // },
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