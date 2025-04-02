class CartItem {
  final String id;
  final String foodItemId;
  final String name;
  final double price;
  int quantity;
  final String imageUrl;

  CartItem({
    required this.id,
    required this.foodItemId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      id: json['id'] as String,
      foodItemId: json['foodItemId'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'] as int,
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'foodItemId': foodItemId,
      'name': name,
      'price': price,
      'quantity': quantity,
      'imageUrl': imageUrl,
    };
  }

  double get total => price * quantity;
}
