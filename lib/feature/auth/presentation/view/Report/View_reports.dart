import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:it_pro/feature/auth/presentation/cubit/total_cubit.dart';
import 'package:it_pro/feature/auth/presentation/state/total_state.dart';
import 'package:it_pro/feature/login/model/total_model.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:flutter/services.dart' show rootBundle;

class TotalReportScreen extends StatelessWidget {
  const TotalReportScreen({super.key});

  Future<void> _printReport(List<TotalModel> invoices) async {
    final pdf = pw.Document();

    final fontData = await rootBundle.load('assest/fonts/ArbFONTS-Tajawal-Regular.ttf');
    final arabicFont = pw.Font.ttf(fontData);

    double totalGross = invoices.fold(0, (sum, e) => sum + e.grossTotal);
    double totalNet = invoices.fold(0, (sum, e) => sum + e.netTotal);
    double totalTax = invoices.fold(0, (sum, e) => sum + e.tax);
    double totalDiscount = invoices.fold(0, (sum, e) => sum + e.discValue);

    pdf.addPage(
      pw.Page(
        theme: pw.ThemeData.withFont(
          base: arabicFont,
        ),
        build: (context) {
          return pw.Directionality(
            textDirection: pw.TextDirection.rtl,
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("تقرير الفواتير", style: pw.TextStyle(fontSize: 24)),
                pw.SizedBox(height: 20),
                pw.Text("مجموع التقارير:"),
                pw.Text("إجمالي التقارير: ${totalGross.toStringAsFixed(2)}"),
                pw.Text("صافي الكلي: ${totalNet.toStringAsFixed(2)}"),
                pw.Text("الضريبة الكلية: ${totalTax.toStringAsFixed(2)}"),
                pw.Text("إجمالي الخصم: ${totalDiscount.toStringAsFixed(2)}"),
                pw.SizedBox(height: 20),
                pw.Text("تفاصيل التقارير:"),
                pw.SizedBox(height: 10),
                ...invoices.map((invoice) {
                  String typeText = invoice.voucherTypeID; // هنا عرض الرمز مباشرة
                  return pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text("${invoice.customerName} - ${invoice.salesManName} ($typeText)"),
                      pw.Text(
                        "رقم التقرير: ${invoice.id}, تاريخ: ${invoice.invoiceDate.day}/${invoice.invoiceDate.month}/${invoice.invoiceDate.year}",
                      ),
                      pw.Text(
                        "صافي: ${invoice.netTotal} | إجمالي: ${invoice.grossTotal} | خصم: ${invoice.discValue}",
                      ),
                      pw.Text("طريقة الدفع: ${invoice.paymentTypeName}"),
                      pw.SizedBox(height: 10),
                    ],
                  );
                }).toList(),
              ],
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (format) => pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("عرض التقارير "),
        backgroundColor: const Color(0xFF1E5AA8),
        actions: [
          BlocBuilder<TotalCubit, TotalState>(
            builder: (context, state) {
              return IconButton(
                icon: const Icon(Icons.print, color: Colors.white),
                tooltip: "طباعة التقرير",
                onPressed: () {
                  if (state is TotalStateLoaded) {
                    _printReport(state.invoices);
                  }
                },
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<TotalCubit, TotalState>(
        builder: (context, state) {
          if (state is TotalStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TotalStateLoaded) {
            if (state.invoices.isEmpty) {
              return const Center(
                child: Text("لا توجد تقارير مطابقة للفلاتر."),
              );
            }

            double totalGross = state.invoices.fold(0, (sum, e) => sum + e.grossTotal);
            double totalNet = state.invoices.fold(0, (sum, e) => sum + e.netTotal);
            double totalTax = state.invoices.fold(0, (sum, e) => sum + e.tax);
            double totalDiscount = state.invoices.fold(0, (sum, e) => sum + e.discValue);

            return ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                Card(
                  color: Colors.blue.shade100,
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    title: Text(
                      "مجموع التقارير:",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text("إجمالي التقارير: ${totalGross.toStringAsFixed(2)}"),
                        Text("صافي الكلي: ${totalNet.toStringAsFixed(2)}"),
                        Text("الضريبة الكلية: ${totalTax.toStringAsFixed(2)}"),
                        Text("إجمالي الخصم: ${totalDiscount.toStringAsFixed(2)}"),
                      ],
                    ),
                  ),
                ),

                ...state.invoices.map((invoice) {
                  String typeText = invoice.voucherTypeID; // عرض الرمز مباشرة
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      title: Text("${invoice.customerName} - ${invoice.salesManName} ($typeText)"),
                      subtitle: Text(
                        "رقم التقرير: ${invoice.id}\n"
                            "تاريخ: ${invoice.invoiceDate.day}/${invoice.invoiceDate.month}/${invoice.invoiceDate.year}\n"
                            "صافي: ${invoice.netTotal} | إجمالي: ${invoice.grossTotal} | خصم: ${invoice.discValue}\n"
                            "طريقة الدفع: ${invoice.paymentTypeName}",
                      ),
                    ),
                  );
                }).toList(),
              ],
            );
          } else if (state is TotalStateError) {
            return Center(child: Text("خطأ: ${state.message}"));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
