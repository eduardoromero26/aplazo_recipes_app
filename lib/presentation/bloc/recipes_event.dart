part of 'recipes_bloc.dart';

abstract class RecipesEvent {}

class SearchMealByNameEvent extends RecipesEvent {
  final String name;
  final int? pageKey;
  SearchMealByNameEvent({required this.name, this.pageKey});
}

class ResetSearchControllerEvent extends RecipesEvent {}

class ToggleFavoriteMealEvent extends RecipesEvent {
  final Meal meal;
  ToggleFavoriteMealEvent({required this.meal});
}

class AddMealToFavoritesEvent extends RecipesEvent {
  final Meal meal;
  AddMealToFavoritesEvent({required this.meal});
}

class RemoveMealFromFavoritesEvent extends RecipesEvent {
  final Meal meal;
  RemoveMealFromFavoritesEvent({required this.meal});
}

class GetRandomMealsEvent extends RecipesEvent {
  final int? pageKey;
  GetRandomMealsEvent({this.pageKey});
}
