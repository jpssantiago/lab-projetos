class PasswordRecoveryResponse {
  bool sent;
  String? error;

  PasswordRecoveryResponse({
    required this.sent,
    this.error,
  });
}
