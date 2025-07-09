import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../shop/controllers/shop_controller.dart';

class MymenuController extends GetxController {
  var username = 'Ryan'.obs;

  // Order type
  var selectedOrderType = 'Takeaway'.obs;
  final orderTypeOptions = ['Takeaway', 'Dine In'];

  // Menu data
  var isLoading = false.obs;
  var menus = <Map<String, dynamic>>[].obs;

  // Recommended menus
  var recommendedMenus = <Map<String, dynamic>>[].obs;

  // Filter
  var selectedCategory = ''.obs; // '' artinya semua
  var searchQuery = ''.obs;

  // Filtered output
  List<Map<String, dynamic>> get filteredMenus {
    final query = searchQuery.value.toLowerCase();
    final category = selectedCategory.value.toLowerCase();

    return menus.where((item) {
      final name = item['name']?.toString().toLowerCase() ?? '';
      final itemCategory = item['category']?.toString().toLowerCase() ?? '';

      final matchQuery = query.isEmpty || name.contains(query);
      final matchCategory = category.isEmpty || itemCategory == category;

      return matchQuery && matchCategory;
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();
    fetchMenus();
    fetchRecommendedMenus();

    // Set default orderType ke ShopController saat awal
    final shopC = Get.find<ShopController>();
    shopC.orderType.value = selectedOrderType.value;
  }

  void fetchMenus() async {
    try {
      isLoading(true);
      final response =
          await http.get(Uri.parse('http://127.0.0.1:8000/api/menus'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        menus.value = List<Map<String, dynamic>>.from(jsonData['data']);
        print('Menu loaded: ${menus.length}');
      } else {
        Get.snackbar('Gagal', 'Gagal mengambil data menu');
        menus.clear();
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      menus.clear();
    } finally {
      isLoading(false);
    }
  }

  void fetchRecommendedMenus() async {
    try {
      final response = await http
          .get(Uri.parse('http://127.0.0.1:8000/api/menus/recommended'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        recommendedMenus.value =
            List<Map<String, dynamic>>.from(jsonData['data']);
        print('Recommended menus loaded: ${recommendedMenus.length}');
      } else {
        Get.snackbar('Gagal', 'Gagal mengambil data rekomendasi menu');
        recommendedMenus.clear();
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      recommendedMenus.clear();
    }
  }

  void updateOrderType(String value) {
    selectedOrderType.value = value;

    // Sinkronkan ke ShopController juga
    final shopC = Get.find<ShopController>();
    shopC.orderType.value = value;
  }
}
