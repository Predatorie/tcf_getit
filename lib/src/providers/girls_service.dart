import 'package:flutter/material.dart';
import 'package:tcf_getit/src/models/benchmarks_dto.dart';
import 'package:tcf_getit/src/services/api_service.dart';

class GirlsService with ChangeNotifier {
  /// backing field for the injected api service
  final ApiService apiService;

  /// private field for the next available page url
  String _nextPageUrl = '';

  /// constructor
  GirlsService({@required this.apiService});

  /// gets or sets the property of all girls
  List<Datum> _girls = [];
  List<Datum> get girls => _girls;

  /// public property get for the errorMessage
  String errorMessage = '';

  /// public property get for the hasError
  bool hasError = false;

  /// public property get for the isBusy
  bool isBusy = false;

  /// public property get for the hasNextPage
  bool hasNextPage = true;

  /// gets initial list of girls limited to 22
  Future<void> getGirlsAsync() async {
    try {
      this.isBusy = true;

      // first time in so reset list if we are going back and forth
      _girls?.clear();

      final response = await apiService.getBenchmarkByCategory("girls");
      if (response.statusCode != 200) {
        this.errorMessage = response.error;
        this.hasError = true;
      } else {
        final benchmarks = benchmarksFromJson(response.bodyString);

        // setup for pagination
        _setNextPageUrl(benchmarks.links.next);

        // notify those listening
        _girls.addAll(benchmarks.data);
      }
    } catch (e) {
      this.errorMessage = e.toString();
      this.hasError = true;
    } finally {
      this.isBusy = false;
      notifyListeners();
    }
  }

  /// paging next 22 girls
  Future<void> getNextGirlsAsync() async {
    try {
      this.isBusy = true;

      if (hasNextPage) {
        final response =
            await apiService.getNextBenchmarkByCategory("girls", _nextPageUrl);
        if (response.statusCode != 200) {
          this.errorMessage = response.error;
          this.hasError = true;
        } else {
          /// get the new list
          final benchmarks = benchmarksFromJson(response.bodyString);

          // setup for pagination
          _setNextPageUrl(benchmarks.links.next);

          // notify those listening
          _girls.addAll(benchmarks.data);
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
