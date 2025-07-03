import 'package:aplazo_recipes_app/domain/models/meal_model.dart';
import 'package:aplazo_recipes_app/domain/repositories/meal_repository.dart';
import 'package:aplazo_recipes_app/presentation/bloc/recipes_bloc.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'recipes_bloc_test.mocks.dart';

@GenerateMocks([MealRepository])
void main() {
  group('RecipesBloc ', () {
    late RecipesBloc recipesBloc;
    late MockMealRepository mockRepository;

    setUp(() {
      mockRepository = MockMealRepository();
      recipesBloc = RecipesBloc(mockRepository);
    });

    blocTest<RecipesBloc, RecipesState>(
      'emits [loadingStarted, loadedSuccess] when SearchMealByNameEvent is added and repository call is successful',
      build: () => recipesBloc,
      act: (bloc) {
        when(
          mockRepository.searchMealsByName('test'),
        ).thenAnswer((_) async => MealsModel.fromJson({'meals': []}));
        bloc.add(SearchMealByNameEvent(name: 'test'));
      },
      expect: () => [
        RecipesState.loadingStarted(),
        RecipesState.loadedSuccess(MealsModel.fromJson({'meals': []})),
      ],
    );

    blocTest<RecipesBloc, RecipesState>(
      'emits [loadingStarted, loadedFailed] when SearchMealByNameEvent is added and repository call fails',
      build: () => recipesBloc,
      act: (bloc) {
        when(
          mockRepository.searchMealsByName('test'),
        ).thenThrow(Exception('Error occurred'));
        bloc.add(SearchMealByNameEvent(name: 'test'));
      },
      expect: () => [
        RecipesState.loadingStarted(),
        RecipesState.loadedFailed('Exception: Error occurred'),
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
