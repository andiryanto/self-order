import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    // SplashController controller = Get.find<SplashController>();
    return GetBuilder<SplashController>(
      init: SplashController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Image.asset(
              'assets/images/pranayama.jpeg',
              width: 150,
              height: 150,
              fit: BoxFit.contain,
            ),
          ),
        );
      },
    );
  }
}
        //     return Scaffold(
        //   appBar: AppBar(
        //     title: const Text('Login'),
        //     centerTitle: true,
        //   ),
        //   body: Padding(
        //     padding: const EdgeInsets.all(20),
        //     child: Column(
        //       children: [
        //         TextField(
        //           controller: controller.emailController,
        //           decoration: const InputDecoration(
        //             labelText: 'Email',
        //           ),
        //         ),
        //         const SizedBox(height: 16),
        //         TextField(
        //           controller: controller.passwordController,
        //           obscureText: true,
        //           decoration: const InputDecoration(
        //             labelText: 'Password',
        //           ),
        //         ),
        //         const SizedBox(height: 30),
        //         ElevatedButton(
        //           onPressed: controller.login,
        //           child: const Text('Login'),
        //         ),
        //       ],
        //     ),
        //   ),
        // );
      