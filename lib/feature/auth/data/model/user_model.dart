class UserModel {
  int? id;
  String? name;
  String? userName;
  String? password;
  int? status;
  String? salesManName;
  String? salesManPhone;
  String? supervisorName;
  String? supervisorPhone;

  UserModel({
    this.id,
    this.name,
    this.userName,
    this.password,
    this.status,
    this.salesManName,
    this.salesManPhone,
    this.supervisorName,
    this.supervisorPhone,
  });

  // تحويل من JSON
  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    userName = json['UserName'];
    password = json['Password'];
    status = json['Status'];
    salesManName = json['SalesManName'];
    salesManPhone = json['SalesManPhone'];
    supervisorName = json['SupervisorName'];
    supervisorPhone = json['SupervisorPhone'];
  }

  // تحويل إلى JSON
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Name'] = name;
    data['UserName'] = userName;
    data['Password'] = password;
    data['Status'] = status;
    data['SalesManName'] = salesManName;
    data['SalesManPhone'] = salesManPhone;
    data['SupervisorName'] = supervisorName;
    data['SupervisorPhone'] = supervisorPhone;
    return data;
  }
}