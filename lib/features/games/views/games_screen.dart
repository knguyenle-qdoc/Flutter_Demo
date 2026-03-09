import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/widgets/game_card.dart';
import 'package:flutter_application_1/features/checkout/views/checkout_screen.dart';
import 'package:flutter_application_1/features/games/viewmodels/games_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Displays the games list and reacts to async provider state.
///
/// React analogy:
/// - Similar to a component calling `const { data, isLoading, error, refetch } = useGames()`.
class GamesScreen extends ConsumerStatefulWidget {
  const GamesScreen({super.key});

  @override
  ConsumerState<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends ConsumerState<GamesScreen> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = ref.watch(searchQueryProvider);

    final gamesAsync = query.isEmpty
        ? ref.watch(gamesViewModelProvider)
        : ref.watch(gamesSearchProvider(query));

    return Scaffold(
      appBar: AppBar(
        title: const Text('QGames Store'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ref.read(gamesViewModelProvider.notifier).refresh();
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CheckoutScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              onSubmitted: (value) => ref
                  .read(gamesViewModelProvider.notifier)
                  .runSearch(ref, value),
              decoration: InputDecoration(
                hintText: 'Search games...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),

          Expanded(
            child: gamesAsync.when(
              data: (res) => GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 250 / 400,
                ),
                itemCount: res.results.length,
                itemBuilder: (context, index) {
                  final game = res.results[index];
                  return GameCard(game: game);
                },
              ),
              error: (error, stack) => Center(child: Text('Error: $error')),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
        ],
      ),
    );
  }
}
