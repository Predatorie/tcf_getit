import 'package:flutter/material.dart';
import 'package:tcf_getit/src/models/barbells_dto.dart';
import 'package:tcf_getit/src/services/api_service.dart';

class BarbellService with ChangeNotifier {
  /// backing field for the injected api service
  final ApiService apiService;

  /// private field for the next available page url
  String _nextPageUrl = '';

  /// constructor
  BarbellService({@required this.apiService});

  /// gets or sets the property of all games
  List<Datum> _data = [];
  List<Datum> get barbell => _data;

  /// public property get for the errorMessage
  String errorMessage = '';

  /// public property get for the hasError
  bool hasError = false;

  /// public property get for the isBusy
  bool isBusy = false;

  /// public property get for the hasNextPage
  bool hasNextPage = true;

  /// gets initial list of games limited to 22
  Future<void> getBarbellsAsync() async {
    try {
      this.isBusy = true;

      // first time in so reset list if we are going back and forth
      _data?.clear();

      final response = await apiService.getBarbellLifts();
      if (response.statusCode != 200) {
        this.errorMessage = response.error;
        this.hasError = true;
      } else {
        final barbells = barbellLiftsFromJson(response.bodyString);

        // setup for pagination
        _setNextPageUrl(barbells.links.next);

        // notify those listening
        _data.addAll(barbells.data);
      }
    } catch (e) {
      this.errorMessage = e.toString();
      this.hasError = true;
    } finally {
      this.isBusy = false;
      notifyListeners();
    }
  }

  /// paging next 22
  Future<void> getNextBarbellsAsync() async {
    try {
      this.isBusy = true;

      if (hasNextPage) {
        final response =
            await apiService.getNextBarbellLifts(this._nextPageUrl);

        if (response.statusCode != 200) {
          this.errorMessage = response.error;
          this.hasError = true;
        } else {
          /// get the new list
          final barbells = barbellLiftsFromJson(response.bodyString);

          // setup for pagination
          _setNextPageUrl(barbells.links.next);

          // notify those listening
          _data.addAll(barbells.data);
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
