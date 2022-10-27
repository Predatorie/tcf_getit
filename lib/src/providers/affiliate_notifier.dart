import 'package:flutter/material.dart';

import '../exceptions/timeout_exception.dart';
import '../models/box_dto.dart';
import '../services/sugarwod_service.dart';
import 'base_notifier.dart';

class AffiliateNotifier extends ChangeNotifier implements NotifierBase {
  /// backing field for the injected api service
  final SugarWodService sugarWod;

  AffiliateNotifier({required this.sugarWod});

  late Data _information;
  Data get info => _information;

  Future<void> getAffiliateAsync() async {
    try {
      isBusy = true;

      clearError();

      final result = await sugarWod.getAffiliateAsync();
      if (result != null) {
        _information = result;
      }
    } on NetworkTimeOutException {
      hasError = true;
      errorMessage = 'Connection timed out.';
    } on Exception catch (e) {
      setError('$e');
    } finally {
      isBusy = false;
      notifyListeners();
    }
  }

  @override
  String errorMessage = '';

  @override
  bool hasError = false;

  @override
  bool isBusy = false;

  @override
  void clearError() {
    errorMessage = '';
    hasError = false;
  }

  @override
  void setError(String e) {
    errorMessage = '$e';
    hasError = true;
  }
}
