abstract class NotifierBase {
  /// public get property for the errorMessage
  String errorMessage;

  /// public get property for the hasError
  bool hasError;

  /// public get property for the isBusy
  bool isBusy;

  /// clears any outstanding errors
  void clearError() {}

  void setError(String e) {}
}
