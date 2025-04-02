import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../services/database_service.dart';

class CartProvider with ChangeNotifier {
  List<CartItem> _items = [];
  double _total = 0.0;

  List<CartItem> get items => _items;
  double get total => _total;

  Future<void> loadCart() async {
    _items = await DatabaseService.getCartItems();
    _total = await DatabaseService.getCartTotal();
    notifyListeners();
  }

  Future<void> addItem(CartItem item) async {
    final existingIndex =
        _items.indexWhere((i) => i.foodItemId == item.foodItemId);

    if (existingIndex >= 0) {
      final existingItem = _items[existingIndex];
      final updatedItem = CartItem(
        id: existingItem.id,
        foodItemId: existingItem.foodItemId,
        name: existingItem.name,
        price: existingItem.price,
        quantity: existingItem.quantity + 1,
        imageUrl: existingItem.imageUrl,
      );
      _items[existingIndex] = updatedItem;
    } else {
      _items.add(item);
    }

    await _updateTotal();
    notifyListeners();
  }

  Future<void> updateQuantity(String id, int quantity) async {
    if (quantity <= 0) {
      _items.removeWhere((item) => item.id == id);
    } else {
      final index = _items.indexWhere((item) => item.id == id);
      if (index >= 0) {
        final item = _items[index];
        _items[index] = CartItem(
          id: item.id,
          foodItemId: item.foodItemId,
          name: item.name,
          price: item.price,
          quantity: quantity,
          imageUrl: item.imageUrl,
        );
      }
    }

    await _updateTotal();
    notifyListeners();
  }

  Future<void> removeItem(String id) async {
    _items.removeWhere((item) => item.id == id);
    await _updateTotal();
    notifyListeners();
  }

  Future<void> clearCart() async {
    _items.clear();
    _total = 0.0;
    notifyListeners();
  }

  Future<void> _updateTotal() async {
    _total = await DatabaseService.getCartTotal();
  }
}
