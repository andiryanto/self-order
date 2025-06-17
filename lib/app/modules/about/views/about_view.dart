import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controllers/about_controller.dart';

class AboutView extends GetView<AboutController> {
  const AboutView({super.key});

  void _openMap() async {
    const url =
        'https://www.google.com/maps/place/Pranayama+Social+Area/@-6.1737807,106.6372833,17z/data=!3m1!4b1!4m6!3m5!1s0x2e69f95ff0afcf41:0x6b2eb96d978be029!8m2!3d-6.1737807!4d106.6372833!16s%2Fg%2F11t_rm7y2y?entry=ttu';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      Get.snackbar('Error', 'Tidak dapat membuka peta');
    }
  }

  @override
  Widget build(BuildContext context) {
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
                fontSize: 18,
              ),
            )),
        actions: [
          const Icon(Icons.notifications_none, color: Colors.black),
          const SizedBox(width: 10),
          CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: const Icon(Icons.person, color: Colors.black),
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
            Container(height: 8, color: Colors.grey[300]),
            const SizedBox(height: 12),
            const Text('STORE LOCATION',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 28),
            GestureDetector(
              onTap: _openMap,
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
            const Text('OUR CREW',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            crewCard('Chaeru Syam', 'Owner', 'male'),
            crewCard('Rofi Akbar', 'Staff', 'male'),
            crewCard('Adli Khoirullah', 'Staff', 'male'),
            crewCard('Rahayu', 'Staff', 'female'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 4,
        onTap: (index) {
          switch (index) {
            case 0:
              Get.offAllNamed('/home');
              break;
            case 1:
              Get.offAllNamed('/event');
              break;
            case 2:
              Get.offAllNamed('/menu');
              break;
            case 3:
              Get.offAllNamed('/shop');
              break;
            case 4:
              break;
          }
        },
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Event'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: 'Menu'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag), label: 'Shop'),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: 'About'),
        ],
      ),
    );
  }

  Widget crewCard(String name, String role, String gender) {
    String imagePath = gender == 'female'
        ? 'assets/images/woman.png'
        : 'assets/images/man.png';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(imagePath),
            radius: 30,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(role),
                const SizedBox(height: 4),
                const FaIcon(FontAwesomeIcons.instagram, color: Colors.pink),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
