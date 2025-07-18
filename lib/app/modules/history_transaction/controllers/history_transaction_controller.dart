import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';

class HistoryTransactionController extends GetxController {
  final box = GetStorage();

  var custId = ''.obs;
  var isLoading = false.obs;
  var transactions = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    final storedId = box.read('id');

    if (storedId != null && storedId.toString().isNotEmpty) {
      custId.value = storedId.toString();
      fetchTransactionHistory();
    } else {
      Get.snackbar('Error', 'ID pengguna tidak ditemukan');
    }
  }

  Future<void> fetchTransactionHistory() async {
    isLoading(true);
    try {
      final response = await http.get(
        Uri.parse(
            'http://127.0.0.1:8000/api/transactions/history/${custId.value}'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['status'] == true && data['data'] != null) {
          transactions.value = List<Map<String, dynamic>>.from(data['data']);
        } else {
          transactions.clear();
          Get.snackbar('Info', data['message'] ?? 'Belum ada transaksi');
        }
      } else {
        Get.snackbar(
            'Gagal', 'Gagal memuat transaksi (status ${response.statusCode})');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }
}
