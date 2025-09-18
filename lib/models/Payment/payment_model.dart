class PaymentResponse {
  final bool errors;
  final String message;
  final PaymentData? data;

  PaymentResponse({
    required this.errors,
    required this.message,
    this.data,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      errors: json['errors'] as bool,
      message: json['message'] as String,
      data:
          json['data'] != null ? PaymentData.fromJson(json['data'] as Map<String, dynamic>) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'errors': errors,
      'message': message,
      'data': data?.toJson(),
    };
  }
}

class PaymentData {
  final String status;
  final String statusDisplayName;
  final String method;
  final String methodDisplayName;
  final String redirectUrl;

  PaymentData({
    required this.status,
    required this.statusDisplayName,
    required this.method,
    required this.methodDisplayName,
    required this.redirectUrl,
  });

  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      status: json['status'] as String,
      statusDisplayName: json['statusDisplayName'] as String,
      method: json['method'] as String,
      methodDisplayName: json['methodDisplayName'] as String,
      redirectUrl: json['redirectUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'statusDisplayName': statusDisplayName,
      'method': method,
      'methodDisplayName': methodDisplayName,
      'redirectUrl': redirectUrl,
    };
  }
}
