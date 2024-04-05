class InitializeTransactionRequest {
  final String email;
  final int amount;
  final String? reference;
  final String? currency;
  final String? callbackUrl;
  final String? plan;
  final int? invoiceLimit;
  final List<String>? channels;
  final String? splitCode;
  final String? subAccount;
  final num? transactionCharge;
  final String? bearer;

  InitializeTransactionRequest({
    required this.email,
    required this.amount,
    this.reference,
    this.currency,
    this.callbackUrl,
    this.plan,
    this.invoiceLimit,
    this.channels,
    this.splitCode,
    this.subAccount,
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
    subAccount: json["subaccount"],
    transactionCharge: json["transaction_charge"],
    bearer: json["bearer"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "amount": amount,
   if(reference != null) "reference": reference,
    if(currency != null)  "currency": currency,
    if(callbackUrl != null)  "callback_url": callbackUrl,
    if(plan != null)  "plan": plan,
    if(invoiceLimit != null)  "invoice_limit": invoiceLimit,
    if(channels != null)  "channels": channels,
    if(splitCode != null) "split_code": splitCode,
    if(subAccount != null) "subaccount": subAccount,
    if(transactionCharge != null) "transaction_charge": transactionCharge,
    if(bearer != null)  "bearer": bearer,
  };
}
