import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/checkout/models/checkout_item_model.dart';
import 'package:flutter_application_1/features/checkout/viewmodels/checkout_viewmodel.dart';
import 'package:flutter_application_1/features/games/models/game.dart';
import 'package:flutter_application_1/features/product/views/product_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GameCard extends ConsumerStatefulWidget {
  final Game game;

  const GameCard({super.key, required this.game});

  @override
  ConsumerState<GameCard> createState() => _GameCardState();
}

class _GameCardState extends ConsumerState<GameCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedScale(
        scale: _hovered ? 1.05 : 1.0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black26.withValues(alpha: (_hovered ? 0.4 : 0.2)),
                blurRadius: _hovered ? 20 : 8,
                spreadRadius: _hovered ? 2 : 0,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: GestureDetector(
            onTap: () {
              // Navigate to product details page
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductScreen(game: widget.game),
                ),
              );
            },
            child: Card(
              clipBehavior: Clip.hardEdge,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    widget.game.backgroundImage!,
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
                        widget.game.name!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: IconButton(
                      onPressed: () {
                        ref
                            .read(checkoutProvider.notifier)
                            .addItem(CheckoutItem(game: widget.game));
                      },
                      icon: const Icon(Icons.add_shopping_cart_rounded),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
