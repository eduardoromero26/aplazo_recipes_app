part of 'recipes_bloc.dart';

abstract class RecipesEvent {}

class SearchMealByNameEvent extends RecipesEvent {
  final String name;
  SearchMealByNameEvent({required this.name});
}

class ResetSearchControllerEvent extends RecipesEvent {}
