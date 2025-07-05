import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controllers/account_controller.dart';
import '../../help_center/views/help_center_view.dart';
import '../../terms/views/terms_view.dart';
import '../../privacy_policy/views/privacy_policy_view.dart';

class AccountView extends GetView<AccountController> {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Account',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              // Profile Card
              Obx(
                () => Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/RYN.jpg'),
                        radius: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.userName.value,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              controller.userPhone.value,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.toNamed('/account-detail'),
                        child: const Icon(Icons.arrow_forward_ios,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Menu List
              _buildListTile('Help Center',
                  onTap: () => Get.to(() => const HelpCenterView())),
              const Divider(thickness: 2, color: Colors.black),
              _buildListTile('Terms & Conditions',
                  onTap: () => Get.to(() => const TermsView())),
              _buildListTile('Privacy Policy',
                  onTap: () => Get.to(() => const PrivacyPolicyView())),
              _buildListTile(
                'Social Media',
                icon: FontAwesomeIcons.instagram,
                iconColor: Colors.pink, // warna pink untuk Instagram
                onTap: _launchInstagram,
              ),
              const Divider(thickness: 2, color: Colors.black),
              const SizedBox(height: 12),

              // Feedback
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Feedback',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(height: 18),
              TextField(
                cursorColor: Colors.black,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Write here . . .',
                  hintStyle: const TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.black, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'Send',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Version & Logout
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Version 4.4.4'),
                  TextButton(
                    onPressed: controller.logout,
                    child: const Text(
                      'Logout',
                      style: TextStyle(color: Colors.red),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(String title,
      {IconData? icon, Color? iconColor, VoidCallback? onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      trailing: icon != null
          ? Icon(icon, color: iconColor ?? Colors.black)
          : const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  void _launchInstagram() async {
    final url = Uri.parse('https://www.instagram.com/pranayamasocialarea');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar('Gagal', 'Tidak dapat membuka Instagram');
    }
  }
}
