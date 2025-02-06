class Urls {
  static String baseUrl = 'http://192.168.0.107:9090';
  static String transactionServiceUrl = 'http://192.168.0.107:9091';
  static String loginURl = '$baseUrl/login';
  static String personalisasiURL = '$baseUrl/personalisasi';
  static String registerURl = '$baseUrl/register';
  static String categoriesURl = '$baseUrl/categories';
  static String menuUrl = '$baseUrl/menu';
  static String bundlingUrl = '$baseUrl/bundling';
  static String cartUrl = '$transactionServiceUrl/cart';
  static String transactionUrl = '$transactionServiceUrl/transaction';
  static String addressUrl = '$baseUrl/address';
  static String articleUrl = '$baseUrl/articles';
  static String courierUrl = '$baseUrl/courier';
  static String nutritionUrl = '$baseUrl/nutrition';
}
