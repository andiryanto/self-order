import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutController extends GetxController {
  var username = 'Ryan'.obs;

  @override
  void onInit() {
    super.onInit();
    // Jika mau ambil dari storage/API:
    // username.value = await getUserFromStorage();
  }

  void openMap() async {
    const url =
        'https://www.google.com/maps/place/Pranayama+Social+Area/@-6.1737807,106.6372833,17z/data=!3m1!4b1!4m6!3m5!1s0x2e69f95ff0afcf41:0x6b2eb96d978be029!8m2!3d-6.1737807!4d106.6372833!16s%2Fg%2F11t_rm7y2y?entry=ttu';

    bool mapPrana = await canLaunchUrl(Uri.parse(url));
    if (mapPrana) {
      await launchUrl(
          Uri.parse(
            url,
          ),
          mode: LaunchMode.externalApplication);
    } else {
      await launchUrl(
          Uri.parse(
            url,
          ),
          mode: LaunchMode.externalApplication);
    }
  }
}
