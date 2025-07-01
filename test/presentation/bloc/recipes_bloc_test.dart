import 'package:aplazo_recipes_app/data/services/base_api.dart';
import 'package:aplazo_recipes_app/domain/models/meal_model.dart';
import 'package:aplazo_recipes_app/presentation/bloc/recipes_bloc.dart';
import 'package:aplazo_recipes_app/presentation/bloc/recipes_event.dart';
import 'package:aplazo_recipes_app/presentation/bloc/recipes_state.dart';
import 'package:aplazo_recipes_app/utils/endpoints.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'recipes_bloc_test.mocks.dart';

@GenerateMocks([BaseApi])
void main() {
  group('RecipesBloc ', () {
    late RecipesBloc recipesBloc;
    late MockBaseApi mockApi;

    setUp(() {
      mockApi = MockBaseApi();
      recipesBloc = RecipesBloc(mockApi);
    });

    blocTest<RecipesBloc, RecipesState>(
      'emits [loadingStarted, loadedSuccess] when SearchMealByNameEvent is added and api call is successful',
      build: () => recipesBloc,
      act: (bloc) {
        when(
          mockApi.getFromApi('${Endpoints.searchMealByName}test'),
        ).thenAnswer(
          (_) async => Response(
            data: {'meals': []},
            statusCode: 200,
            requestOptions: RequestOptions(
              path: '${Endpoints.searchMealByName}test',
            ),
          ),
        );
        bloc.add(SearchMealByNameEvent(name: 'test'));
      },
      expect: () => [
        RecipesState.loadingStarted(),
        RecipesState.loadedSuccess(MealsModel.fromJson({'meals': []})),
      ],
    );

    blocTest<RecipesBloc, RecipesState>(
      'emits [loadingStarted, loadedFailed] when SearchMealByNameEvent is added and api call fails',
      build: () => recipesBloc,
      act: (bloc) {
        when(mockApi.getFromApi('${Endpoints.searchMealByName}test')).thenThrow(
          DioException(
            requestOptions: RequestOptions(
              path: '${Endpoints.searchMealByName}test',
            ),
            error: 'Error occurred',
          ),
        );
        bloc.add(SearchMealByNameEvent(name: 'test'));
      },
      expect: () => [
        RecipesState.loadingStarted(),
        RecipesState.loadedFailed(
          'DioException [unknown]: null\nError: Error occurred',
        ),
      ],
    );

    blocTest<RecipesBloc, RecipesState>(
      'emits no state when ResetSearchControllerEvent is added',
      build: () => recipesBloc,
      act: (bloc) => bloc.add(ResetSearchControllerEvent()),
      expect: () => [],
    );
  });
}
