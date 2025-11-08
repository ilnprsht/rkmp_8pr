class Product {
  final int id;
  final String name;
  final String brand;
  final String category;
  final String volume;
  final String expirationDate;
  final double rating;
  final bool isFavorite;
  final String? imageUrl; // новое поле

  const Product({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.volume,
    required this.expirationDate,
    required this.rating,
    required this.isFavorite,
    this.imageUrl, // новое
  });

  Product copyWith({
    int? id,
    String? name,
    String? brand,
    String? category,
    String? volume,
    String? expirationDate,
    double? rating,
    bool? isFavorite,
    String? imageUrl, // новое
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      brand: brand ?? this.brand,
      category: category ?? this.category,
      volume: volume ?? this.volume,
      expirationDate: expirationDate ?? this.expirationDate,
      rating: rating ?? this.rating,
      isFavorite: isFavorite ?? this.isFavorite,
      imageUrl: imageUrl ?? this.imageUrl, // новое
    );
  }
}