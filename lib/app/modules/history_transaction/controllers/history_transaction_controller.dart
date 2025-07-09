import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class HistoryTransactionController extends GetxController {
  var isLoading = false.obs;
  var transactions = <Map<String, dynamic>>[].obs;

  final int customerId = 1; // Ganti sesuai user login

  @override
  void onInit() {
    super.onInit();
    fetchTransactionHistory();
  }

  void fetchTransactionHistory() async {
    try {
      isLoading(true);
      final url = Uri.parse(
          'http://127.0.0.1:8000/api/transactions/history/$customerId');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['status'] == true) {
          transactions.value = List<Map<String, dynamic>>.from(data['data']);
        } else {
          transactions.clear();
          Get.snackbar('Info', 'Belum ada transaksi');
        }
      } else {
        Get.snackbar('Gagal', 'Gagal memuat transaksi');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}
