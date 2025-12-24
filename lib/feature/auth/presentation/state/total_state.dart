import 'package:it_pro/feature/login/model/total_model.dart';

abstract class TotalState {}

// البداية قبل أي تحميل
class TotalStateInitial extends TotalState {
  final DateTime? startDate;
  final DateTime? endDate;
  final String? fromAgent;
  final String? toAgent;
  final String? fromClient;
  final String? toClient;
  final String? paymentType;

  TotalStateInitial({
    this.startDate,
    this.endDate,
    this.fromAgent,
    this.toAgent,
    this.fromClient,
    this.toClient,
    this.paymentType,
  });
}

class TotalStateLoading extends TotalState {}

// البيانات جاهزة بعد نجاح التحميل
class TotalStateLoaded extends TotalState {
  final List<TotalModel> invoices;  // كل الفواتير من الـ API بعد الفلترة
  final List<String> agents;        // قائمة المندوبين Dropdown
  final List<String> clients;       // قائمة العملاء Dropdown
  final List<String> payments;      // قائمة طرق الدفع Dropdown

  // الحقول الجديدة للتوتال
  final double totalGross;
  final double totalNet;
  final double totalTax;
  final double totalDiscount;

  TotalStateLoaded({
    required this.invoices,
    required this.agents,
    required this.clients,
    required this.payments,
    this.totalGross = 0,
    this.totalNet = 0,
    this.totalTax = 0,
    this.totalDiscount = 0,
  });
}

// حالة الخطأ لو صار مشكلة أثناء جلب البيانات
class TotalStateError extends TotalState {
  final String message;
  TotalStateError(this.message);
}
