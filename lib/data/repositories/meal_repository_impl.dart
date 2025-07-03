import 'package:flutter/material.dart';
import '../../domain/models/meal_model.dart';
import '../../domain/repositories/meal_repository.dart';
import '../../utils/endpoints.dart';
import '../services/base_api.dart';

class MealRepositoryImpl implements MealRepository {
  final BaseApi _baseApi;

  MealRepositoryImpl(this._baseApi);

  @override
  Future<MealsModel> searchMealsByName(String name) async {
    try {
      final response = await _baseApi.getFromApi(
        '${Endpoints.searchMealByName}$name',
      );
      return MealsModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to search meals: $e');
    }
  }

  @override
  Future<List<Meal>> getRandomMealsForPage(int pageKey) async {
    try {
      const pageSize = 10;
      List<Meal> randomMeals = [];
      Set<String> usedMealIds = {};
      int attempts = 0;
      const maxAttempts = 50;
      while (randomMeals.length < pageSize && attempts < maxAttempts) {
        try {
          final response = await _baseApi.getFromApi(Endpoints.randomMeal);
          final mealsModel = MealsModel.fromJson(response.data);

          if (mealsModel.meals != null && mealsModel.meals!.isNotEmpty) {
            final meal = mealsModel.meals!.first;

            if (!usedMealIds.contains(meal.idMeal)) {
              usedMealIds.add(meal.idMeal);
              randomMeals.add(meal);
            }
          }

          attempts++;
          await Future.delayed(const Duration(milliseconds: 100));
        } catch (e) {
          attempts++;
          debugPrint('Error getting random meal: $e');
        }
      }

      return randomMeals;
    } catch (e) {
      throw Exception('Error loading random meals: $e');
    }
  }
}
