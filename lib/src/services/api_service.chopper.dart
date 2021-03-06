// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// ChopperGenerator
// **************************************************************************

class _$ApiService extends ApiService {
  _$ApiService([ChopperClient client]) {
    if (client == null) return;
    this.client = client;
  }

  final definitionType = ApiService;

  Future<Response> getBox() {
    final $url = '/v2/box';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getAthletes() {
    final $url = '/v2/athletes?page[limit]=22';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getNextAthletes(String page) {
    final $url = '/v2/athletes?${page}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getAthletesThatLoggedScoreForWorkout(String workoutId) {
    final $url = '/v2/workouts/${workoutId}/athletes';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getAthletesRole(String athletesRole) {
    final $url = '/v2/athletes?role=${athletesRole}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getAthlete(String id) {
    final $url = '/v2/athletes/${id}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getAthletePerformanceSummary(String id) {
    final $url = '/v2/athletes/${id}/summary/performance';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> searchAthleteByEmail(String email) {
    final $url = '/v2/athletes/find?email=${email}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getAthletePerformanceParticipation(String id) {
    final $url = '/v2/athletes/${id}/summary/participation';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getBarbellLifts() {
    final $url = '/v2/barbelllifts';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getBarbellLiftsForCategory(String category) {
    final $url = '/v2/barbelllifts/${category}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getBarbellLift(String barbellliftId) {
    final $url = '/v2/barbelllifts/${barbellliftId}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getBenchmarks() {
    final $url = '/v2/benchmarks';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getBenchmark(String benchmarkId) {
    final $url = '/v2/benchmark/${benchmarkId}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getBenchmarkByCategory(String category) {
    final $url = '/v2/benchmarks/category/${category}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getMovements() {
    final $url = '/v2/movements';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getMovement(String movementId) {
    final $url = '/v2/movements/${movementId}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getTracks() {
    final $url = '/v2/tracks';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getWorkouts() {
    final $url = '/v2/workouts';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getWorkout(String workoutId) {
    final $url = '/v2/workouts/${workoutId}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getWorkoutsFilterByDate(int date) {
    final $url = '/v2/?dates=date';
    final Map<String, dynamic> $params = {'date': date};
    final $request = Request('GET', $url, client.baseUrl, parameters: $params);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getWorkoutsFilterByDateRange(int fromDate, int toDate) {
    final $url = '/v2/?dates=${fromDate}-${toDate}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getWorkoutsFilterByTrack(String trackId) {
    final $url = '/v2/?track_id=${trackId}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getWorkoutsFilterByDateAndTrack(
      int fromDate, String trackId) {
    final $url = '/v2/?dates=${fromDate}&track_id=${trackId}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }

  Future<Response> getWorkoutsFilterByDateRangeAndTrack(
      int fromDate, int toDate, String trackId) {
    final $url = '/v2/?dates=${fromDate}-${toDate}&track_id=${trackId}';
    final $request = Request('GET', $url, client.baseUrl);
    return client.send<dynamic, dynamic>($request);
  }
}
