abstract class AppConfig {
  static const String baseUrl = 'https://flitwiredevapi.azurewebsites.net';

  static const String register = '$baseUrl/Auth/register';
  static const String signUp = '$baseUrl/Auth/sign-up';
  static const String login = '$baseUrl/Auth/login';
  static const String verifyEmail = '$baseUrl/Auth/verify-pass';
  static const String resetPassword = '$baseUrl/Auth/forgot-pass';
  static const String accountSettings = "$baseUrl/Settings";
  static const String settingsOptions = "$baseUrl/Settings/options";
  static const String phoneOtp = "$baseUrl/Settings/send-otp";
  static const String cards = "$baseUrl/Settings/bank-card";
  static const String bankAccount = "$baseUrl/Settings/bank-account";
  static const String convertMoney = "$baseUrl/Wallet/convert";
  static const String confirmMoney = "$baseUrl/Wallet/confirm";
  static const String transferMoney = "$baseUrl/Wallet/transfer";
  static const String cashIn = "$baseUrl/Wallet/cash-in";
  static const String cashOut = "$baseUrl/Wallet/cash-out";

  static const String logOut = "$baseUrl/Auth/logout";
  static const String authDelete = "$baseUrl/Auth/delete";
  static const String walletBalance = "$baseUrl/Wallet/balance";
  static const String walletTransactions = "$baseUrl/Wallet/transactions";
  static const String initializeCashIn = "$baseUrl/Wallet/initiate-cash-in";
  static String verifyPayStackTransaction(String reference) => "https://api.paystack.co/transaction/verify/$reference";


}
