
class InitializeTransactionResponse {
  final bool? status;
  final String? message;
  final InitializeTransactionData? data;

  InitializeTransactionResponse({
    this.status,
    this.message,
    this.data,
  });

  factory InitializeTransactionResponse.fromJson(Map<String, dynamic> json) => InitializeTransactionResponse(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : InitializeTransactionData.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class InitializeTransactionData {
  final String? authorizationUrl;
  final String? accessCode;
  final String? reference;

  InitializeTransactionData({
    this.authorizationUrl,
    this.accessCode,
    this.reference,
  });

  factory InitializeTransactionData.fromJson(Map<String, dynamic> json) => InitializeTransactionData(
    authorizationUrl: json["authorization_url"],
    accessCode: json["access_code"],
    reference: json["reference"],
  );

  Map<String, dynamic> toJson() => {
    "authorization_url": authorizationUrl,
    "access_code": accessCode,
    "reference": reference,
  };
}
