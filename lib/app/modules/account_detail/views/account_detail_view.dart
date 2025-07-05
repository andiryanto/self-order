// lib/app/modules/account_detail/views/account_detail_view.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/account_detail_controller.dart';

class AccountDetailView extends GetView<AccountDetailController> {
  const AccountDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text('Akun',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Obx(() => SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /* ------- Foto Profil ------- */
                Center(
                  child: GestureDetector(
                    onTap: controller.pickImage,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundImage: controller.imageFile.value != null
                              ? FileImage(controller.imageFile.value!)
                              : controller.user.value.image.isNotEmpty
                                  ? FileImage(File(controller.user.value.image))
                                  : const AssetImage(
                                          'assets/images/default-avatar.png')
                                      as ImageProvider,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.black54,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: const Text('Ubah Foto',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12)),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                _label('Username'),
                TextField(
                  controller: controller.usernameC,
                  cursorColor: Colors.black,
                  decoration: _decoration(),
                ),
                const SizedBox(height: 20),
                _label('Email'),
                TextField(
                  controller: controller.emailC,
                  keyboardType: TextInputType.emailAddress,
                  cursorColor: Colors.black,
                  decoration: _decoration(),
                ),
                const SizedBox(height: 20),
                _label('Jenis Kelamin'),
                DropdownButtonFormField<String>(
                  value: controller.user.value.gender,
                  items: const [
                    DropdownMenuItem(
                        value: 'Laki-laki', child: Text('Laki-laki')),
                    DropdownMenuItem(
                        value: 'Perempuan', child: Text('Perempuan')),
                  ],
                  onChanged: (value) {
                    controller.user.update((val) {
                      if (val != null) val.gender = value ?? '';
                    });
                  },
                  decoration: _decoration(),
                  dropdownColor: Colors.white,
                ),
                const SizedBox(height: 20),
                _label('Nomor Ponsel'),
                TextField(
                  controller: controller.phoneC,
                  keyboardType: TextInputType.phone,
                  cursorColor: Colors.black,
                  decoration: _decoration(),
                ),
                const SizedBox(height: 170),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: controller.deleteAccount,
                        child: const Text('Hapus akun',
                            style: TextStyle(color: Colors.red))),
                    ElevatedButton(
                      onPressed: controller.saveProfile,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                        backgroundColor: Colors.black,
                      ),
                      child: const Text(
                        'Simpan',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                )
              ],
            ),
          )),
    );
  }

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(text,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
      );

  InputDecoration _decoration() => InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.black)),
      );
}
