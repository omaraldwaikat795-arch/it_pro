import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_pro/feature/auth/presentation/cubit/total_cubit.dart';
import 'package:it_pro/feature/auth/presentation/state/total_state.dart';
import 'view_reports.dart';
class TotalSales extends StatelessWidget {
  const TotalSales({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TotalCubit()..loadFilters(),
      child: const TotalSalesUI(),
    );
  }
}

class TotalSalesUI extends StatefulWidget {
  const TotalSalesUI({super.key});

  @override
  State<TotalSalesUI> createState() => _TotalSalesUIState();
}

class _TotalSalesUIState extends State<TotalSalesUI> {
  String? selectedFromAgent;
  String? selectedToAgent;
  String? selectedFromClient;
  String? selectedToClient;
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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Total Sales", style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1E5AA8),
        actions: [
          IconButton(
            icon: const Icon(Icons.print, color: Colors.white,),
            onPressed: () async {
              context.read<TotalCubit>().setFilters(
                start: startDate,
                end: endDate,
                fromA: selectedFromAgent,
                toA: selectedToAgent,
                fromC: selectedFromClient,
                toC: selectedToClient,
                payment: selectedPayment,
              );

              await context.read<TotalCubit>().fetchTotalSales();

               Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: context.read<TotalCubit>(),
                    child: const TotalReportScreen(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<TotalCubit, TotalState>(
        builder: (context, state) {
          List<String> agents = [];
          List<String> clients = [];
          List<String> payments = [];

          if (state is TotalStateLoaded) {
            agents = state.agents;
            clients = state.clients;
            payments = state.payments;
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
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
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("من تاريخ", style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                            TextButton(
                              onPressed: () => _selectDate(context, true),
                              child: FittedBox(
                                child: Text(
                                  startDate == null
                                      ? "اختر التاريخ"
                                      : "${startDate!.day}/${startDate!.month}/${startDate!.year}",
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("إلى تاريخ", style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                            TextButton(
                              onPressed: () => _selectDate(context, false),
                              child: FittedBox(
                                child: Text(
                                  endDate == null
                                      ? "اختر التاريخ"
                                      : "${endDate!.day}/${endDate!.month}/${endDate!.year}",
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: const Color(0xFF1E5AA8), width: 1),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text("من مندوب", style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                            DropdownButton<String>(
                              isExpanded: true,
                              value: selectedFromAgent,
                              hint: const Text("اختر مندوب"),
                              items: agents.map((agent) => DropdownMenuItem<String>(
                                value: agent,
                                child: Text(agent, overflow: TextOverflow.ellipsis),
                              )).toList(),
                              onChanged: (value) => setState(() => selectedFromAgent = value),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          children: [
                            Text("إلى مندوب", style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                            DropdownButton<String>(
                              isExpanded: true,
                              value: selectedToAgent,
                              hint: const Text("اختر مندوب"),
                              items: agents.map((agent) => DropdownMenuItem<String>(
                                value: agent,
                                child: Text(agent, overflow: TextOverflow.ellipsis),
                              )).toList(),
                              onChanged: (value) => setState(() => selectedToAgent = value),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                 Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.black, width: 1),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text("من عميل", style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                            DropdownButton<String>(
                              isExpanded: true,
                              value: selectedFromClient,
                              hint: const Text("اختر عميل"),
                              items: clients.map((client) => DropdownMenuItem<String>(
                                value: client,
                                child: Text(client, overflow: TextOverflow.ellipsis),
                              )).toList(),
                              onChanged: (value) => setState(() => selectedFromClient = value),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          children: [
                            Text("إلى عميل", style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                            DropdownButton<String>(
                              isExpanded: true,
                              value: selectedToClient,
                              hint: const Text("اختر عميل"),
                              items: clients.map((client) => DropdownMenuItem<String>(
                                value: client,
                                child: Text(client, overflow: TextOverflow.ellipsis),
                              )).toList(),
                              onChanged: (value) => setState(() => selectedToClient = value),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                 Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.blue, width: 1),
                  ),
                  child: Column(
                    children: [
                      Text("طريقة الدفع", style: TextStyle(fontSize: 12, color: Colors.grey[700])),
                      DropdownButton<String>(
                        isExpanded: true,
                        value: selectedPayment,
                        hint: const Text("اختر طريقة الدفع"),
                        items: payments.map((pay) => DropdownMenuItem<String>(
                          value: pay,
                          child: Text(pay, overflow: TextOverflow.ellipsis),
                        )).toList(),
                        onChanged: (value) => setState(() => selectedPayment = value),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
