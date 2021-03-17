import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tcf_getit/src/exceptions/timeout_exception.dart';
import 'package:tcf_getit/src/models/athletes_dto.dart';
import 'package:tcf_getit/src/models/barbells_dto.dart';
import 'package:tcf_getit/src/models/benchmarks_dto.dart';
import 'package:tcf_getit/src/models/box_dto.dart';
import 'package:tcf_getit/src/models/wods_dto.dart';
import 'package:tcf_getit/src/services/api_service.dart';

class SugarWodService {
  /// backing field for the injected api service
  final ApiService apiService;

  SugarWodService({@required this.apiService});

  /// gets the box information
  Future<Data> getAffiliateAsync() async {
    try {
      var response = await this.apiService.getBox();

      if (response.statusCode == HttpStatus.ok) {
        final box = boxFromJson(response.bodyString);
        return box.data;
      }

      if (response.statusCode == HttpStatus.networkConnectTimeoutError) {
        throw NetworkTimeOutException();
      }
    } on Exception catch (e) {
      throw e;
    }

    return null;
  }

  /// Gets the workout for the date specified
  Future<List<WodDatum>> getWorkOutOfTheDayByDateAsync(DateTime date) async {
    try {
      // https://api.sugarwod.com/v2/workouts?dates=20210310
      int today = int.parse(DateFormat('yyyyMMdd').format(date));

      var response =
          await this.apiService.getWorkoutsFilterByDateRange(today, today);

      if (response.statusCode == HttpStatus.ok) {
        final wod = workoutsFromJson(response.bodyString);
        return wod.data;
      }

      if (response.statusCode == HttpStatus.networkConnectTimeoutError) {
        throw NetworkTimeOutException();
      }
    } on Exception catch (e) {
      throw e;
    }

    return [];
  }

  /// gets initial list of games limited to 22
  Future<Benchmarks> getBenchmarkByCategoryAsync(String category) async {
    try {
      final response = await apiService.getBenchmarkByCategory(category);
      if (response.statusCode == HttpStatus.ok) {
        return benchmarksFromJson(response.bodyString);
      }

      if (response.statusCode == HttpStatus.networkConnectTimeoutError) {
        throw NetworkTimeOutException();
      }
    } on Exception catch (e) {
      throw e;
    }

    return null;
  }

  /// paging next 22
  Future<Benchmarks> getNextBenchmarkByCategoryAsync(
      String category, String nextPage) async {
    try {
      final response =
          await apiService.getNextBenchmarkByCategory(category, nextPage);
      if (response.statusCode == HttpStatus.ok) {
        return benchmarksFromJson(response.bodyString);
      }

      if (response.statusCode == HttpStatus.networkConnectTimeoutError) {
        throw NetworkTimeOutException();
      }
    } on Exception catch (e) {
      throw e;
    }

    return null;
  }

  /// gets initial list of games limited to 22
  Future<BarbellLifts> getBarbellsAsync() async {
    try {
      final response = await apiService.getBarbellLifts();

      if (response.statusCode == HttpStatus.ok) {
        return barbellLiftsFromJson(response.bodyString);
      }

      if (response.statusCode == HttpStatus.networkConnectTimeoutError) {
        throw NetworkTimeOutException();
      }
    } on Exception catch (e) {
      throw e;
    }

    return null;
  }

  /// paging next 22
  Future<BarbellLifts> getNextBarbellsAsync(String nextPage) async {
    try {
      final response = await apiService.getNextBarbellLifts(nextPage);

      if (response.statusCode == HttpStatus.ok) {
        return barbellLiftsFromJson(response.bodyString);
      }

      if (response.statusCode == HttpStatus.networkConnectTimeoutError) {
        throw NetworkTimeOutException();
      }
    } on Exception catch (e) {
      throw e;
    }

    return null;
  }

  /// gets initial list of athletes limited to 22
  Future<AthletesDto> getAthletesAsync() async {
    try {
      final response = await apiService.getAthletes();
      if (response.statusCode == HttpStatus.ok) {
        return athletesFromJson(response.bodyString);
      }

      if (response.statusCode == HttpStatus.networkConnectTimeoutError) {
        throw NetworkTimeOutException();
      }
    } on Exception catch (e) {
      throw e;
    }

    return null;
  }

  /// paging next 22 athletes
  Future<AthletesDto> getNextAthletesAsync(String page) async {
    try {
      final response = await apiService.getNextAthletes(page);
      if (response.statusCode == HttpStatus.ok) {
        return athletesFromJson(response.bodyString);
      }

      if (response.statusCode == HttpStatus.networkConnectTimeoutError) {
        throw NetworkTimeOutException();
      }
    } on Exception catch (e) {
      throw e;
    }

    return null;
  }
}
