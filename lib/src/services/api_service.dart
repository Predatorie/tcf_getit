/// flutter packages pub run build_runner watch
import 'package:chopper/chopper.dart';

import '../interceptors/header_interceptor.dart';

part 'api_service.chopper.dart';

@ChopperApi(baseUrl: '/v2')
abstract class ApiService extends ChopperService {
  static ApiService create() {
    final client = ChopperClient(
        baseUrl: 'https://api.sugarwod.com',
        services: [
          _$ApiService(),
        ],
        interceptors: [
          HeaderInterceptor(),
          HttpLoggingInterceptor(),
          CurlInterceptor(),
        ],
        converter: const JsonConverter());

    return _$ApiService(client);
  }

  /// Gets info about our box
  @Get(path: '/box')
  Future<Response> getBox();

  /// A member of an Affiliate. An Athlete has access to the Affiliate's
  /// whiteboard, shared workouts, viewing other athletes, announcements, etc.
  @Get(path: '/athletes?page[limit]=22')
  Future<Response> getAthletes();

  /// Gets the next page of athletes
  /// if next is not null or empty string path and pass in as:
  /// 'page[skip]=22&page[limit]=22'
  @Get(path: '/athletes?{page}')
  Future<Response> getNextAthletes(@Path('page') String page);

  /// Returns a list of Athletes that logged a score for this Workout.
  /// /workouts/{workout_id}/athletes
  @Get(path: '/workouts/{workoutId}/athletes')
  Future<Response> getAthletesThatLoggedScoreForWorkout(
      @Path('workoutId') String workoutId);

  /// Returns a list of Athletes in this Affiliate. The role parameter may be
  /// used to filter the athletes returned. Valid values are "athletes",
  /// "coaches", "owners", "all". This parameter is optional, default is "all".
  @Get(path: '/athletes?role={athletesRole}')
  Future<Response> getAthletesRole(@Path('athletesRole') String athletesRole);

  /// Returns a single Athlete from this Affiliate by Id.
  @Get(path: '/athletes/{id}')
  Future<Response> getAthlete(@Path('id') String id);

  /// Returns a summary of this Athlete's performance metrics, suitable for
  /// embedding in a dashboard. Will include current PRs for 8-12 benchmark
  /// workouts and barbell lifts.
  @Get(path: '/athletes/{id}/summary/performance')
  Future<Response> getAthletePerformanceSummary(@Path('id') String id);

  /// Finds an Athlete in the Affiliate specified by API KEY with the given
  /// email address. Email address must be urlencoded,
  /// i.e. athlete+elite@example.com may be searched with parameter
  /// email=athlete%2belite@example.com
  @Get(path: '/athletes/find?email={email}')
  Future<Response> searchAthleteByEmail(@Path('email') String email);

  /// Returns a summary of this Athlete's participation metrics, suitable for
  /// embedding in a dashboard. Will include current workout, fist bump
  /// and comment counts.
  @Get(path: '/athletes/{id}/summary/participation')
  Future<Response> getAthletePerformanceParticipation(@Path('id') String id);

  /// A Barbell Lift is a workout template which may be scheduled on an
  /// Affiliate's workout calendar, or logged directly by an
  /// Athlete in their Personal Logbook.
  @Get(path: '/barbelllifts?page[limit]=22')
  Future<Response> getBarbellLifts();

  @Get(path: '/barbelllifts?{page}')
  Future<Response> getNextBarbellLifts(@Path('page') String page);

  ///Returns a list of Barbell Lifts in the specified category.
  @Get(path: '/barbelllifts/{category}')
  Future<Response> getBarbellLiftsForCategory(
      @Path('category') String category);

  /// Returns a single of Barbell Lift.
  @Get(path: '/barbelllifts/{barbellliftId}')
  Future<Response> getBarbellLift(@Path('barbellliftId') String barbellliftId);

  /// A Benchmark is a workout template which may be scheduled on an Affiliate's
  /// workout calendar, or logged directly by an Athlete in their
  /// Personal Logbook.
  ///
  /// SugarWOD library of Benchmarks includes 1000s of workouts shared by all
  /// affiliates, including the CrossFit Girls, Heroes, Games, etc.
  /// Affiliates may also define their own "Gym Benchmarks" via the
  /// SugarWOD coach's website.
  ///

  /// Returns a single Benchmark.
  @Get(path: '/benchmark/{benchmarkId}')
  Future<Response> getBenchmark(@Path('benchmarkId') String benchmarkId);

  /// Returns a list of Benchmarks in the specified category.
  @Get(path: '/benchmarks/category/{category}?page[limit]=22')
  Future<Response> getBenchmarkByCategory(@Path('category') String category);

  /// Gets the next page of athletes
  /// if next is not null or empty string path and pass in as:
  /// "/category/heroes?page%5Bskip%5D=22"
  @Get(path: '/benchmarks/category/{category}?{page}')
  Future<Response> getNextBenchmarkByCategory(
      @Path('category') String category, @Path('page') String page);

  /// A Movement is an element of a Workout or Benchmark such as "Box Jump",
  /// "Back Squat", or "Wall Ball".
  /// Returns a list of all Movements.
  @Get(path: '/movements')
  Future<Response> getMovements();

  /// Returns a single of Movement.
  @Get(path: '/movements/{movementId}')
  Future<Response> getMovement(
    @Path('movementId') String movementId,
  );

  /// A Track is calendar of Workouts scheduled for a particular
  /// group of athletes.
  /// Usually corresponds to a program that the Affiliate runs like Workout of
  /// the Day, Barbell Club, Competitors, or Oly Lifting.
  @Get(path: '/tracks')
  Future<Response> getTracks();

  /// A workout scheduled by an Affiliate for a particular date and Track.
  /// Note, Workouts are scheduled for a date, not by class time.
  @Get(path: '/workouts')
  Future<Response> getWorkouts();

  @Get(path: '/workouts/{workoutId}')
  Future<Response> getWorkout(@Path('workoutId') String workoutId);

  /// Retrieve a list of Workouts. Optionally, filter by dates or track_id.
  /// Dates can be a singular date_int or a range separated with a
  /// hyphen (7 day limit).
  /// Default is "today". Note that "today" on our server in the UTC time zone
  /// may be different than what you intended.
  /// If no track_id is given, defaults to "all".
  /// workouts?dates=20210310
  @Get(path: '/workouts?dates={date}')
  Future<Response> getWorkoutsFilterByDate(
    @Query('date') int date,
  );

  @Get(path: '/workouts?dates={fromDate}-{toDate}')
  Future<Response> getWorkoutsFilterByDateRange(
    @Path('fromDate') int fromDate,
    @Path('toDate') int toDate,
  );

  @Get(path: '/workouts?track_id={trackId}')
  Future<Response> getWorkoutsFilterByTrack(
    @Path('trackId') String trackId,
  );

  @Get(path: '/workouts?dates={fromDate}&track_id={trackId}')
  Future<Response> getWorkoutsFilterByDateAndTrack(
    @Path('fromDate') int fromDate,
    @Path('trackId') String trackId,
  );

  /// Retrieve a list of Workouts. Optionally, filter by dates or track_id.
  /// Dates can be a singular date_int or a range separated with a
  /// hyphen (7 day limit).
  /// Default is "today". Note that "today" on our server in the UTC time zone
  /// may be different than what you intended. If no track_id is given,
  /// defaults to "all".
  @Get(path: '/workouts?dates={fromDate}-{toDate}&track_id={trackId}')
  Future<Response> getWorkoutsFilterByDateRangeAndTrack(
      @Path('fromDate') int fromDate,
      @Path('toDate') int toDate,
      @Path('trackId') String trackId);
}
