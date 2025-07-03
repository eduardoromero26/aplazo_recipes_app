import 'package:aplazo_recipes_app/routes/route_names.dart';
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
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
          ],
          currentIndex: currentIndex ?? 0,
          selectedItemColor: Colors.amber[800],
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
