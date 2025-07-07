import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AboutController>(
      init: AboutController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            title: Obx(() => Text(
                  'Halo, ${controller.username.value}',
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.black),
                onPressed: () => Get.toNamed('/notifics'),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () => Get.toNamed('/account'),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  child: const Icon(Icons.person, color: Colors.black),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section: STORE LOCATION
                const Divider(thickness: 2, color: Colors.black),
                const SizedBox(height: 20),
                const Text('Store Location!',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 28),
                GestureDetector(
                  onTap: () => controller.openMap(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(
                      'assets/images/map.png',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text('Our Crew!',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                const SizedBox(height: 20),
                crewCard('Chaeru Syam', 'Owner', 'male',
                    'https://instagram.com/c.syam1'),
                crewCard('Rofi Akbar', 'Staff', 'male',
                    'https://instagram.com/___.nrrof'),
                crewCard('Adli Khoirullah', 'Staff', 'male',
                    'https://instagram.com/heidli_'),
                crewCard('Rahayu', 'Staff', 'female',
                    'https://instagram.com/rahayunngrm'),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Kartu kru dengan link Instagram
  Widget crewCard(String name, String role, String gender, String instaUrl) {
    final imagePath = gender == 'female'
        ? 'assets/images/woman.jpg'
        : 'assets/images/man.jpg';

    return GestureDetector(
      onTap: () => _openUrl(instaUrl),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Row(
          children: [
            CircleAvatar(backgroundImage: AssetImage(imagePath), radius: 30),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(role),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const FaIcon(FontAwesomeIcons.instagram,
                          color: Colors.pink, size: 16),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          instaUrl.replaceAll('https://instagram.com/', '@'),
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _openUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar('Oops', 'Tidak bisa membuka $url',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
