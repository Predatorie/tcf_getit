import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tcf_getit/src/models/wods_dto.dart';
import 'package:tcf_getit/src/services/api_service.dart';

class WodService with ChangeNotifier {
  /// backing field for the injected api service
  final ApiService apiService;

  /// constructor
  WodService({@required this.apiService});

  /// gets or sets the public property of all athletes
  List<Datum> _data = [];
  List<Datum> get wod => _data;

  /// public get property for the errorMessage
  String errorMessage = '';

  /// public get property for the hasError
  bool hasError = false;

  /// public get property for the isBusy
  bool isBusy = false;

  /// Gets the workout for the date specified
  Future<void> getWorkOutOfTheDayByDateAsync(DateTime date) async {
    try {
      this.isBusy = true;

      // clear to be safe
      _data?.clear();

      // https://api.sugarwod.com/v2/workouts?dates=20210310
      int today = int.parse(DateFormat('yyyyMMdd').format(date));

      var response =
          await this.apiService.getWorkoutsFilterByDateRange(today, today);

      switch (response.statusCode) {
        case HttpStatus.ok:
          _clearError();
          final wod = workoutsFromJson(response.bodyString);
          _data.addAll(wod.data);

          break;

        case HttpStatus.noContent:
          _setError('Unable to retrieve work out of the day.');
          break;

        case HttpStatus.networkConnectTimeoutError:
          _setError('Connection timed out. Try again later.');
          break;

        default:
          _setError(response.error.toString());
          break;
      }
    } catch (e) {
      _setError("Unhandled Exception:\n$e");
    } finally {
      isBusy = false;
      notifyListeners();
    }
  }

  /// clears any outstanding errors
  void _clearError() {
    this.errorMessage = '';
    this.hasError = false;
  }

  void _setError(String e) {
    this.errorMessage = "$e";
    this.hasError = true;
  }
}
