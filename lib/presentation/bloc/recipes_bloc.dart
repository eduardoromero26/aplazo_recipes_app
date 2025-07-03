import 'package:aplazo_recipes_app/domain/models/meal_model.dart';
import 'package:aplazo_recipes_app/domain/repositories/meal_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipes_bloc.freezed.dart';
part 'recipes_event.dart';
part 'recipes_state.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  final MealRepository _mealRepository;
  MealsModel? mealList = const MealsModel();
  TextEditingController searchFieldController = TextEditingController(text: '');
  List<Meal> favoriteMeals = [];
  bool isSearching = false;

  bool isMealFavorite(String mealId) {
    return favoriteMeals.any((meal) => meal.idMeal == mealId);
  }

  RecipesBloc(this._mealRepository) : super(RecipesState.initial()) {
    on<SearchMealByNameEvent>((event, emit) async {
      isSearching = true;
      emit(RecipesState.loadingStarted());
      try {
        final mealsModel = await _mealRepository.searchMealsByName(event.name);
        mealList = mealsModel;
        mealList?.meals != null
            ? emit(RecipesState.loadedSuccess(mealList))
            : emit(RecipesState.loadedFailed('No meals found'));
      } catch (e) {
        isSearching = false;
        emit(RecipesState.loadedFailed(e.toString()));
      }
    });
    on<ResetSearchControllerEvent>((event, emit) {
      searchFieldController.text = '';
      isSearching = false;
      emit(RecipesState.initial());
    });
    on<ToggleFavoriteMealEvent>((event, emit) {
      final isFavorite = favoriteMeals.any(
        (meal) => meal.idMeal == event.meal.idMeal,
      );

      if (isFavorite) {
        favoriteMeals.removeWhere((meal) => meal.idMeal == event.meal.idMeal);
      } else {
        favoriteMeals.add(event.meal);
      }

      emit(RecipesState.loadedSuccess(mealList));
    });
    on<AddMealToFavoritesEvent>((event, emit) {
      if (!favoriteMeals.any((meal) => meal.idMeal == event.meal.idMeal)) {
        favoriteMeals.add(event.meal);
      }
      emit(RecipesState.loadedSuccess(mealList));
    });
    on<RemoveMealFromFavoritesEvent>((event, emit) {
      favoriteMeals.removeWhere((meal) => meal.idMeal == event.meal.idMeal);
      emit(RecipesState.loadedSuccess(mealList));
    });
    on<GetRandomMealsEvent>((event, emit) async {
      emit(RecipesState.loadingStarted());
      try {
        final mealsModel = await _mealRepository.getRandomMealsForPage(
          event.pageKey ?? 0,
        );
        mealList = MealsModel(meals: mealsModel);
        emit(RecipesState.loadedSuccess(mealList));
      } catch (e) {
        emit(RecipesState.loadedFailed(e.toString()));
      }
    });
  }

  //TODO: Implement pagination for normal empty search
  Future<List<Meal>> getRandomMealsForPage(int pageKey) async {
    return await _mealRepository.getRandomMealsForPage(pageKey);
  }
}
