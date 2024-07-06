class CustomApiError implements Exception {
  CustomApiError({required this.message});
  final String message;

  @override
  String toString() {
    return 'CustomApiError(message: $message)';
  }
}
