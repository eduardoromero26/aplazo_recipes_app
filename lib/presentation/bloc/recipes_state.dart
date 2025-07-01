import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/meal_model.dart';

part 'recipes_state.freezed.dart';

@freezed
class RecipesState with _$RecipesState {
  factory RecipesState.initial() = _Initial;
  factory RecipesState.loadingStarted() = _LoadingStarted;
  factory RecipesState.loadedSuccess(MealsModel? meals) = _LoadedSuccess;
  factory RecipesState.loadedFailed(String message) = _LoadedFailed;
}
