// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
final class _$ApiService extends ApiService {
  _$ApiService([ChopperClient? client]) {
    if (client == null) return;
    this.client = client;
  }

  @override
  final Type definitionType = ApiService;

  @override
  Future<Response<dynamic>> getBox() {
    final Uri $url = Uri.parse('/v2/box');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAthletes() {
    final Uri $url = Uri.parse('/v2/athletes?page[limit]=22');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getNextAthletes(String page) {
    final Uri $url = Uri.parse('/v2/athletes?${page}');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAthletesThatLoggedScoreForWorkout(
    String workoutId,
  ) {
    final Uri $url = Uri.parse('/v2/workouts/${workoutId}/athletes');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAthletesRole(String athletesRole) {
    final Uri $url = Uri.parse('/v2/athletes?role=${athletesRole}');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAthlete(String id) {
    final Uri $url = Uri.parse('/v2/athletes/${id}');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAthletePerformanceSummary(String id) {
    final Uri $url = Uri.parse('/v2/athletes/${id}/summary/performance');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> searchAthleteByEmail(String email) {
    final Uri $url = Uri.parse('/v2/athletes/find?email=${email}');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getAthletePerformanceParticipation(String id) {
    final Uri $url = Uri.parse('/v2/athletes/${id}/summary/participation');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getBarbellLifts() {
    final Uri $url = Uri.parse('/v2/barbelllifts?page[limit]=22');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getNextBarbellLifts(String page) {
    final Uri $url = Uri.parse('/v2/barbelllifts?${page}');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getBarbellLiftsForCategory(String category) {
    final Uri $url = Uri.parse('/v2/barbelllifts/${category}');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getBarbellLift(String barbellliftId) {
    final Uri $url = Uri.parse('/v2/barbelllifts/${barbellliftId}');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getBenchmark(String benchmarkId) {
    final Uri $url = Uri.parse('/v2/benchmark/${benchmarkId}');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getBenchmarkByCategory(String category) {
    final Uri $url = Uri.parse(
      '/v2/benchmarks/category/${category}?page[limit]=22',
    );
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getNextBenchmarkByCategory(
    String category,
    String page,
  ) {
    final Uri $url = Uri.parse('/v2/benchmarks/category/${category}?${page}');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMovements() {
    final Uri $url = Uri.parse('/v2/movements');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getMovement(String movementId) {
    final Uri $url = Uri.parse('/v2/movements/${movementId}');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getTracks() {
    final Uri $url = Uri.parse('/v2/tracks');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getWorkouts() {
    final Uri $url = Uri.parse('/v2/workouts');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getWorkout(String workoutId) {
    final Uri $url = Uri.parse('/v2/workouts/${workoutId}');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getWorkoutsFilterByDate(int date) {
    final Uri $url = Uri.parse('/v2/workouts?dates={date}');
    final Map<String, dynamic> $params = <String, dynamic>{'date': date};
    final Request $request = Request(
      'GET',
      $url,
      client.baseUrl,
      parameters: $params,
    );
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getWorkoutsFilterByDateRange(
    int fromDate,
    int toDate,
  ) {
    final Uri $url = Uri.parse('/v2/workouts?dates=${fromDate}-${toDate}');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getWorkoutsFilterByTrack(String trackId) {
    final Uri $url = Uri.parse('/v2/workouts?track_id=${trackId}');
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getWorkoutsFilterByDateAndTrack(
    int fromDate,
    String trackId,
  ) {
    final Uri $url = Uri.parse(
      '/v2/workouts?dates=${fromDate}&track_id=${trackId}',
    );
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  @override
  Future<Response<dynamic>> getWorkoutsFilterByDateRangeAndTrack(
    int fromDate,
    int toDate,
    String trackId,
  ) {
    final Uri $url = Uri.parse(
      '/v2/workouts?dates=${fromDate}-${toDate}&track_id=${trackId}',
    );
    final Request $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
