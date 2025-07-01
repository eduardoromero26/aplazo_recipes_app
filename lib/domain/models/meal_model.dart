import 'package:equatable/equatable.dart';

class MealsModel extends Equatable {
  final List<Meal>? meals;

  const MealsModel({this.meals});

  factory MealsModel.fromJson(Map<String, dynamic> parsedJson) {
    if (parsedJson['meals'] != null) {
      var list = parsedJson['meals'] as List;
      List<Meal> mealsList = list.map((i) => Meal.fromJson(i)).toList();
      return MealsModel(meals: mealsList);
    } else {
      return const MealsModel(meals: []);
    }
  }

  @override
  List<Object?> get props => [meals];
}

class Meal extends Equatable {
  final String idMeal;
  final String strMeal;
  final String? strDrinkAlternate;
  final String strCategory;
  final String strArea;
  final String strInstructions;
  final String strMealThumb;
  final String? strTags;
  final String? strYoutube;
  final List<String> ingredients;
  final List<String> measures;
  final String? strSource;
  final String? strImageSource;
  final String? strCreativeCommonsConfirmed;
  final String? dateModified;

  const Meal({
    required this.idMeal,
    required this.strMeal,
    this.strDrinkAlternate,
    required this.strCategory,
    required this.strArea,
    required this.strInstructions,
    required this.strMealThumb,
    this.strTags,
    this.strYoutube,
    required this.ingredients,
    required this.measures,
    this.strSource,
    this.strImageSource,
    this.strCreativeCommonsConfirmed,
    this.dateModified,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];
    List<String> measures = [];

    for (int i = 1; i <= 20; i++) {
      if (json['strIngredient$i'] != null) {
        ingredients.add(json['strIngredient$i']);
      }
      if (json['strMeasure$i'] != null) {
        measures.add(json['strMeasure$i']);
      }
    }

    return Meal(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strDrinkAlternate: json['strDrinkAlternate'],
      strCategory: json['strCategory'],
      strArea: json['strArea'],
      strInstructions: json['strInstructions'],
      strMealThumb: json['strMealThumb'],
      strTags: json['strTags'],
      strYoutube: json['strYoutube'],
      ingredients: ingredients,
      measures: measures,
      strSource: json['strSource'],
      strImageSource: json['strImageSource'],
      strCreativeCommonsConfirmed: json['strCreativeCommonsConfirmed'],
      dateModified: json['dateModified'],
    );
  }

  @override
  List<Object?> get props => [
    idMeal,
    strMeal,
    strDrinkAlternate,
    strCategory,
    strArea,
    strInstructions,
    strMealThumb,
    strTags,
    strYoutube,
    ingredients,
    measures,
    strSource,
    strImageSource,
    strCreativeCommonsConfirmed,
    dateModified,
  ];
}
