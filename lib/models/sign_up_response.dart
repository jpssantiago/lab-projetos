class SignUpResponse {
  bool authenticated;
  String? error;

  SignUpResponse({
    required this.authenticated,
    this.error,
  });
}
