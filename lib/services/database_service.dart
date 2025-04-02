import '../models/category.dart';
import '../models/food_item.dart';
import '../models/cart_item.dart';

class DatabaseService {
  static final List<Category> _categories = [
    Category(
      id: '1',
      name: 'Pizza',
      imageUrl: 'https://example.com/pizza.jpg',
      description: 'Delicious Italian pizzas',
    ),
    Category(
      id: '2',
      name: 'Burgers',
      imageUrl: 'https://example.com/burger.jpg',
      description: 'Juicy burgers',
    ),
    Category(
      id: '3',
      name: 'Pasta',
      imageUrl: 'https://example.com/pasta.jpg',
      description: 'Authentic Italian pasta',
    ),
    Category(
      id: '4',
      name: 'Desserts',
      imageUrl: 'https://example.com/dessert.jpg',
      description: 'Sweet treats',
    ),
  ];

  static final List<FoodItem> _foodItems = [
    // Pizza items
    FoodItem(
      id: '1',
      name: 'Margherita Pizza',
      description: 'Classic Italian pizza with tomatoes and mozzarella',
      price: 12.99,
      imageUrl: 'https://example.com/margherita.jpg',
      categoryId: '1',
      rating: 4.5,
      preparationTime: 20,
    ),
    FoodItem(
      id: '2',
      name: 'Pepperoni Pizza',
      description: 'Spicy pepperoni with melted cheese',
      price: 14.99,
      imageUrl: 'https://example.com/pepperoni.jpg',
      categoryId: '1',
      rating: 4.7,
      preparationTime: 25,
    ),
    FoodItem(
      id: '3',
      name: 'BBQ Chicken Pizza',
      description: 'Grilled chicken with BBQ sauce and red onions',
      price: 15.99,
      imageUrl: 'https://example.com/bbq-chicken.jpg',
      categoryId: '1',
      rating: 4.6,
      preparationTime: 30,
    ),
    // Burger items
    FoodItem(
      id: '4',
      name: 'Classic Cheeseburger',
      description: 'Classic burger with cheese and fresh vegetables',
      price: 8.99,
      imageUrl: 'https://example.com/cheeseburger.jpg',
      categoryId: '2',
      rating: 4.3,
      preparationTime: 15,
    ),
    FoodItem(
      id: '5',
      name: 'Bacon Burger',
      description: 'Juicy burger with crispy bacon and cheese',
      price: 10.99,
      imageUrl: 'https://example.com/bacon-burger.jpg',
      categoryId: '2',
      rating: 4.4,
      preparationTime: 20,
    ),
    FoodItem(
      id: '6',
      name: 'Mushroom Swiss Burger',
      description: 'Sautéed mushrooms with Swiss cheese',
      price: 11.99,
      imageUrl: 'https://example.com/mushroom-burger.jpg',
      categoryId: '2',
      rating: 4.5,
      preparationTime: 25,
    ),
    FoodItem(
      id: '11',
      name: 'Double Patty Burger',
      description: 'Two juicy patties with special sauce',
      price: 13.99,
      imageUrl: 'https://example.com/double-burger.jpg',
      categoryId: '2',
      rating: 4.6,
      preparationTime: 25,
    ),
    FoodItem(
      id: '12',
      name: 'Spicy Jalapeño Burger',
      description: 'Spicy jalapeños with pepper jack cheese',
      price: 12.99,
      imageUrl: 'https://example.com/jalapeno-burger.jpg',
      categoryId: '2',
      rating: 4.4,
      preparationTime: 20,
    ),
    FoodItem(
      id: '13',
      name: 'BBQ Ranch Burger',
      description: 'BBQ sauce with ranch dressing and onion rings',
      price: 11.99,
      imageUrl: 'https://example.com/bbq-ranch-burger.jpg',
      categoryId: '2',
      rating: 4.5,
      preparationTime: 22,
    ),
    // Pasta items
    FoodItem(
      id: '7',
      name: 'Spaghetti Carbonara',
      description: 'Classic Italian pasta with eggs and pancetta',
      price: 13.99,
      imageUrl: 'https://example.com/carbonara.jpg',
      categoryId: '3',
      rating: 4.6,
      preparationTime: 20,
    ),
    FoodItem(
      id: '8',
      name: 'Fettuccine Alfredo',
      description: 'Creamy pasta with parmesan cheese',
      price: 12.99,
      imageUrl: 'https://example.com/alfredo.jpg',
      categoryId: '3',
      rating: 4.4,
      preparationTime: 18,
    ),
    // Dessert items
    FoodItem(
      id: '9',
      name: 'Chocolate Cake',
      description: 'Rich chocolate cake with ganache',
      price: 6.99,
      imageUrl: 'https://example.com/chocolate-cake.jpg',
      categoryId: '4',
      rating: 4.8,
      preparationTime: 10,
    ),
    FoodItem(
      id: '10',
      name: 'Ice Cream Sundae',
      description: 'Vanilla ice cream with hot fudge and nuts',
      price: 5.99,
      imageUrl: 'https://example.com/sundae.jpg',
      categoryId: '4',
      rating: 4.7,
      preparationTime: 8,
    ),
  ];

  static final List<CartItem> _cartItems = [];

  static Future<void> init() async {
    // No initialization needed for static data
  }

  // Category operations
  static Future<List<Category>> getCategories() async {
    return _categories;
  }

  // Food item operations
  static Future<List<FoodItem>> getFoodItems() async {
    return _foodItems;
  }

  static Future<List<FoodItem>> getFoodItemsByCategory(
      String categoryId) async {
    return _foodItems.where((item) => item.categoryId == categoryId).toList();
  }

  // Cart operations
  static Future<List<CartItem>> getCartItems() async {
    return _cartItems;
  }

  static Future<void> addToCart(CartItem item) async {
    _cartItems.add(item);
  }

  static Future<void> updateCartItemQuantity(String id, int quantity) async {
    final index = _cartItems.indexWhere((item) => item.id == id);
    if (index != -1) {
      final updatedItem = CartItem(
        id: _cartItems[index].id,
        foodItemId: _cartItems[index].foodItemId,
        name: _cartItems[index].name,
        price: _cartItems[index].price,
        quantity: quantity,
        imageUrl: _cartItems[index].imageUrl,
      );
      _cartItems[index] = updatedItem;
    }
  }

  static Future<void> removeFromCart(String id) async {
    _cartItems.removeWhere((item) => item.id == id);
  }

  static Future<void> clearCart() async {
    _cartItems.clear();
  }

  static Future<double> getCartTotal() async {
    double total = 0.0;
    for (var item in _cartItems) {
      total += item.price * item.quantity;
    }
    return total;
  }
}
