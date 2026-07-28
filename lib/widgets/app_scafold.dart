import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const AppScaffold({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,

      // NUEVO: NavigationBar Material 3
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,

        // NUEVO: color del indicador
        indicatorColor: Colors.red.shade100,

        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.catching_pokemon),
            selectedIcon: Icon(Icons.catching_pokemon, color: Colors.red),
            label: 'Pokédex',
          ),

          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite, color: Colors.red),
            label: 'Favoritos',
          ),
        ],

        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}
