import 'package:flutter_bloc/flutter_bloc.dart'; // فقط لو تستخدم Bloc/Cubit
import 'package:it_pro/core/const/api_const4.dart';
import 'package:it_pro/feature/auth/presentation/state/custamers_state.dart';
import 'package:it_pro/feature/login/model/custamers_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CustomerCubit extends Cubit<CustomerState> {
  CustomerCubit() : super(CustomerStateInitial());

  // إنشاء العميل
  Future<void> createCustomer(
    String name,
    String phone,
    String address,
    String area,
  ) async {
    emit(CustomerStateLoading());

    try {
      final response = await http.post(
        Uri.parse(ApiConst4.createCustomer),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'phone': phone,
          'address': address,
          'area': area,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // يمكن إرجاع بيانات العميل الجديد أو قائمة العملاء بعد الإنشاء
        final data = jsonDecode(response.body);
        Customer newCustomer = Customer.fromJson(data);

        emit(
          CustomerStateLoaded(
            customers: [newCustomer],
            message: "تم إنشاء العميل بنجاح",
          ),
        );
      } else {
        emit(CustomerStateError("حدث خطأ: ${response.statusCode}"));
      }
    } catch (e) {
      emit(CustomerStateError(e.toString()));
    }
  }

  // حذف العميل بالـ ID
  Future<void> deleteCustomer(int id) async {
    emit(CustomerStateLoading());

    try {
      final response = await http.delete(
        Uri.parse(ApiConst4.deleteCustomer(id)),
        headers: {'accept': '*/*'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(
          CustomerStateLoaded(customers: [], message: "تم حذف العميل بنجاح"),
        );
      } else {
        emit(CustomerStateError("حدث خطأ: ${response.statusCode}"));
      }
    } catch (e) {
      emit(CustomerStateError(e.toString()));
    }
  }
}
