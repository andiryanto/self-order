import 'package:get/get.dart';

class MymenuController extends GetxController {
  var username = 'Rian'.obs;

  @override
  void onInit() {
    super.onInit();
    // Kamu bisa fetch data username dari storage / API kalau mau
    // contoh:
    // username.value = await getUserFromStorage();
  }
}
