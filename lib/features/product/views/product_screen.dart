import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/checkout/models/checkout_item_model.dart';
import 'package:flutter_application_1/features/checkout/viewmodels/checkout_viewmodel.dart';
import 'package:flutter_application_1/features/games/models/game.dart';
import 'package:flutter_application_1/features/product/viewmodels/products_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductScreen extends ConsumerWidget {
  final Game game;

  const ProductScreen({super.key, required this.game});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameProduct = ref.watch(productsViewModelProvider(game.id!));

    return gameProduct.when(
      data: (res) => Scaffold(
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0F172A), // deep navy
                Color(0xFF020617), // near black
                Color(0xFF1E293B),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      flex: 2,
                      child: SizedBox(
                        height: 600,
                        child: AspectRatio(
                          aspectRatio: 16 / 9,
                          child: Card(
                            clipBehavior: Clip.hardEdge,
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                Image.network(
                                  res.backgroundImage!,
                                  fit: BoxFit.cover,
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.bottomCenter,
                                        end: Alignment.center,
                                        colors: [
                                          Colors.black87,
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 600,
                        child: Card(
                          color: Colors.grey.shade800.withValues(alpha: 0.2),
                          clipBehavior: Clip.hardEdge,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              spacing: 16,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                      res.name!,
                                      style: const TextStyle(
                                        fontSize: 32,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: SingleChildScrollView(
                                    child: Text(
                                      res.descriptionRaw ??
                                          'No description available',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            WidgetStateProperty.resolveWith<
                                              Color?
                                            >((states) {
                                              if (states.contains(
                                                WidgetState.hovered,
                                              )) {
                                                return Colors
                                                    .lightGreen
                                                    .shade500
                                                    .withValues(alpha: 0.6);
                                              }
                                              return Colors.lightGreen.shade500
                                                  .withValues(alpha: 0.5);
                                            }),
                                      ),
                                      onPressed: () => ref
                                          .read(checkoutProvider.notifier)
                                          .addItem(CheckoutItem(game: game)),
                                      child: Text(
                                        'Add to Cart',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      error: (error, stack) =>
          Scaffold(body: Center(child: Text('Error: $error'))),
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
