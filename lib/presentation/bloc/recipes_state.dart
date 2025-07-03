part of 'recipes_bloc.dart';

@freezed
class RecipesState with _$RecipesState {
  const factory RecipesState.initial() = _Initial;
  const factory RecipesState.loadingStarted() = _LoadingStarted;
  const factory RecipesState.loadedSuccess(MealsModel? meals) = _LoadedSuccess;
  const factory RecipesState.loadedFailed(String message) = _LoadedFailed;
}
