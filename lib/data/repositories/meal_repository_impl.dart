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

      for (int i = 0; i < pageSize; i++) {
        try {
          final response = await _baseApi.getFromApi(Endpoints.randomMeal);
          final mealsModel = MealsModel.fromJson(response.data);

          if (mealsModel.meals != null && mealsModel.meals!.isNotEmpty) {
            randomMeals.add(mealsModel.meals!.first);
          }

          await Future.delayed(const Duration(milliseconds: 100));
        } catch (e) {
          debugPrint('Error getting random meal: $e');
        }
      }

      return randomMeals;
    } catch (e) {
      throw Exception('Error loading random meals: $e');
    }
  }
}
