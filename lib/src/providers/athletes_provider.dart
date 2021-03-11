import 'package:flutter/material.dart';
import 'package:tcf_getit/src/models/athletes_dto.dart';
import 'package:tcf_getit/src/services/api_service.dart';

/// Manages athlete state
class AthletesService with ChangeNotifier {
  /// backing field for the injected api service
  final ApiService apiService;

  /// private field for the next available page url
  String _nextPageUrl = '';

  /// constructor
  AthletesService({@required this.apiService});

  /// gets or sets the property of all athletes
  List<AthleteAttributes> _athletes = [];
  List<AthleteAttributes> get athletes => _athletes;

  /// public property get for the errorMessage
  String errorMessage = '';

  /// public property get for the hasError
  bool hasError = false;

  /// public property get for the isBusy
  bool isBusy = false;

  /// public property get for the hasNextPage
  bool hasNextPage = true;

  /// gets initial list of athletes limited to 22
  Future<void> getAthletesAsync() async {
    try {
      this.isBusy = true;

      // first time in so reset list if we are going back and forth
      _athletes?.clear();

      final response = await apiService.getAthletes();
      if (response.statusCode != 200) {
        this.errorMessage = response.error;
        this.hasError = true;
      } else {
        final athletes = athletesFromJson(response.bodyString);

        // setup for pagination
        _setNextPageUrl(athletes.links.next);

        // map athletes dto to List<AthleteAttributes>
        final a = athletes.data.map((e) => e.attributes).toList();

        // notify those listening
        _athletes.addAll(a);
      }
    } catch (e) {
      this.errorMessage = e.toString();
      this.hasError = true;
    } finally {
      this.isBusy = false;
      notifyListeners();
    }
  }

  /// paging next 22 athletes
  Future<void> getNextAthletesAsync() async {
    try {
      this.isBusy = true;

      /// additional safety check, caller should check hasNextPage property
      /// before invoking getNextAthletesAsync()
      if (hasNextPage) {
        final response = await apiService.getNextAthletes(_nextPageUrl);
        if (response.statusCode != 200) {
          this.errorMessage = response.error;
          this.hasError = true;
        } else {
          /// get the new list of athletes
          final athletes = athletesFromJson(response.bodyString);

          // setup for pagination
          _setNextPageUrl(athletes.links.next);

          // map athletes dto to List<AthleteAttributes>
          final a = athletes.data.map((e) => e.attributes).toList();

          // notify those listening
          _athletes.addAll(a);
        }
      }
    } catch (e) {
      this.errorMessage = e.toString();
      this.hasError = true;
    } finally {
      this.isBusy = false;
      notifyListeners();
    }
  }

  /// Sets up flag and value for pagination
  _setNextPageUrl(String next) {
    /// set flag
    this.hasNextPage = next != null && next.isNotEmpty;

    /// set url
    if (this.hasNextPage) {
      // get the full url and take right of the '?'
      final link = next;
      final page = link.split('?');

      this._nextPageUrl = page[1];
    } else {
      this._nextPageUrl = '';
    }
  }
}
