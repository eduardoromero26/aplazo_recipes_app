import '../models/meal_model.dart';
import '../repositories/meal_repository.dart';

class SearchMealsByNameUseCase {
  final MealRepository _repository;

  SearchMealsByNameUseCase(this._repository);

  Future<MealsModel> call(String name) async {
    if (name.trim().isEmpty) {
      throw Exception('Search name cannot be empty');
    }
    return await _repository.searchMealsByName(name);
  }
}
