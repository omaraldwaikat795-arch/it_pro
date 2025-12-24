import 'package:bloc/bloc.dart';
import 'package:it_pro/core/const/api_const3.dart';
import 'package:it_pro/feature/auth/presentation/state/total_state.dart';
import 'package:it_pro/feature/login/model/total_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TotalCubit extends Cubit<TotalState> {
  TotalCubit() : super(TotalStateInitial());

  // تخزين الفلاتر المختارة
  DateTime? startDate;
  DateTime? endDate;
  String? fromAgent;
  String? toAgent;
  String? fromClient;
  String? toClient;
  String? paymentType;

  // تحديث الفلاتر
  void setFilters({
    DateTime? start,
    DateTime? end,
    String? fromA,
    String? toA,
    String? fromC,
    String? toC,
    String? payment,
  }) {
    startDate = start ?? startDate;
    endDate = end ?? endDate;
    fromAgent = fromA ?? fromAgent;
    toAgent = toA ?? toAgent;
    fromClient = fromC ?? fromClient;
    toClient = toC ?? toClient;
    paymentType = payment ?? paymentType;

    emit(TotalStateInitial(
      startDate: startDate,
      endDate: endDate,
      fromAgent: fromAgent,
      toAgent: toAgent,
      fromClient: fromClient,
      toClient: toClient,
      paymentType: paymentType,
    ));
  }

  // جلب الفلاتر عند فتح الشاشة فقط
  Future<void> loadFilters() async {
    try {
      final response = await http.get(Uri.parse(APIConst3.totalSales));

      if (response.statusCode == 200) {
        final List jsonData = json.decode(response.body);
        List<TotalModel> invoices =
        jsonData.map((item) => TotalModel.fromJson(item)).toList();

        List<String> agents =
        invoices.map((e) => e.salesManName).toSet().toList();
        List<String> clients =
        invoices.map((e) => e.customerName).toSet().toList();
        List<String> payments =
        invoices.map((e) => e.paymentTypeName).toSet().toList();

        emit(TotalStateLoaded(
          invoices: [],
          agents: agents,
          clients: clients,
          payments: payments,
          totalGross: 0,
          totalNet: 0,
          totalTax: 0,
          totalDiscount: 0,
        ));
      } else {
        emit(TotalStateError("خطأ بجلب الفلاتر"));
      }
    } catch (e) {
      emit(TotalStateError(e.toString()));
    }
  }

  // جلب البيانات من الـ API مع تطبيق الفلاتر
  Future<void> fetchTotalSales() async {
    try {
      emit(TotalStateLoading());

      final response = await http.get(Uri.parse(APIConst3.totalSales));

      if (response.statusCode == 200) {
        final List jsonData = json.decode(response.body);
        List<TotalModel> invoices =
        jsonData.map((item) => TotalModel.fromJson(item)).toList();

        // تطبيق الفلترة على الفواتير حسب القيم المختارة
        invoices = invoices.where((inv) {
          bool match = true;

          DateTime invoiceDate = DateTime(
              inv.invoiceDate.year, inv.invoiceDate.month, inv.invoiceDate.day);

          if (startDate != null) {
            DateTime start =
            DateTime(startDate!.year, startDate!.month, startDate!.day);
            match = match && !invoiceDate.isBefore(start);
          }
          if (endDate != null) {
            DateTime end = DateTime(endDate!.year, endDate!.month, endDate!.day);
            match = match && !invoiceDate.isAfter(end);
          }

          if (fromAgent != null) {
            match = match && inv.salesManName.compareTo(fromAgent!) >= 0;
          }
          if (toAgent != null) {
            match = match && inv.salesManName.compareTo(toAgent!) <= 0;
          }
          if (fromClient != null) {
            match = match && inv.customerName.compareTo(fromClient!) >= 0;
          }
          if (toClient != null) {
            match = match && inv.customerName.compareTo(toClient!) <= 0;
          }
          if (paymentType != null) {
            match = match && inv.paymentTypeName == paymentType;
          }

          return match;
        }).toList();

        // حساب الإجماليات
        double totalGross =
        invoices.fold(0, (sum, inv) => sum + inv.grossTotal);
        double totalNet = invoices.fold(0, (sum, inv) => sum + inv.netTotal);
        double totalTax = invoices.fold(0, (sum, inv) => sum + inv.tax);
        double totalDiscount =
        invoices.fold(0, (sum, inv) => sum + inv.discValue);

        // ملء Dropdowns بالقيم الفعلية
        List<String> agents = invoices.map((e) => e.salesManName).toSet().toList();
        List<String> clients = invoices.map((e) => e.customerName).toSet().toList();
        List<String> payments = invoices.map((e) => e.paymentTypeName).toSet().toList();

        emit(TotalStateLoaded(
          invoices: invoices,
          agents: agents,
          clients: clients,
          payments: payments,
          totalGross: totalGross,
          totalNet: totalNet,
          totalTax: totalTax,
          totalDiscount: totalDiscount,
        ));
      } else {
        emit(TotalStateError("حدث خطأ أثناء جلب البيانات"));
      }
    } catch (e) {
      emit(TotalStateError(e.toString()));
    }
  }
}
