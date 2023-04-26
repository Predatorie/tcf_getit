import 'package:flutter/material.dart';

import '../exceptions/timeout_exception.dart';
import '../models/wods_dto.dart';
import '../services/sugarwod_service.dart';
import 'base_notifier.dart';

class WodNotifier extends ChangeNotifier implements NotifierBase {
  /// backing field for the injected api service
  final SugarWodService sugarWod;

  /// constructor
  WodNotifier({required this.sugarWod});

  /// gets or sets the public property of all athletes
  final List<WodDatum> _data = [];
  List<WodDatum> get wod => _data;

  /// Gets the workout for the date specified
  Future<void> getWorkOutOfTheDayByDateAsync(DateTime date) async {
    try {
      isBusy = true;

      _data.clear();

      clearError();

      final result = await sugarWod.getWorkOutOfTheDayByDateAsync(date);
      if (result.isNotEmpty) {
        _data.addAll(result);
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
