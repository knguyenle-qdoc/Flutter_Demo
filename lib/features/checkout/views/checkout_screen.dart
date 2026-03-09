import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/checkout/viewmodels/checkout_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkoutItems = ref.watch(checkoutProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final item = checkoutItems[index];
          return ListTile(
            title: Text(item.game.name ?? 'Unknown Game'),
            subtitle: Text('Quantity: ${item.quantity}'),
          );
        },
        itemCount: checkoutItems.length,
      ),
    );
  }
}
