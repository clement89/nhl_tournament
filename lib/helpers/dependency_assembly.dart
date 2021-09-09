import 'package:get_it/get_it.dart';
import 'package:nhl_tournament/core/networking/api_repository.dart';
import 'package:nhl_tournament/core/viewmodels/matches_viewmodel.dart';

GetIt dependencyAssembler = GetIt.instance;

void setupDependencyAssembler() {
  dependencyAssembler.registerLazySingleton(() => ApiRepository());
  dependencyAssembler.registerFactory(() => MatchesViewModel());
}
