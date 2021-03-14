import 'dart:io';

import 'package:flutter/material.dart';
import 'package:tcf_getit/src/models/box_dto.dart';
import 'package:tcf_getit/src/services/api_service.dart';

class AffiliateService with ChangeNotifier {
  /// backing field for the injected api service
  final ApiService apiService;

  AffiliateService({@required this.apiService});

  Data _data;
  Data get info => _data;

  /// public get property for the errorMessage
  String errorMessage = '';

  /// public get property for the hasError
  bool hasError = false;

  /// public get property for the isBusy
  bool isBusy = false;

  Future<void> getAffiliateAsync() async {
    try {
      this.isBusy = true;

      // clear to be safe
      _data = null;

      var response = await this.apiService.getBox();

      switch (response.statusCode) {
        case HttpStatus.ok:
          _clearError();
          final box = boxFromJson(response.bodyString);
          _data = box.data;

          break;

        case HttpStatus.noContent:
          _setError('Unable to retrieve affiliate information.');
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
