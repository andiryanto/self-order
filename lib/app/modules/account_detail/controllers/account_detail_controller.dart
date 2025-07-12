import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import '../../account/controllers/account_controller.dart';

const String _baseUrl = 'http://127.0.0.1:8000';

class AccountDetailController extends GetxController {
  final box = GetStorage();
  final accountController = Get.find<AccountController>();

  late TextEditingController usernameC;
  late TextEditingController emailC;
  late TextEditingController phoneC;

  final RxString gender = ''.obs;
  final RxString imagePath = ''.obs;

  final _picker = ImagePicker();
  final Rx<File?> imageFile = Rx<File?>(null);
  bool isPicking = false;

  @override
  void onInit() {
    super.onInit();
    usernameC = TextEditingController(text: box.read('username') ?? '');
    emailC = TextEditingController(text: box.read('email') ?? '');
    phoneC = TextEditingController(text: box.read('phone') ?? '');
    gender.value = box.read('gender') ?? 'Male';
    imagePath.value = box.read('image') ?? ''; // ✅ ambil path image
  }

  Future<void> pickImage() async {
    if (isPicking) return;
    isPicking = true;

    try {
      final picked = await _picker.pickImage(source: ImageSource.gallery);
      if (picked != null) {
        imageFile.value = File(picked.path);

        // ✅ Upload foto ke server
        final uploadedUrl = await uploadPhoto(File(picked.path));
        if (uploadedUrl != null) {
          imagePath.value = uploadedUrl;
          box.write('image', uploadedUrl);
        }
      }
    } catch (e) {
      debugPrint('Image picker error: $e');
      Get.snackbar("Error", "Gagal memilih atau mengupload gambar");
    } finally {
      isPicking = false;
    }
  }

  Future<String?> uploadPhoto(File file) async {
    try {
      final url = Uri.parse('$_baseUrl/api/upload-photo');
      final request = http.MultipartRequest('POST', url);
      request.files.add(await http.MultipartFile.fromPath('photo', file.path));

      final res = await request.send();
      final resBody = await res.stream.bytesToString();

      if (res.statusCode == 200) {
        final fileName = resBody.replaceAll('"', '');
        final fullUrl = '$_baseUrl/storage/$fileName';
        return fullUrl;
      } else {
        debugPrint('Upload failed: $resBody');
        return null;
      }
    } catch (e) {
      debugPrint('Upload error: $e');
      return null;
    }
  }

  Future<void> saveProfile() async {
    box.write('username', usernameC.text);
    box.write('email', emailC.text);
    box.write('phone', phoneC.text);
    box.write('gender', gender.value);
    box.write('image', imagePath.value);

    // ✅ Update ke controller utama
    accountController.userName.value = usernameC.text;
    accountController.userPhone.value = phoneC.text;
    accountController.userImage.value = imagePath.value;

    Get.snackbar('Sukses', 'Profil berhasil disimpan');
    await Future.delayed(const Duration(seconds: 2));
    Get.back();
  }

  Future<void> deleteAccount() async {
    Get.defaultDialog(
      title: 'Hapus Akun',
      middleText: 'Yakin mau hapus akun?',
      textConfirm: 'Ya',
      textCancel: 'Tidak',
      confirmTextColor: Colors.white,
      cancelTextColor: Colors.black,
      buttonColor: Colors.black,
      onConfirm: () {
        box.erase();
        Get.back();
        Get.snackbar(
          'Info',
          'Akun dihapus',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        Get.offAllNamed('/login');
      },
    );
  }
}
