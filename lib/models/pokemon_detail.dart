import 'pokemon_stat.dart';

class PokemonDetail {
  final String id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final List<String> abilities;
  final List<PokemonStat> stats;

  // NUEVO: altura del Pokémon (la API la devuelve en decímetros)
  final int height;

  // NUEVO: peso del Pokémon (la API lo devuelve en hectogramos)
  final int weight;

  // NUEVO: experiencia base otorgada al derrotar el Pokémon
  final int baseExperience;

  const PokemonDetail({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.abilities,
    required this.stats,
    required this.height,
    required this.weight,
    required this.baseExperience,
  });

  factory PokemonDetail.fromJson(Map<String, dynamic> json) {
    return PokemonDetail(
      id: (json['id'] as int).toString(),
      name: json['name'] as String,
      imageUrl:
          json['sprites']['other']['official-artwork']['front_default']
              as String? ??
          '',
      types: (json['types'] as List)
          .map((item) => item['type']['name'] as String)
          .toList(),
      abilities: (json['abilities'] as List)
          .map((item) => item['ability']['name'] as String)
          .toList(),
      stats: (json['stats'] as List)
          .map((item) => PokemonStat.fromJson(item as Map<String, dynamic>))
          .toList(),

      // NUEVO: altura recibida desde la PokéAPI
      height: json['height'] as int,

      // NUEVO: peso recibido desde la PokéAPI
      weight: json['weight'] as int,

      // NUEVO: experiencia base
      baseExperience: json['base_experience'] as int? ?? 0,
    );
  }

  // NUEVO: convierte "27" en "#027"
  String get formattedId => '#${id.padLeft(3, '0')}';

  // NUEVO: capitaliza el nombre del Pokémon
  String get formattedName => name[0].toUpperCase() + name.substring(1);

  // NUEVO: convierte la altura de decímetros a metros
  double get heightInMeters => height / 10;

  // NUEVO: convierte el peso de hectogramos a kilogramos
  double get weightInKg => weight / 10;
}
