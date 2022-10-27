import 'dart:collection';

import 'package:flutter/material.dart';

import '../models/barbells_dto.dart';
import '../services/sugarwod_service.dart';
import 'base_notifier.dart';

class BarbellNotifier extends ChangeNotifier implements NotifierBase {
  /// backing field for the injected api service
  final SugarWodService sugarWod;

  /// private field for the next available page url
  String _nextPageUrl = '';

  /// constructor
  BarbellNotifier({required this.sugarWod});

  /// gets or sets the property of all games
  final List<BarbellsDatum> _barbells = [];
  UnmodifiableListView<BarbellsDatum> get barbell =>
      UnmodifiableListView(_barbells);

  /// public property get for the hasNextPage
  bool hasNextPage = true;

  /// gets initial list of games limited to 22
  Future<void> getBarbellsAsync() async {
    try {
      isBusy = true;

      clearError();

      // first time in so reset list if we are going back and forth
      _barbells.clear();

      final response = await sugarWod.getBarbellsAsync();
      if (response != null) {
        _barbells.addAll(response.data);

        // setup for pagination
        _setNextPageUrl(response.links.next);
      }
    } catch (e) {
      setError('$e');
    } finally {
      isBusy = false;
      notifyListeners();
    }
  }

  /// paging next 22
  Future<void> getNextBarbellsAsync() async {
    try {
      isBusy = true;

      clearError();

      if (hasNextPage) {
        final response = await sugarWod.getNextBarbellsAsync(_nextPageUrl);

        // setup for pagination
        _setNextPageUrl(response!.links.next);

        // notify those listening
        _barbells.addAll(response!.data);
      }
    } catch (e) {
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
