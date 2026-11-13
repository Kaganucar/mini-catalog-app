class Product {
  final int id;
  final String name;
  final String tagline;
  final String description;
  final String price;
  final String imageUrl;
  final Map<String, dynamic> specs;

  Product({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.specs,
  });

  static const _localImages = <int, String>{
    1: 'assets/products/iphone.png',
    7: 'assets/products/macbook_silver.png',
    12: 'assets/products/ipad_air.png',
    17: 'assets/products/airpods.png',
    18: 'assets/products/airpods_max.png',
    19: 'assets/products/homepod.png',
    20: 'assets/products/homepod_mini.png',
  };

  factory Product.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int;
    return Product(
      id: id,
      name: json['name'] as String,
      tagline: json['tagline'] as String,
      description: json['description'] as String,
      price: json['price'] as String,
      imageUrl: _localImages[id] ?? (json['image'] as String),
      specs: json['specs'] as Map<String, dynamic>,
    );
  }
}
