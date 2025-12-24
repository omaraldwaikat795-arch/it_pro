class ApiConst4 {
  static const String baseUrl = 'http://itprojo.dyndns.org:122/api';

  static const String createCustomer = '$baseUrl/Customer/create';

  static String deleteCustomer(int id) => '$baseUrl/Customer/delete/$id';
}