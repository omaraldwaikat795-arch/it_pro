import 'package:flutter/material.dart';

class CustomerReceivables extends StatefulWidget {
  const CustomerReceivables({super.key});

  @override
  State<CustomerReceivables> createState() => _CustomerReceivablesState();
}

class _CustomerReceivablesState extends State<CustomerReceivables> {
  List<String> agents = ["أحمد", "خالد", "سعيد", "محمد"];
  String? selectedFromAgent;
  String? selectedToAgent;

  List<String> clients = ["علي", "محمد", "سارة", "ليلى"];
  String? selectedFromClient;
  String? selectedToClient;
  List<String> payments = ["كاش", "فيزا", "كليك"];
  String? selectedPayment;
  DateTime? startDate;
  DateTime? endDate;
  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold  (
      appBar: AppBar(
        title: Text(" Customer receivables",style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0xFF1E5AA8),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
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
                      "من",
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    ),
                    TextButton(
                      onPressed: () => _selectDate(context, true),
                      child: Text(
                        startDate == null
                            ? "اختر التاريخ"
                            : "${startDate!.day}/${startDate!.month}/${startDate!.year}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Text("→"),
                Column(
                  children: [
                    Text(
                      "إلى",
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    ),
                    TextButton(
                      onPressed: () => _selectDate(context, false),
                      child: Text(
                        endDate == null
                            ? "اختر التاريخ"
                            : "${endDate!.day}/${endDate!.month}/${endDate!.year}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
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
                      "من مندوب",
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    ),
                    DropdownButton<String>(
                      value: selectedFromAgent,
                      hint: Text("اختر مندوب"),
                      items: agents.map((agent) {
                        return DropdownMenuItem<String>(
                          value: agent,
                          child: Text(agent),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedFromAgent = value;
                        });
                      },
                    ),
                  ],
                ),
                Text("→"),
                Column(
                  children: [
                    Text(
                      "إلى مندوب",
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    ),
                    DropdownButton<String>(
                      value: selectedToAgent,
                      hint: Text("اختر مندوب"),
                      items: agents.map((agent) {
                        return DropdownMenuItem<String>(
                          value: agent,
                          child: Text(agent),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedToAgent = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 22),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black, width: 1),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    Text(
                      "من عميل",
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    ),
                    DropdownButton<String>(
                      value: selectedFromClient,
                      hint: Text("اختر عميل"),
                      items: clients.map((client) {
                        return DropdownMenuItem<String>(
                          value: client,
                          child: Text(client),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedFromClient = value;
                        });
                      },
                    ),
                  ],
                ),
                Text("→"),
                Column(
                  children: [
                    Text(
                      "إلى عميل",
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    ),
                    DropdownButton<String>(
                      value: selectedToClient,
                      hint: Text("اختر عميل"),
                      items: clients.map((client) {
                        return DropdownMenuItem<String>(
                          value: client,
                          child: Text(client),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedToClient = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 22),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
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
                      "طريقة الدفع",
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    ),
                    DropdownButton<String>(
                      value: selectedPayment,
                      hint: Text("اختر طريقة الدفع"),
                      items: payments.map((pay) {
                        return DropdownMenuItem<String>(
                          value: pay,
                          child: Text(pay),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedPayment = value;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(child: Center(child: Text(""))),
        ],
      ),
    );
  }
}
