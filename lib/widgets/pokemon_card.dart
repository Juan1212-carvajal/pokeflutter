import 'package:flutter/material.dart';
import '../models/pokemon.dart';
import 'type_chip.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;
  final bool isFavorite;
  final VoidCallback onFavoriteTap;

  const PokemonCard({
    super.key,
    required this.pokemon,
    required this.isFavorite,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      // NUEVO: color suave según el tipo
      color: TypeChip.colorDelTipo(pokemon.type).withOpacity(.12),

      elevation: 4, // NUEVO
      shadowColor: TypeChip.colorDelTipo(pokemon.type).withOpacity(.30),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),

      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),

            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                // NUEVO: número Pokédex
                Text(
                  '#${pokemon.id.padLeft(3, '0')}',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Image.network(
                  pokemon.imageUrl,
                  height: 120,
                  width: 120,

                  // NUEVO: placeholder si falla la imagen
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.catching_pokemon, size: 80);
                  },
                ),

                const SizedBox(height: 8),

                // NUEVO: nombre capitalizado
                Text(
                  pokemon.name[0].toUpperCase() + pokemon.name.substring(1),

                  textAlign: TextAlign.center,

                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                if (pokemon.type.isNotEmpty) TypeChip(type: pokemon.type),
              ],
            ),
          ),

          Positioned(
            top: 4,
            right: 4,

            child: IconButton(
              onPressed: onFavoriteTap,

              icon: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),

                child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,

                  key: ValueKey(isFavorite),

                  color: isFavorite ? Colors.red : Colors.grey.shade600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
