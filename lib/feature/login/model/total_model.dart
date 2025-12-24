class TotalModel {
  final int id;
  final DateTime invoiceDate;
  final String customerName;
  final String salesManNo;
  final String salesManName;
  final String paymentTypeName;
  final double grossTotal;
  final double netTotal;
  final double tax;
  final double discValue;
  final double discPer;
  final int status;
  final String voucherTypeID;

  TotalModel({
    required this.id,
    required this.invoiceDate,
    required this.customerName,
    required this.salesManNo,
    required this.salesManName,
    required this.paymentTypeName,
    required this.grossTotal,
    required this.netTotal,
    required this.tax,
    required this.discValue,
    required this.discPer,
    required this.status,
    required this.voucherTypeID,
  });

  factory TotalModel.fromJson(Map<String, dynamic> json) {
    return TotalModel(
      id: json['id'],
      invoiceDate: DateTime.parse(json['invoiceDate']),
      customerName: json['customerName'],
      salesManNo: json['salesManNo'],
      salesManName: json['salesManName'],
      paymentTypeName: json['paymentTypeName'],
      grossTotal: (json['grossTotal'] as num).toDouble(),
      netTotal: (json['netTotal'] as num).toDouble(),
      tax: (json['tax'] as num).toDouble(),
      discValue: (json['discValue'] as num).toDouble(),
      discPer: (json['discPer'] as num).toDouble(),
      status: json['status'],
      voucherTypeID: json['voucherTypeID'],
    );
  }
}