import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AllPromoController extends GetxController {
  var promoList = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPromos();
  }

  void fetchPromos() async {
    try {
      isLoading.value = true;

      final response = await http.get(
        Uri.parse(
            'http://127.0.0.1:8000/api/promo'), // ganti IP kalau testing di HP
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);
        promoList.value = List<Map<String, dynamic>>.from(data);
      } else {
        Get.snackbar('Gagal', 'Gagal mengambil data promo');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
