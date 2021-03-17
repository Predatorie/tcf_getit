import 'package:flutter/material.dart';
import 'package:tcf_getit/src/exceptions/timeout_exception.dart';
import 'package:tcf_getit/src/models/wods_dto.dart';
import 'package:tcf_getit/src/providers/base_notifier.dart';
import 'package:tcf_getit/src/services/sugarwod_service.dart';

class WodNotifier extends ChangeNotifier implements NotifierBase {
  /// backing field for the injected api service
  final SugarWodService sugarWod;

  /// constructor
  WodNotifier({@required this.sugarWod});

  /// gets or sets the public property of all athletes
  List<WodDatum> _data = [];
  List<WodDatum> get wod => _data;

  /// Gets the workout for the date specified
  Future<void> getWorkOutOfTheDayByDateAsync(DateTime date) async {
    try {
      this.isBusy = true;

      _data?.clear();

      clearError();

      var result = await this.sugarWod.getWorkOutOfTheDayByDateAsync(date);
      if (result.isNotEmpty) {
        _data.addAll(result);
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
