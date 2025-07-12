// lib/app/modules/event/controllers/event_controller.dart
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class EventController extends GetxController {
  var username = ''.obs;
  var selectedCategory = ''.obs;
  var searchQuery = ''.obs;

  var events = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  List<Map<String, dynamic>> get filteredEvents {
    final q = searchQuery.value.toLowerCase();
    final cat = selectedCategory.value;

    return events.where((e) {
      final matchCat = cat.isEmpty || e['category'] == cat;
      final matchQ = q.isEmpty || (e['name']?.toLowerCase() ?? '').contains(q);
      return matchCat && matchQ;
    }).toList();
  }

  @override
  void onInit() {
    super.onInit();

    // ✅ Ambil username dari GetStorage
    final box = GetStorage();
    username.value = box.read('username') ?? '';

    // ✅ Ambil data event dari API
    fetchEvents();
  }

  void fetchEvents() async {
    try {
      isLoading.value = true;

      final url = Uri.parse('http://127.0.0.1:8000/api/events');
      final res = await http.get(url);

      if (res.statusCode == 200) {
        final jsonData = json.decode(res.body);
        events.value = List<Map<String, dynamic>>.from(jsonData['data'] ?? []);
        print('Events loaded: ${events.length}');
      } else {
        Get.snackbar('Gagal', 'Gagal mengambil data event (${res.statusCode})');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
