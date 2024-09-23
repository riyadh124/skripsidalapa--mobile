import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:skripsi_dalapa/app/env/colors.dart';
import 'package:skripsi_dalapa/app/modules/history/views/history_view.dart';
import 'package:skripsi_dalapa/app/modules/home/views/home_view.dart';
import 'package:skripsi_dalapa/app/modules/profile/views/profile_view.dart';
import 'package:skripsi_dalapa/app/widgets/text.dart';

import '../controllers/tab_controller.dart';

class TabView extends GetView<TabScreenController> {
  TabView({Key? key}) : super(key: key);
  TabScreenController tabScreenController = Get.put(TabScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // #000000 Opacity 10%
              offset: Offset(4, 8), // X: 4, Y: 8
              blurRadius: 24, // Blur: 24
              spreadRadius: 0, // Spread: 0
            ),
          ], borderRadius: BorderRadius.circular(12), color: Color(0xFFFFFFFF)),
          child: SalomonBottomBar(
            currentIndex: tabScreenController.currentIndex.value,
            onTap: (i) {
              tabScreenController.currentIndex.value = i;
              tabScreenController.tabController.index = i;
            },
            items: [
              /// Home
              SalomonBottomBarItem(
                icon: Icon(Icons.home),
                title: Text("Beranda"),
                selectedColor: Color(0xFF25476A),
              ),

              /// Likes
              SalomonBottomBarItem(
                icon: Icon(Icons.history),
                title: Text("History"),
                selectedColor: Color(0xFF25476A),
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: tabScreenController.tabController,
        children: [HomeView(), HistoryView()],
      ),
    );
  }
}
