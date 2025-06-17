import 'package:get/get.dart';

class AboutController extends GetxController {
  var username = 'Ryan'.obs;

  @override
  void onInit() {
    super.onInit();
    // Jika mau ambil dari storage/API:
    // username.value = await getUserFromStorage();
  }
}
