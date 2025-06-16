import 'package:get/get.dart';

class HomeController extends GetxController {
  var username = 'Ryan'.obs;
  var queueNumber = 50.obs;

  var feedbacks = <String>[
    'Good service, kopinya enak!!!. Baristanya ganteng',
    'Tempatnya nyaman bggttt, pokoknya debesttt'
  ].obs;

  // Simulasi ambil data dari backend (bisa kamu ubah ke API call)
  @override
  void onInit() {
    super.onInit();
    fetchUserData();
    fetchQueueNumber();
    fetchFeedbacks();
  }

  void fetchUserData() {
    // Simulasi: ambil dari backend / storage
    username.value = 'Ryan';
  }

  void fetchQueueNumber() {
    // Simulasi ambil dari server
    queueNumber.value = 50;
  }

  void fetchFeedbacks() {
    // Simulasi ambil dari server
    feedbacks.value = [
      'Good service, kopinya enak!!!. Baristanya ganteng',
      'Tempatnya nyaman bggttt, pokoknya debesttt'
    ];
  }
}
