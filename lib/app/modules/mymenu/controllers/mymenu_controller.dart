import 'package:get/get.dart';

class MymenuController extends GetxController {
  var username = 'Ryan'.obs;
  var selectedOrderType = 'Takeaway'.obs;
  final orderTypeOptions = ['Takeaway', 'Dine In'];

  @override
  void onInit() {
    super.onInit();
    // Contoh jika ingin fetch dari storage:
    // username.value = await getUserFromStorage();
  }
}
