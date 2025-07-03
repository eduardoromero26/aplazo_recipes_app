import 'package:aplazo_recipes_app/domain/models/meal_model.dart';
import 'package:aplazo_recipes_app/presentation/bloc/recipes_bloc.dart';
import 'package:aplazo_recipes_app/presentation/widgets/lotties/empty_search_lottie_view.dart';
import 'package:aplazo_recipes_app/presentation/widgets/lotties/error_lottie_view.dart';
import 'package:aplazo_recipes_app/presentation/widgets/lotties/loading_lottie_view.dart';
import 'package:aplazo_recipes_app/presentation/widgets/meals_sliver_list.dart';
import 'package:aplazo_recipes_app/presentation/widgets/search_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    context.read<RecipesBloc>().add(SearchMealByNameEvent(name: ''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<RecipesBloc, RecipesState>(
        listener: (BuildContext context, RecipesState state) {},
        builder: (context, state) {
          return Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                SearchTextField(
                  controller: context.read<RecipesBloc>().searchFieldController,
                  onClearClicked: () {
                    context.read<RecipesBloc>().searchFieldController.text = '';
                    context.read<RecipesBloc>().add(
                      SearchMealByNameEvent(
                        name: context
                            .read<RecipesBloc>()
                            .searchFieldController
                            .text,
                      ),
                    );
                  },
                  onSearchClicked: (String name) {
                    context.read<RecipesBloc>().add(
                      SearchMealByNameEvent(name: name),
                    );
                  },
                ),
                switch (state) {
                  RecipesState() when state == const RecipesState.initial() =>
                    const SliverToBoxAdapter(
                      child: Center(
                        child: Text(
                          'Search for your favorite recipes!',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  RecipesState()
                      when state == const RecipesState.loadingStarted() =>
                    LoadingLottieView(),
                  RecipesState()
                      when state.runtimeType.toString().contains(
                        'LoadedSuccess',
                      ) =>
                    () {
                      final dynamic loadedState = state;
                      final meals = loadedState.meals as MealsModel?;
                      if (meals != null &&
                          meals.meals != null &&
                          meals.meals!.isNotEmpty) {
                        return MealsSliverList(meals: meals.meals);
                      } else {
                        return EmptySearchLottieView();
                      }
                    }(),
                  RecipesState()
                      when state.runtimeType.toString().contains(
                        'LoadedFailed',
                      ) =>
                    const SliverToBoxAdapter(child: ErrorLottieView()),
                  _ => const SliverToBoxAdapter(child: SizedBox.shrink()),
                },
              ],
            ),
          );
        },
      ),
    );
  }
}
