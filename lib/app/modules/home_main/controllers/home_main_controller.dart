import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:self_order/app/modules/about/views/about_view.dart';
import 'package:self_order/app/modules/event/views/event_view.dart';
import 'package:self_order/app/modules/home/views/home_view.dart';
import 'package:self_order/app/modules/mymenu/views/mymenu_view.dart';
import 'package:self_order/app/modules/shop/views/shop_view.dart';

class HomeMainController extends GetxController {
  //TODO: Implement HomeMainController
  var username = 'Ryan'.obs;
  RxInt currentIndex = 0.obs;
  final count = 0.obs;
  List<Widget> page = [
    const HomeView(),
    EventView(),
    MyMenuView(),
    ShopView(),
    AboutView(),
  ];

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  void fetchUserData() {
    // Simulasi: ambil dari backend / storage
    username.value = 'Ryan';
  }

  void changeIndex(int index) {
    currentIndex.value = index;
  }
}
