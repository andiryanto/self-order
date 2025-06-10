import 'package:get/get.dart';

class LoginController extends GetxController {
  var obscurePassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void login() {
    // Aksi login nanti
    print("Login ditekan");
  }

  void goToRegister() {
    // Navigasi ke halaman register
    Get.toNamed('/register');
  }
}
