class Product {
  const Product({
    required this.brand,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
  });

  final String brand;
  final String name;
  final String category;
  final double price;
  final int stock;

  String get priceLabel => 'S/ ${price.toStringAsFixed(2)}';
}
