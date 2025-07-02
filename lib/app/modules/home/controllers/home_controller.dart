import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  var username = 'User'.obs;
  var queueNumber = 0.obs;
  var feedbacks = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
    fetchQueueNumber();
    fetchFeedbacks();
  }

  void fetchUserData() {
    final box = GetStorage();
    username.value = box.read('username') ?? 'User';
  }

  void fetchQueueNumber() {
    queueNumber.value = 50; // Bisa ganti dari API
  }

  void fetchFeedbacks() {
    feedbacks.value = [
      'Good service, kopinya enak!!!. Baristanya ganteng',
      'Tempatnya nyaman bggttt, pokoknya debesttt'
    ];
  }
}
