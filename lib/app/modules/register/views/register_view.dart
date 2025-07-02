import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/register_controller.dart';
import 'package:self_order/app/routes/app_pages.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.offAllNamed(Routes.LOGIN);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          "Daftar",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildTextField("Nama*", controller.nameController,
                hintText: "Nama lengkap anda"),
            _buildTextField("Email*", controller.emailController,
                hintText: "Alamat email anda"),
            _buildPhoneField(),
            _buildPasswordField(),
            const SizedBox(height: 16),
            _buildTermsCheckbox(),
            const SizedBox(height: 24),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  // Text Field Umum
  Widget _buildTextField(String label, TextEditingController controllerField,
      {String? hintText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextField(
          controller: controllerField,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
            ),
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // Nomor Ponsel
  Widget _buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Nomor Ponsel*",
            style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        TextField(
          controller: controller.phoneController,
          keyboardType: TextInputType.phone,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            prefixIcon: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Text("+62 "),
            ),
            prefixIconConstraints:
                const BoxConstraints(minWidth: 0, minHeight: 0),
            hintText: 'Nomor ponsel anda',
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
            ),
            border: const OutlineInputBorder(),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // Password Field
  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Sandi*", style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Obx(() => TextField(
              controller: controller.passwordController,
              obscureText: controller.obscurePass.value,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                hintText: 'Buat Sandi',
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                ),
                border: const OutlineInputBorder(),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                suffixIcon: IconButton(
                  icon: Icon(controller.obscurePass.value
                      ? Icons.visibility_off
                      : Icons.visibility),
                  onPressed: controller.toggleObscure,
                ),
              ),
            )),
        const SizedBox(height: 8),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "✔ Min. 8 Karakter",
            style: TextStyle(fontSize: 12),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  // Checkbox Persetujuan
  Widget _buildTermsCheckbox() {
    return Obx(() => Row(
          children: [
            Checkbox(
              value: controller.agreeTerms.value,
              onChanged: (_) => controller.toggleAgree(),
              activeColor: Colors.black,
              checkColor: Colors.white,
            ),
            Expanded(
              child: RichText(
                text: const TextSpan(
                  text: "Saya menyetujui ",
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: "Pernyataan Privasi",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text: " dan ",
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: "Syarat & Ketentuan ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                    TextSpan(
                      text: "Pranayama Social Area",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  // Tombol Submit
  Widget _buildSubmitButton() {
    return Obx(() => SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            onPressed:
                controller.isLoading.value ? null : () => controller.register(),
            child: controller.isLoading.value
                ? const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  )
                : const Text("Lanjutkan"),
          ),
        ));
  }
}
