import 'package:flutter/material.dart';

class CacheReports extends StatefulWidget {
  const CacheReports({super.key});

  @override
  State<CacheReports> createState() => _CacheReportsState();
}

class _CacheReportsState extends State<CacheReports> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Cache reports", style: TextStyle(color: Colors.white)),
        backgroundColor: Color(0xFF1E5AA8),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.blue, width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      "التاريخ",
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    ),
                    TextButton(
                      onPressed: () => _selectDate(context),
                      child: Text(
                        selectedDate == null
                            ? "اختر التاريخ"
                            : "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}",
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
