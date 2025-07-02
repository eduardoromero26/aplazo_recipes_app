// import 'package:aplazo_recipes_app/data/services/base_api.dart';
// import 'package:aplazo_recipes_app/domain/models/meal_model.dart';
// import 'package:aplazo_recipes_app/utils/endpoints.dart';

// class RecipesRepository {
//   final BaseApi api;

//   RecipesRepository(this.api);

//   Future<MealsModel> searchMealByName(String name) async {
//     final response = await api.getFromApi('${Endpoints.searchMealByName}$name');
//     return MealsModel.fromJson(response.data);
//   }
// }
