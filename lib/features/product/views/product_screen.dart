import 'package:flutter/material.dart';
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
        appBar: AppBar(title: Text(game.name!)),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
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
                                  end: Alignment.topCenter,
                                  colors: [Colors.black87, Colors.transparent],
                                ),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                res.name!,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      error: (error, stack) =>
          Scaffold(body: Center(child: Text('Error: $error'))),
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
    );
  }
}
