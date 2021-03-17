import 'package:flutter/material.dart';
import 'package:tcf_getit/src/exceptions/timeout_exception.dart';
import 'package:tcf_getit/src/models/box_dto.dart';
import 'package:tcf_getit/src/providers/base_notifier.dart';
import 'package:tcf_getit/src/services/sugarwod_service.dart';

class AffiliateNotifier extends ChangeNotifier implements NotifierBase {
  /// backing field for the injected api service
  final SugarWodService sugarWod;

  AffiliateNotifier({@required this.sugarWod});

  Data _information;
  Data get info => _information;

  Future<void> getAffiliateAsync() async {
    try {
      this.isBusy = true;

      clearError();

      var result = await this.sugarWod.getAffiliateAsync();
      if (result != null) {
        _information = result;
      }
    } on NetworkTimeOutException {
      this.hasError = true;
      this.errorMessage = 'Connection timed out.';
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
    this.errorMessage = '';
    this.hasError = false;
  }

  @override
  void setError(String e) {
    this.errorMessage = "$e";
    this.hasError = true;
  }
}
