class Menu {
  final int id;
  final String name;
  final String description;
  final String image;
  final double price;
  final bool isRecommended;

  Menu({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.isRecommended,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      price: double.tryParse(json['price'].toString()) ?? 0,
      isRecommended: json['is_recommended'] ?? false,
    );
  }
}
