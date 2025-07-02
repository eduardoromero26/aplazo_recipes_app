import 'package:aplazo_recipes_app/presentation/bloc/recipes_bloc.dart';
import 'package:aplazo_recipes_app/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPinnedHeader(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<RecipesBloc, RecipesState>(
          builder: (context, state) {
            return TextField(
              controller: context.read<RecipesBloc>().searchFieldController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                hintText: 'Search for meals',
                hintStyle: TypographyTheme.fontMedium20Px,
                prefixIcon: const Icon(Icons.search),
                suffixIcon:
                    context
                        .read<RecipesBloc>()
                        .searchFieldController
                        .text
                        .isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          context
                                  .read<RecipesBloc>()
                                  .searchFieldController
                                  .text =
                              '';
                          context.read<RecipesBloc>().add(
                            SearchMealByNameEvent(
                              name: context
                                  .read<RecipesBloc>()
                                  .searchFieldController
                                  .text,
                            ),
                          );
                        },
                      )
                    : null,
              ),
              onSubmitted: (value) {
                context.read<RecipesBloc>().add(
                  SearchMealByNameEvent(name: value),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
