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
}
