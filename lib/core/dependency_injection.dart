import 'package:get_it/get_it.dart';
import '../data/services/base_api.dart';
import '../data/repositories/meal_repository_impl.dart';
import '../domain/repositories/meal_repository.dart';
import '../domain/usecases/search_meals_by_name_usecase.dart';
import '../presentation/bloc/recipes_bloc.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  // Services
  getIt.registerLazySingleton<BaseApi>(() => BaseApi());

  // Repositories
  getIt.registerLazySingleton<MealRepository>(
    () => MealRepositoryImpl(getIt<BaseApi>()),
  );

  // Use Cases
  getIt.registerLazySingleton<SearchMealsByNameUseCase>(
    () => SearchMealsByNameUseCase(getIt<MealRepository>()),
  );

  // BLoCs
  getIt.registerFactory<RecipesBloc>(() => RecipesBloc(getIt<BaseApi>()));
}
