import 'package:aplazo_recipes_app/data/services/base_api.dart';
import 'package:aplazo_recipes_app/domain/models/meal_model.dart';
import 'package:aplazo_recipes_app/utils/endpoints.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'recipes_bloc.freezed.dart';
part 'recipes_event.dart';
part 'recipes_state.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  MealsModel? mealList = const MealsModel();
  TextEditingController searchFieldController = TextEditingController(text: '');

  RecipesBloc(BaseApi baseApi) : super(RecipesState.initial()) {
    on<SearchMealByNameEvent>((event, emit) async {
      emit(RecipesState.loadingStarted());
      try {
        final Response<dynamic> json = await baseApi.getFromApi(
          '${Endpoints.searchMealByName}${event.name}',
        );
        mealList = MealsModel.fromJson(json.data);
        mealList?.meals != null
            ? emit(RecipesState.loadedSuccess(mealList))
            : emit(RecipesState.loadedFailed('No meals found'));
      } catch (e) {
        emit(RecipesState.loadedFailed(e.toString()));
      }
    });
    on<ResetSearchControllerEvent>((event, emit) {
      searchFieldController.text = '';
    });
  }
}
