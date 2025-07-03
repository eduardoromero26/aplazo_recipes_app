import 'package:aplazo_recipes_app/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:sliver_tools/sliver_tools.dart';

class SearchTextField extends StatefulWidget {
  final TextEditingController? controller;
  final void Function() onClearClicked;
  final Function(String) onSearchClicked;
  const SearchTextField({
    super.key,
    this.controller,
    required this.onClearClicked,
    required this.onSearchClicked,
  });

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  @override
  Widget build(BuildContext context) {
    return SliverPinnedHeader(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            hintText: 'Search for meals',
            hintStyle: TypographyTheme.fontMedium20Px,
            prefixIcon: const Icon(Icons.search),
            suffixIcon: widget.controller?.text.isNotEmpty == true
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: widget.onClearClicked,
                  )
                : null,
          ),
          onSubmitted: widget.onSearchClicked,
        ),
      ),
    );
  }
}
