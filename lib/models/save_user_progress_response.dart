class SaveUserProgressResponse {
  bool saved;
  String? error;

  SaveUserProgressResponse({
    required this.saved,
    this.error,
  });
}
