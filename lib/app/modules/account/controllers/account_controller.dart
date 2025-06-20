import 'package:get/get.dart';

class AccountController extends GetxController {
  var userName = 'Rian'.obs;
  var userPhone = '0882 - 1037 - 6547'.obs;

  void logout() {
    // Di sini bisa tambahkan proses logout beneran, seperti hapus token dll.
    userName.value = '';
    userPhone.value = '';
    Get.offAllNamed('/login'); // atau sesuai route login kamu
  }
}
