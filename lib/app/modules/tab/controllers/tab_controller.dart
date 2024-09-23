import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  //TODO: Implement TabController

  late TabController tabController;
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
