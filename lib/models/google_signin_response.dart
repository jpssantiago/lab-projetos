class GoogleSignInResponse {
  bool authenticated;
  String? error;

  GoogleSignInResponse({
    required this.authenticated,
    this.error,
  });
}
