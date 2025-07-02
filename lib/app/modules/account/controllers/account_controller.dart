import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AccountController extends GetxController {
  var userName = 'User'.obs;
  var userPhone = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  void fetchUserData() {
    final box = GetStorage();
    userName.value = box.read('username') ?? 'User';
    userPhone.value = box.read('phone') ?? ''; // jika kamu juga simpan nomor HP
  }

  void logout() {
    final box = GetStorage();
    box.erase(); // hapus semua data di local storage (token, username, dll)

    userName.value = '';
    userPhone.value = '';

    Get.offAllNamed(
        '/login'); // atau pakai Routes.LOGIN kalau kamu pakai route constant
  }
}
