import 'dart:collection';

import 'package:flutter/material.dart';

import '../exceptions/timeout_exception.dart';
import '../models/benchmarks_dto.dart';
import '../services/sugarwod_service.dart';
import 'base_notifier.dart';

class BenchmarkNotifier extends ChangeNotifier implements NotifierBase {
  /// backing field for the injected api service
  final SugarWodService sugarWod;

  /// private field for the next available page url
  String _nextPageUrl = '';

  /// private field for the category param
  String _category = '';

  /// constructor
  BenchmarkNotifier({required this.sugarWod});

  /// gets or sets the property of all games
  final List<BenchmarksDatum> _benchmarks = [];
  UnmodifiableListView<BenchmarksDatum> get benchmarks =>
      UnmodifiableListView(_benchmarks);

  /// public property get for the hasNextPage
  bool hasNextPage = true;

  /// gets initial list of games limited to 22
  Future<void> getBenchmarkByCategoryAsync(String category) async {
    try {
      isBusy = true;

      // cache for the next page query
      _category = category;

      clearError();

      // clear
      _benchmarks.clear();

      final response = await sugarWod.getBenchmarkByCategoryAsync(category);
      if (response != null) {
        // setup for pagination
        _setNextPageUrl(response.links.next);

        // notify those listening
        _benchmarks.addAll(response.data);
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

  /// paging next 22
  Future<void> getNextBenchmarkByCategoryAsync() async {
    try {
      isBusy = true;

      if (hasNextPage) {
        final response = await sugarWod.getNextBenchmarkByCategoryAsync(
          _category,
          _nextPageUrl,
        );

        if (response != null) {
          // setup for pagination
          _setNextPageUrl(response.links.next);

          // notify those listening
          _benchmarks.addAll(response.data);
        }
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

  /// Sets up flag and value for pagination
  void _setNextPageUrl(String next) {
    /// set flag
    hasNextPage = next.isNotEmpty;

    /// set url
    if (hasNextPage) {
      // get the full url and take right of the '?'
      final link = next;
      final page = link.split('?');

      _nextPageUrl = page[1];
    } else {
      _nextPageUrl = '';
    }
  }

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

  @override
  String errorMessage = '';

  @override
  bool hasError = false;

  @override
  bool isBusy = false;
}
