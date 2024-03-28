abstract class ApiConfig {
  static const String baseUrl = 'https://api.paystack.co/transaction';

  static const String initializeTransaction = '$baseUrl/initialize';
  static String verifyPayStackTransaction(String reference) => "https://api.paystack.co/transaction/verify/$reference";


}
