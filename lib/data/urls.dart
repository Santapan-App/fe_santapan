class Urls {
  static String baseUrl = 'http://127.0.0.1:9090';
  static String transactionServiceUrl = 'http://127.0.0.1:9091';
  static String loginURl = '$baseUrl/login';
  static String registerURl = '$baseUrl/register';
  static String categoriesURl = '$baseUrl/categories';
  static String menuUrl = '$baseUrl/menu';
  static String bundlingUrl = '$baseUrl/bundling';
  static String cartUrl= '$transactionServiceUrl/cart';
  static String transactionUrl= '$transactionServiceUrl/transaction';
  static String addressUrl = '$baseUrl/address';
  static String articleUrl = '$baseUrl/article';
}
