// todo implement get_it locator

import 'package:get_it/get_it.dart';
import 'package:tcf_getit/src/services/api_service.dart';
import 'package:tcf_getit/src/services/athletes_repository.dart';

// This is our global ServiceLocator
GetIt serviceLocator = GetIt.instance;

void registerTypes() {
  serviceLocator.registerLazySingleton<AthletesRepository>(
      () => AthletesRepository(apiService: ApiService.create()));
}
