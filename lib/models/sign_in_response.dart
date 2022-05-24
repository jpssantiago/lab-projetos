class SignInResponse {
  bool authenticated;
  String? error;

  SignInResponse({
    required this.authenticated,
    this.error,
  });
}
