import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:get_storage/get_storage.dart';

class AboutController extends GetxController {
  var username = ''.obs;
  var crewList = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    final box = GetStorage();
    username.value = box.read('username') ?? '';
    fetchCrew();
  }

  void openMap() async {
    const url =
        'https://www.google.com/maps/place/Pranayama+Social+Area/@-6.1737807,106.6372833,17z/data=!3m1!4b1!4m6!3m5!1s0x2e69f95ff0afcf41:0x6b2eb96d978be029!8m2!3d-6.1737807!4d106.6372833!16s%2Fg%2F11t_rm7y2y?entry=ttu';

    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar('Error', 'Tidak bisa membuka peta');
    }
  }

  Future<void> fetchCrew() async {
    isLoading.value = true;
    try {
      final response = await http.get(
        Uri.parse('http://127.0.0.1:8000/api/abouts'),
        headers: {'Accept': 'application/json'},
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        crewList.value = List<Map<String, dynamic>>.from(data['data']);
      } else {
        Get.snackbar('Error', 'Gagal mengambil data crew');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
