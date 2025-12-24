class Customer {
  final int? id; // لو الـ API يرجع ID بعد الإنشاء
  final String name;
  final String phone;
  final String address;
  final String area;

  Customer({
    this.id,
    required this.name,
    required this.phone,
    required this.address,
    required this.area,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      area: json['area'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      'area': area,
    };
  }
}
