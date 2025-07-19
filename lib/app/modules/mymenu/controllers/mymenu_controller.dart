import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../shop/controllers/shop_controller.dart';
import 'package:get_storage/get_storage.dart';

class MymenuController extends GetxController {
  var username = ''.obs;

  // Order type
  var selectedOrderType = 'Takeaway'.obs;
  final orderTypeOptions = ['Takeaway', 'Dine In'];

  // Menu data
  var isLoading = false.obs;
  var menus = <Map<String, dynamic>>[].obs;

  // Recommended menus
  var recommendedMenus = <Map<String, dynamic>>[].obs;

  // Filter
  var selectedCategory = ''.obs;
  var searchQuery = ''.obs;

  List<Map<String, dynamic>> get filteredMenus {
    final query = searchQuery.value.toLowerCase();
    final category = selectedCategory.value.toLowerCase();

    return menus.where((item) {
      final name = item['name']?.toString().toLowerCase() ?? '';
      final itemCategory = item['category']?.toString().toLowerCase() ?? '';
      return (query.isEmpty || name.contains(query)) &&
          (category.isEmpty || itemCategory == category);
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();
    fetchMenus();
    fetchRecommendedMenus();

    final shopC = Get.find<ShopController>();

    ever(selectedOrderType, (val) {
      shopC.orderType.value = val;
    });
    // ✅ Ambil username dari GetStorage
    final box = GetStorage();
    username.value = box.read('username') ?? '';
  }

  void fetchMenus() async {
    try {
      isLoading(true);
      final response =
          await http.get(Uri.parse('http://127.0.0.1:8000/api/menus'));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        menus.value = List<Map<String, dynamic>>.from(jsonData['data']);
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
      } else {
        Get.snackbar('Gagal', 'Gagal mengambil data rekomendasi');
        recommendedMenus.clear();
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
      recommendedMenus.clear();
    }
  }

  // (opsional, bisa tetap ada)
  void updateOrderType(String value) {
    selectedOrderType.value = value;
    // Tidak perlu lagi set ShopController manual
  }
}
