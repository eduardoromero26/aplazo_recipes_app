import '../models/meal_model.dart';

abstract class MealRepository {
  Future<MealsModel> searchMealsByName(String name);
  Future<List<Meal>> getRandomMealsForPage(int pageKey);
}
