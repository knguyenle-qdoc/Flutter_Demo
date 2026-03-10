import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/checkout/views/checkout_screen.dart';
import 'package:flutter_application_1/features/games/views/games_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int selectedIndex = 0;

  static const _destinations = [
    (icon: Icons.gamepad, label: 'Games'),
    (icon: Icons.shopping_cart_rounded, label: 'Cart'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 32),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF020617),
                    Color(0xFF0B1323),
                    Color(0xFF0F172A),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SizedBox(
                width: 250,
                child: Column(
                  children: List.generate(_destinations.length, (index) {
                    final destination = _destinations[index];
                    final isSelected = selectedIndex == index;

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      child: Material(
                        color: isSelected
                            ? Colors.lightGreen.shade500.withValues(alpha: 0.8)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 14,
                            ),
                            child: Row(
                              children: [
                                Icon(destination.icon, color: Colors.white),
                                const SizedBox(width: 12),
                                Text(
                                  destination.label,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Expanded(
              child: IndexedStack(
                index: selectedIndex,
                children: const [GamesScreen(), CheckoutScreen()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
