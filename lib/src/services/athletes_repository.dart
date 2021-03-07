import 'package:flutter/material.dart';
import 'package:tcf_getit/src/models/athletes_dto.dart';
import 'package:tcf_getit/src/services/api_service.dart';

/// Manages athlete state
class AthletesRepository with ChangeNotifier {
  final ApiService apiService;

  AthletesRepository({@required this.apiService});

  /// public property of all athletes
  List<AthleteAttributes> _athletes = [];
  List<AthleteAttributes> get athletes => _athletes;

  /// public flag for progress indicator
  bool isBusy = false;

  /// public flag for next page available
  bool hasNextPage = true;

  /// contains the error message
  String errorMessage = '';

  /// next available page url
  String _nextPageUrl = '';

  /// gets initial list of athletes limited to 22
  Future<void> getAthletesAsync() async {
    isBusy = true;
    try {
      // first time in so reset list if we are going back and forth
      _athletes?.clear();

      final json = await apiService.getAthletes();
      final athletes = athletesFromJson(json.bodyString);

      // setup for pagination
      _setNextPageUrl(athletes.links.next);

      // map athletes dto to List<AthleteAttributes>
      final a = athletes.data.map((e) => e.attributes).toList();

      /// do we need the athlete id?
      /*athletes.data.forEach((element) {
        var id = element.id;
        var list = element.attributes;
      });*/

      // notify those listening
      _athletes.addAll(a);
    } catch (e) {
      errorMessage = e.toString();
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
        final json = await apiService.getNextAthletes(_nextPageUrl);

        /// get the new list of athletes
        final athletes = athletesFromJson(json.bodyString);

        // setup for pagination
        _setNextPageUrl(athletes.links.next);

        // map athletes dto to List<AthleteAttributes>
        final a = athletes.data.map((e) => e.attributes).toList();

        // notify those listening
        _athletes.addAll(a);
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isBusy = false;
      notifyListeners();
    }
  }

  /// Sets up flag and value for pagination
  _setNextPageUrl(String next) {
    /// set flag
    hasNextPage = next != null && next.isNotEmpty;

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
}
