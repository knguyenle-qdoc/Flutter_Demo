import 'dart:convert';

import 'package:flutter_application_1/features/checkout/models/checkout_item_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final checkoutProvider = NotifierProvider<CheckoutNotifier, List<CheckoutItem>>(
  CheckoutNotifier.new,
);

class CheckoutNotifier extends Notifier<List<CheckoutItem>> {
  static const _storageKey = 'checkout_items';

  @override
  List<CheckoutItem> build() {
    _loadCheckoutItems();
    return [];
  }

  Future<void> _loadCheckoutItems() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);

    if (raw == null) return;

    final decoded = jsonDecode(raw) as List;
    state = decoded
        .map((item) => CheckoutItem.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  Future<void> _saveCheckoutItems() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(state.map((item) => item.toJson()).toList());
    await prefs.setString(_storageKey, encoded);
  }

  Future<void> addItem(CheckoutItem newItem) async {
    final index = state.indexWhere((item) => item.game.id == newItem.game.id);
    if (index >= 0) {
      // If game already exists in cart, update quantity
      final updated = [...state];
      final existing = updated[index];

      updated[index] = CheckoutItem(
        game: existing.game,
        quantity: existing.quantity + newItem.quantity,
      );
      state = updated;
    } else {
      // Add game to cart
      state = [...state, newItem];
    }

    // Save changes to shared preferences storage
    await _saveCheckoutItems();
  }

  // Verify if id is string/int
  Future<void> removeItem(int id) async {
    state = state.where((item) => item.game.id != id).toList();
    await _saveCheckoutItems();
  }

  Future<void> clearCheckoutItems() async {
    state = [];
    await _saveCheckoutItems();
  }
}
