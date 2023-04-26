import 'dart:collection';

import 'package:flutter/material.dart';

import '../models/athletes_dto.dart';
import '../services/sugarwod_service.dart';
import 'base_notifier.dart';

/// Manages athlete state
class AthletesNotifier extends ChangeNotifier implements NotifierBase {
  /// backing field for the injected api service
  final SugarWodService sugarWod;

  /// private field for the next available page url
  String _nextPageUrl = '';

  /// constructor
  AthletesNotifier({required this.sugarWod});

  /// gets or sets the property of all athletes
  final List<AthleteAttributes> _athletes = [];
  UnmodifiableListView<AthleteAttributes> get athletes =>
      UnmodifiableListView(_athletes);

  /// public property get for the hasNextPage
  bool hasNextPage = true;

  /// gets initial list of athletes limited to 22
  Future<void> getAthletesAsync() async {
    try {
      isBusy = true;

      // first time in so reset list if we are going back and forth
      _athletes.clear();

      final response = await sugarWod.getAthletesAsync();

      // setup for pagination
      _setNextPageUrl(response!.links.next);

      // map athletes dto to List<AthleteAttributes>
      final a = response.data.map((e) => e.attributes).toList();

      // notify those listening
      _athletes.addAll(a);
    } catch (e) {
      setError('$e');
    } finally {
      isBusy = false;
      notifyListeners();
    }
  }

  /// paging next 22 athletes
  Future<void> getNextAthletesAsync() async {
    try {
      isBusy = true;

      /// additional safety check, caller should check hasNextPage property
      /// before invoking getNextAthletesAsync()
      if (hasNextPage) {
        final response = await sugarWod.getNextAthletesAsync(_nextPageUrl);

        // setup for pagination
        _setNextPageUrl(response!.links.next);

        // map athletes dto to List<AthleteAttributes>
        final a = response.data.map((e) => e.attributes).toList();

        // notify those listening
        _athletes.addAll(a);
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
