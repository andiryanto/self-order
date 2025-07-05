// lib/app/modules/account_detail/controllers/account_detail_controller.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:self_order/app/data/models/user_model.dart';

class AccountDetailController extends GetxController {
  /* ---------- ambil user global, lalu bungkus .obs ---------- */
  final Rx<UserModel> user = Get.find<UserModel>().obs;

  late TextEditingController usernameC;
  late TextEditingController emailC;
  late TextEditingController phoneC;

  final _picker = ImagePicker();
  final Rx<File?> imageFile = Rx<File?>(null);

  @override
  void onInit() {
    super.onInit();
    usernameC = TextEditingController(text: user.value.name);
    emailC = TextEditingController(text: user.value.email);
    phoneC = TextEditingController(text: user.value.phone);
  }

  /* ----- ganti foto ----- */
  Future<void> pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      imageFile.value = File(picked.path);
      user.update((u) => u?.image = picked.path);
    }
  }

  /* ----- simpan profil ----- */
  Future<void> saveProfile() async {
    user.update((u) {
      if (u != null) {
        u.name = usernameC.text;
        u.email = emailC.text;
        u.phone = phoneC.text;
        // gender di‑update di view via dropdown (lihat view)
        if (imageFile.value != null) {
          u.image = imageFile.value!.path;
        }
      }
    });

    Get.snackbar('Sukses', 'Profil berhasil disimpan',
        backgroundColor: Colors.green, colorText: Colors.white);
  }

  /* ----- hapus akun ----- */
  Future<void> deleteAccount() async {
    Get.defaultDialog(
      title: 'Hapus Akun',
      middleText: 'Yakin mau hapus akun?',
      textConfirm: 'Ya',
      textCancel: 'Tidak',
      confirmTextColor: Colors.white,
      cancelTextColor: Colors.black,
      buttonColor: Colors.black, // <- ini ganti warna tombol "Ya"
      onConfirm: () {
        Get.back();
        Get.snackbar(
          'Info',
          'Akun dihapus',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        // Get.offAllNamed('/login');
      },
    );
  }
}
