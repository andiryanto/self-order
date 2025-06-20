import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Product {
  final String title;
  final String subtitle;
  final String image;
  final String price;
  final String category;

  Product({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.price,
    required this.category,
  });
}

class MymenuController extends GetxController {
  var username = 'Ryan'.obs;
  var selectedOrderType = 'Takeaway'.obs;
  var searchQuery = ''.obs;
  var selectedCategory = 'Recommended'.obs;

  final scrollController = ScrollController();
  final recommendedKey = GlobalKey();

  final List<Product> allProducts = [
    Product(
      title: 'Americano',
      subtitle: 'Espresso dengan air panas',
      image: 'assets/images/americano.png',
      price: 'Rp 18.000',
      category: 'Coffee',
    ),
    Product(
      title: 'Dolce Latte',
      subtitle: 'Susu manis dan espresso',
      image: 'assets/images/dolce.png',
      price: 'Rp 22.000',
      category: 'Coffee',
    ),
    Product(
      title: 'Caramel Latte',
      subtitle: 'Susu dengan caramel & espresso',
      image: 'assets/images/caramel.png',
      price: 'Rp 24.000',
      category: 'Coffee',
    ),
    Product(
      title: 'Kopi Pandan',
      subtitle: 'Pandan & kopi khas Indonesia',
      image: 'assets/images/pandan.png',
      price: 'Rp 20.000',
      category: 'Coffee',
    ),
    Product(
      title: 'Cotton Latte',
      subtitle: 'Latte dengan sensasi lembut',
      image: 'assets/images/cotton.png',
      price: 'Rp 23.000',
      category: 'Coffee',
    ),
    Product(
      title: 'Red Velvet',
      subtitle: 'Minuman merah lembut',
      image: 'assets/images/redvelvet.png',
      price: 'Rp 25.000',
      category: 'Non Coffee',
    ),
    Product(
      title: 'Matcha',
      subtitle: 'Teh hijau Jepang otentik',
      image: 'assets/images/matcha.png',
      price: 'Rp 25.000',
      category: 'Non Coffee',
    ),
    Product(
      title: 'Cokelat',
      subtitle: 'Cokelat panas klasik',
      image: 'assets/images/cokelat.png',
      price: 'Rp 22.000',
      category: 'Non Coffee',
    ),
    Product(
      title: 'V60',
      subtitle: 'Manual brew dengan V60',
      image: 'assets/images/v60.png',
      price: 'Rp 28.000',
      category: 'Manual Brew',
    ),
    Product(
      title: 'Japanese',
      subtitle: 'Kopi dingin gaya Jepang',
      image: 'assets/images/japanese.png',
      price: 'Rp 30.000',
      category: 'Manual Brew',
    ),
    Product(
      title: 'Tubruk',
      subtitle: 'Kopi khas Indonesia pekat',
      image: 'assets/images/tubruk.png',
      price: 'Rp 18.000',
      category: 'Manual Brew',
    ),
    Product(
      title: 'Vietnam Drip',
      subtitle: 'Kopi manis khas Vietnam',
      image: 'assets/images/vietnam.png',
      price: 'Rp 27.000',
      category: 'Manual Brew',
    ),
  ];

  List<Product> get recommendedProducts => allProducts.take(4).toList();

  List<Product> get filteredProducts {
    final query = searchQuery.value.toLowerCase();
    if (selectedCategory.value == 'Recommended') {
      return recommendedProducts
          .where((p) => p.title.toLowerCase().contains(query))
          .toList();
    } else {
      return allProducts
          .where((p) =>
              p.category == selectedCategory.value &&
              p.title.toLowerCase().contains(query))
          .toList();
    }
  }

  void updateSearch(String value) {
    searchQuery.value = value;
  }

  void updateCategory(String category) {
    selectedCategory.value = category;
  }

  void scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }
}
