import 'package:flutter/material.dart';

class TypeChip extends StatelessWidget {
  final String type;

  const TypeChip({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(
        // NUEVO: formatea el texto para mostrar "Ground" en lugar de "ground"
        _formatType(type),
        style: const TextStyle(
          // NUEVO: texto en blanco para mejor contraste
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),

      // NUEVO: colores dinámicos según el tipo Pokémon
      backgroundColor: colorDelTipo(type),

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
    );
  }

  // NUEVO: método público para reutilizar colores
  // desde PokemonCard o PokemonDetail
  static Color colorDelTipo(String tipo) {
    switch (tipo.toLowerCase()) {
      // NUEVO
      case 'fire':
        return Colors.deepOrange;

      // NUEVO
      case 'water':
        return Colors.blue;

      // NUEVO
      case 'grass':
        return Colors.green;

      // NUEVO
      case 'electric':
        return Colors.amber.shade700;

      // NUEVO
      case 'ground':
        return Colors.brown;

      // NUEVO
      case 'rock':
        return Colors.brown.shade700;

      // NUEVO
      case 'poison':
        return Colors.purple;

      // NUEVO
      case 'psychic':
        return Colors.pink;

      // NUEVO
      case 'ice':
        return Colors.cyan;

      // NUEVO
      case 'dragon':
        return Colors.indigo;

      // NUEVO
      case 'ghost':
        return Colors.deepPurple;

      // NUEVO
      case 'bug':
        return Colors.lightGreen;

      // NUEVO
      case 'fighting':
        return Colors.red.shade700;

      // NUEVO
      case 'flying':
        return Colors.lightBlue;

      // NUEVO
      case 'steel':
        return Colors.blueGrey;

      // NUEVO
      case 'fairy':
        return Colors.pink.shade200;

      // NUEVO
      case 'normal':
        return Colors.grey;

      default:
        return Colors.grey.shade500;
    }
  }

  // NUEVO: capitaliza el tipo
  // ground -> Ground
  // fire -> Fire
  static String _formatType(String type) {
    if (type.isEmpty) return '';

    return type[0].toUpperCase() + type.substring(1);
  }
}
