import 'package:flutter_application_1/features/games/models/game.dart';

class CheckoutItem {
  final Game game;
  final int quantity;

  const CheckoutItem({required this.game, this.quantity = 1});

  Map<String, dynamic> toJson() => {
    'game': game.toJson(),
    'quantity': quantity,
  };

  factory CheckoutItem.fromJson(Map<String, dynamic> json) {
    return CheckoutItem(
      game: Game.fromJson(json['game']),
      quantity: json['quantity'] as int,
    );
  }
}
