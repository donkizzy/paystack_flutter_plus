class TransactionResponse {
  TransactionResponse({
    this.reference,
    this.amount,
    this.channel,
    this.currency,
    this.authorization,
    this.gatewayResponse,
  });

  final String? reference;
  final int? amount;
  final String? channel;
  final String? currency;
  final String? gatewayResponse;
  final Authorization? authorization;

  factory TransactionResponse.fromJson(Map<String, dynamic> json) => TransactionResponse(
        reference: json["reference"],
        amount: json["amount"],
        channel: json["channel"],
        currency: json["currency"],
        gatewayResponse: json["gateway_response"],
        authorization: Authorization.fromJson(json["authorization"]),
      );

  Map<String, dynamic> toJson() => {
        "reference": reference,
        "amount": amount,
        "channel": channel,
        "currency": currency,
        "gateway_response": gatewayResponse,
        "authorization": authorization?.toJson(),
      };
}

class Authorization {
  Authorization({
    this.authorizationCode,
    this.bin,
    this.last4,
    this.expMonth,
    this.expYear,
    this.channel,
    this.cardType,
    this.bank,
    this.countryCode,
    this.brand,
    this.reusable,
    this.signature,
    this.accountName,
  });

  String? authorizationCode;
  String? bin;
  String? last4;
  String? expMonth;
  String? expYear;
  String? channel;
  String? cardType;
  String? bank;
  String? countryCode;
  String? brand;
  bool? reusable;
  String? signature;
  String? accountName;

  factory Authorization.fromJson(Map<String, dynamic> json) => Authorization(
        authorizationCode: json["authorization_code"],
        bin: json["bin"],
        last4: json["last4"],
        expMonth: json["exp_month"],
        expYear: json["exp_year"],
        channel: json["channel"],
        cardType: json["card_type"],
        bank: json["bank"],
        countryCode: json["country_code"],
        brand: json["brand"],
        reusable: json["reusable"],
        signature: json["signature"],
        accountName: json["account_name"],
      );

  Map<String, dynamic> toJson() => {
        "authorization_code": authorizationCode,
        "bin": bin,
        "last4": last4,
        "exp_month": expMonth,
        "exp_year": expYear,
        "channel": channel,
        "card_type": cardType,
        "bank": bank,
        "country_code": countryCode,
        "brand": brand,
        "reusable": reusable,
        "signature": signature,
        "account_name": accountName,
      };
}
