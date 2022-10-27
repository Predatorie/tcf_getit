abstract class NotifierBase {
  /// public get property for the errorMessage
  late String errorMessage;

  /// public get property for the hasError
  late bool hasError;

  /// public get property for the isBusy
  late bool isBusy;

  /// clears any outstanding errors
  void clearError() {}

  void setError(String e) {}
}
