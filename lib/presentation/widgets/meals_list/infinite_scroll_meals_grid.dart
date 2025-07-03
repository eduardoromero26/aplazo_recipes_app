import 'package:aplazo_recipes_app/domain/models/meal_model.dart';
import 'package:aplazo_recipes_app/presentation/bloc/recipes_bloc.dart';
import 'package:aplazo_recipes_app/presentation/widgets/meal_list_tile.dart';
import 'package:aplazo_recipes_app/routes/route_names.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class InfiniteScrollMealsGrid extends StatefulWidget {
  const InfiniteScrollMealsGrid({super.key});

  @override
  State<InfiniteScrollMealsGrid> createState() =>
      _InfiniteScrollMealsGridState();
}

class _InfiniteScrollMealsGridState extends State<InfiniteScrollMealsGrid> {
  late final _pagingController = PagingController<int, Meal>(
    getNextPageKey: (state) =>
        state.lastPageIsEmpty ? null : state.nextIntPageKey,
    fetchPage: (pageKey) =>
        context.read<RecipesBloc>().getRandomMealsForPage(pageKey),
  );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: PagingListener(
        controller: _pagingController,
        builder: (context, state, fetchNextPage) => PagedListView<int, Meal>(
          state: state,
          fetchNextPage: fetchNextPage,
          builderDelegate: PagedChildBuilderDelegate(
            itemBuilder: (context, meal, index) => MealListTile(
              meal: meal,
              onTap: () async {
                await Navigator.pushNamed(
                  context,
                  RouteNames.details,
                  arguments: meal,
                );
              },
            ),
            firstPageErrorIndicatorBuilder: (context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading meals',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => _pagingController.refresh(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
            newPageErrorIndicatorBuilder: (context) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 32, color: Colors.red),
                  const SizedBox(height: 8),
                  const Text('Error loading more meals'),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () => fetchNextPage(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
            firstPageProgressIndicatorBuilder: (context) =>
                const Center(child: CircularProgressIndicator()),
            newPageProgressIndicatorBuilder: (context) => const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
            ),
            noItemsFoundIndicatorBuilder: (context) => const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.restaurant, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No meals available',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
