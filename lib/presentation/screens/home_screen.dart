import 'package:aplazo_recipes_app/domain/models/meal_model.dart';
import 'package:aplazo_recipes_app/presentation/bloc/recipes_bloc.dart';
import 'package:aplazo_recipes_app/presentation/widgets/layout_widget.dart';
import 'package:aplazo_recipes_app/presentation/widgets/lottie_widget.dart';
import 'package:aplazo_recipes_app/presentation/widgets/meals_list/meals_sliver_list.dart';
import 'package:aplazo_recipes_app/presentation/widgets/search_text_field.dart';
import 'package:aplazo_recipes_app/presentation/widgets/meals_list/infinite_scroll_meals_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool get _isSearching =>
      context.read<RecipesBloc>().searchFieldController.text.isNotEmpty;

  @override
  void initState() {
    context.read<RecipesBloc>().add(SearchMealByNameEvent(name: ''));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutWidget(
      currentIndex: 0,
      child: BlocConsumer<RecipesBloc, RecipesState>(
        listener: (BuildContext context, RecipesState state) {},
        builder: (context, state) {
          return CustomScrollView(
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
              if (!_isSearching) ...[
                const InfiniteScrollMealsGrid(),
                const SliverToBoxAdapter(
                  child: Padding(padding: EdgeInsets.all(20.0)),
                ),
              ] else ...[
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
                    SliverFillRemaining(child: const LoadingLottieView()),
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
                        return SliverFillRemaining(
                          child: EmptySearchLottieView(),
                        );
                      }
                    }(),
                  RecipesState()
                      when state.runtimeType.toString().contains(
                        'LoadedFailed',
                      ) =>
                    const SliverFillRemaining(child: ErrorLottieView()),
                  _ => const SliverToBoxAdapter(child: SizedBox.shrink()),
                },
              ],
            ],
          );
        },
      ),
    );
  }
}
