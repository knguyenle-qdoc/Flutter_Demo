import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/checkout/viewmodels/checkout_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkoutItems = ref.watch(checkoutProvider);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16),
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
        child: Column(
          spacing: 32,
          children: [
            SizedBox(
              width: double.infinity,
              child: Text(
                checkoutItems.isEmpty ? '' : 'Your Cart',
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              child: checkoutItems.isEmpty
                  ? Expanded(
                      child: Center(
                        child: Text(
                          'Your cart is empty!',
                          style: TextStyle(color: Colors.white70, fontSize: 18),
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: checkoutItems.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final item = checkoutItems[index];
                        return SizedBox(
                          width: double.infinity,
                          height: 150,
                          child: Card(
                            color: Colors.grey.shade800.withValues(alpha: 0.3),
                            child: Padding(
                              padding: const EdgeInsetsGeometry.all(8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: SizedBox(
                                        width: 100, // poster width
                                        child: AspectRatio(
                                          aspectRatio: 2 / 3, // poster ratio
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                            child: Image.network(
                                              item.game.backgroundImage!,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 8,
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            item.game.name ?? 'Unknown Game',
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              color: Colors.white70,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: double.infinity,
                                          child: Text(
                                            'Quantity: ${item.quantity}',
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              color: Colors.white54,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => ref
                                        .read(checkoutProvider.notifier)
                                        .removeItem(item.game.id!),
                                    iconSize: 32,
                                    icon: Icon(
                                      Icons.remove_shopping_cart_outlined,
                                    ),
                                    color: Colors.red.shade900,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Column(
              spacing: 8,
              children: checkoutItems.isEmpty
                  ? []
                  : [
                      Divider(color: Colors.white54),
                      SizedBox(
                        width: double.infinity,
                        child: Row(
                          spacing: 8,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red.shade600,
                              ),
                              onPressed: () => {
                                ref
                                    .read(checkoutProvider.notifier)
                                    .clearCheckoutItems(),
                                Fluttertoast.showToast(
                                  msg: 'Cart cleared.',
                                  toastLength: Toast.LENGTH_SHORT,
                                  timeInSecForIosWeb: 3,
                                  backgroundColor: Colors.red.shade700,
                                  fontSize: 24,
                                  webBgColor: '#921515',
                                ),
                              },
                              child: Text(
                                'Clear Cart',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightGreen.shade800,
                              ),
                              onPressed: () => Fluttertoast.showToast(
                                msg:
                                    'Oops, please ask Dave for the company credit card!',
                                timeInSecForIosWeb: 3,
                              ),
                              child: Text(
                                'Pay Now',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
            ),
          ],
        ),
      ),
    );
  }
}
