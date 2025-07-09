import 'package:get/get.dart';

class NotificsController extends GetxController {
  var notifications = <Map<String, dynamic>>[].obs;

  final String dummyApiUrl =
      'https://mocki.io/v1/95e27a9a-4ee5-4da3-9581-e7c52d72c206';
  final GetConnect _connect = GetConnect();

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {
      final response = await _connect.get(dummyApiUrl);

      if (response.statusCode == 200) {
        final data = response.body;
        if (data is List) {
          notifications.value = List<Map<String, dynamic>>.from(data);
        } else {
          Get.snackbar('Error', 'Format data tidak sesuai');
        }
      } else {
        Get.snackbar('Error', 'Gagal mengambil notifikasi');
      }
    } catch (e) {
      Get.snackbar('Error', 'Terjadi kesalahan: $e');
    }
  }

  void clearNotifications() {
    notifications.clear();
  }

  void markAllAsRead() {
    clearNotifications(); // Sementara disamakan
  }
}
