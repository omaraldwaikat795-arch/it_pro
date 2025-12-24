import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:it_pro/core/const/api_const4.dart';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class Custamers extends StatefulWidget {
  const Custamers({super.key});

  @override
  State<Custamers> createState() => _CustamersState();
}

class _CustamersState extends State<Custamers> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController deleteIdController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    areaController.dispose();
    deleteIdController.dispose();
    super.dispose();
  }

  // جلب الموقع تلقائياً
  Future<void> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("خدمة الموقع غير مفعلة")),
      );
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("تم رفض إذن الموقع")),
        );
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("تم رفض إذن الموقع بشكل دائم")),
      );
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks.first;
        addressController.text = "${place.street}, ${place.locality}";
        areaController.text = place.subAdministrativeArea ?? "";
      }
    } catch (e) {
      print("خطأ في جلب العنوان: $e");
    }
  }

  // إنشاء عميل
  Future<void> createCustomer() async {
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();

    if (name.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("يرجى إدخال اسم العميل ورقمه")),
      );
      return;
    }

    // جلب الموقع إذا كانت الحقول فارغة
    if (addressController.text.isEmpty || areaController.text.isEmpty) {
      await getCurrentLocation();
    }

    setState(() => isLoading = true);

    try {
      final response = await http.post(
        Uri.parse(ApiConst4.createCustomer),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'phone': phone,
          'address': addressController.text,
          'area': areaController.text,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("تم إنشاء العميل بنجاح")),
        );
        nameController.clear();
        phoneController.clear();
        addressController.clear();
        areaController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("حدث خطأ: ${response.statusCode}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("حدث خطأ: ${e.toString()}")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  // حذف عميل بالـ ID
  Future<void> deleteCustomer() async {
    final idText = deleteIdController.text.trim();
    if (idText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("يرجى إدخال رقم العميل للحذف")),
      );
      return;
    }

    final id = int.tryParse(idText);
    if (id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("رقم العميل غير صالح")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await http.delete(
        Uri.parse(ApiConst4.deleteCustomer(id)),
        headers: {'accept': '*/*'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("تم حذف العميل بنجاح")),
        );
        deleteIdController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("حدث خطأ: ${response.statusCode}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("حدث خطأ: ${e.toString()}")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text("إدارة العملاء"),
        backgroundColor: const Color(0xFF1E5AA8),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Image.asset(
                'assest/image/download.png',
                width: width,
                height: height * 0.25,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),

              // اسم العميل - يقبل أي نص عربي أو إنجليزي
              buildTextField(nameController, "اسم العميل", Icons.person,
                  keyboardType: TextInputType.text),

              const SizedBox(height: 15),

              // رقم الهاتف - يقبل أرقام فقط
              buildTextField(phoneController, "رقم الهاتف", Icons.phone,
                  keyboardType: TextInputType.number),

              const SizedBox(height: 15),

              // العنوان
              buildTextField(addressController, "العنوان", Icons.location_on,
                  keyboardType: TextInputType.text),

              const SizedBox(height: 15),

              // المنطقة
              buildTextField(areaController, "المنطقة", Icons.map,
                  keyboardType: TextInputType.text),

              const SizedBox(height: 15),

              isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: createCustomer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E5AA8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "إنشاء عميل",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // حذف العميل بالـ ID
              buildTextField(deleteIdController, "رقم العميل للحذف", Icons.delete,
                  keyboardType: TextInputType.number),

              const SizedBox(height: 15),

              isLoading
                  ? const CircularProgressIndicator()
                  : SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: deleteCustomer,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "حذف عميل",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(TextEditingController controller, String label, IconData icon,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xFF1E5AA8)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
