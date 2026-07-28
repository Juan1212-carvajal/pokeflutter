import 'package:flutter/material.dart';
import '../models/pokemon_detail.dart';
import '../models/pokemon_stat.dart';
import '../services/pokemon_service.dart';
import '../widgets/error_view.dart';
import '../widgets/type_chip.dart';

class DetailScreen extends StatefulWidget {
  final String id;

  const DetailScreen({super.key, required this.id});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final _service = PokemonService();

  late Future<PokemonDetail> _detailFuture;

  @override
  void initState() {
    super.initState();
    _detailFuture = _service.fetchPokemonDetail(widget.id);
  }

  void _retry() {
    setState(() {
      _detailFuture = _service.fetchPokemonDetail(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<PokemonDetail>(
        future: _detailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return ErrorView(error: snapshot.error, onRetry: _retry);
          }

          return _DetailView(detail: snapshot.data!);
        },
      ),
    );
  }
}

class _DetailView extends StatelessWidget {
  final PokemonDetail detail;

  const _DetailView({required this.detail});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      // NUEVO: fondo dinámico según el tipo principal
      color: TypeChip.colorDelTipo(detail.types.first).withOpacity(.08),

      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Center(
            child: Image.network(
              detail.imageUrl,

              // NUEVO: imagen más grande
              height: 250,

              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.catching_pokemon, size: 120);
              },
            ),
          ),

          const SizedBox(height: 16),

          // NUEVO: número Pokédex
          Text(
            detail.formattedId,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          // NUEVO: nombre capitalizado
          Text(
            detail.formattedName,
            textAlign: TextAlign.center,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            children: [for (final type in detail.types) TypeChip(type: type)],
          ),

          const SizedBox(height: 24),

          // NUEVO: información adicional
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  const Icon(Icons.height),
                  const SizedBox(height: 4),
                  Text('${detail.heightInMeters} m'),
                ],
              ),
              Column(
                children: [
                  const Icon(Icons.monitor_weight),
                  const SizedBox(height: 4),
                  Text('${detail.weightInKg} kg'),
                ],
              ),
              Column(
                children: [
                  const Icon(Icons.star),
                  const SizedBox(height: 4),
                  Text('${detail.baseExperience} XP'),
                ],
              ),
            ],
          ),

          const SizedBox(height: 32),

          Text('Estadísticas', style: theme.textTheme.titleMedium),

          const SizedBox(height: 12),

          for (final stat in detail.stats) _StatRow(stat: stat),

          const SizedBox(height: 32),

          Text('Habilidades', style: theme.textTheme.titleMedium),

          const SizedBox(height: 8),

          // NUEVO: habilidades más bonitas
          for (final ability in detail.abilities)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  const Icon(Icons.star, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    ability
                        .replaceAll('-', ' ')
                        .split(' ')
                        .map(
                          (word) => word[0].toUpperCase() + word.substring(1),
                        )
                        .join(' '),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final PokemonStat stat;

  const _StatRow({required this.stat});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(width: 110, child: Text(stat.name)),
          Expanded(
            child: LinearProgressIndicator(
              value: stat.value / 255,
              minHeight: 8,
            ),
          ),
          const SizedBox(width: 8),
          Text('${stat.value}'),
        ],
      ),
    );
  }
}
