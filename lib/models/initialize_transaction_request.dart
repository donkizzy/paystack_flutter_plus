class InitializeTransactionRequest {
  final String? email;
  final String? amount;
  final String? reference;
  final String? currency;
  final String? callbackUrl;
  final String? plan;
  final int? invoiceLimit;
  final String? channels;
  final String? splitCode;
  final String? subaccount;
  final int? transactionCharge;
  final String? bearer;

  InitializeTransactionRequest({
    this.email,
    this.amount,
    this.reference,
    this.currency,
    this.callbackUrl,
    this.plan,
    this.invoiceLimit,
    this.channels,
    this.splitCode,
    this.subaccount,
    this.transactionCharge,
    this.bearer,
  });

  factory InitializeTransactionRequest.fromJson(Map<String, dynamic> json) => InitializeTransactionRequest(
    email: json["email"],
    amount: json["amount"],
    reference: json["reference"],
    currency: json["currency"],
    callbackUrl: json["callback_url"],
    plan: json["plan"],
    invoiceLimit: json["invoice_limit"],
    channels: json["channels"],
    splitCode: json["split_code"],
    subaccount: json["subaccount"],
    transactionCharge: json["transaction_charge"],
    bearer: json["bearer"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "amount": amount,
    "reference": reference,
    "currency": currency,
    "callback_url": callbackUrl,
    "plan": plan,
    "invoice_limit": invoiceLimit,
    "channels": channels,
    "split_code": splitCode,
    "subaccount": subaccount,
    "transaction_charge": transactionCharge,
    "bearer": bearer,
  };
}
