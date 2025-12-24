import 'package:it_pro/feature/login/model/custamers_model.dart';

abstract class CustomerState {}

// البداية قبل أي عملية
class CustomerStateInitial extends CustomerState {
  final String? name;
  final String? phone;
  final String? address;
  final String? area;

  CustomerStateInitial({this.name, this.phone, this.address, this.area});
}

// حالة التحميل
class CustomerStateLoading extends CustomerState {}

// حالة النجاح بعد إنشاء أو حذف العميل
class CustomerStateLoaded extends CustomerState {
  final List<Customer> customers; // قائمة العملاء بعد العملية
  final String? message; // رسالة نجاح العملية، مثل "تم إنشاء العميل"

  CustomerStateLoaded({required this.customers, this.message});
}

// حالة الخطأ لو صار مشكلة أثناء العملية
class CustomerStateError extends CustomerState {
  final String message; // رسالة الخطأ
  CustomerStateError(this.message);
}
