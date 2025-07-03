import 'package:aplazo_recipes_app/routes/route_names.dart';
import 'package:aplazo_recipes_app/utils/styles/colors_theme.dart';
import 'package:flutter/material.dart';

class LayoutWidget extends StatelessWidget {
  final int? currentIndex;
  final Widget? child;
  const LayoutWidget({super.key, this.child, this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: ColorsTheme.primaryColor,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_outline),
              activeIcon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
          ],
          currentIndex: currentIndex ?? 0,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(0.8),
          onTap: (int index) {
            if (index == 0) {
              Navigator.pushNamed(context, RouteNames.home);
            } else if (index == 1) {
              Navigator.pushNamed(context, RouteNames.favorites);
            }
          },
        ),
        body: child,
      ),
    );
  }
}
