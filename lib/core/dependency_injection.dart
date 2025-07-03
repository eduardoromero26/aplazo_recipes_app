import 'package:get_it/get_it.dart';
import '../data/services/base_api.dart';
import '../data/repositories/meal_repository_impl.dart';
import '../domain/repositories/meal_repository.dart';
import '../presentation/bloc/recipes_bloc.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Services
  getIt.registerLazySingleton<BaseApi>(() => BaseApi());

  // Repositories
  getIt.registerLazySingleton<MealRepository>(
    () => MealRepositoryImpl(getIt<BaseApi>()),
  );

  // BLoCs
  getIt.registerFactory<RecipesBloc>(
    () => RecipesBloc(getIt<MealRepository>()),
  );
}
