import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:skripsi_dalapa/app/components/dialog.dart';
import 'package:skripsi_dalapa/app/env/colors.dart';
import 'package:skripsi_dalapa/app/modules/login/views/login_view.dart';
import 'package:skripsi_dalapa/app/widgets/text.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  ProfileView({Key? key}) : super(key: key);
  ProfileController profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CText(
                "Profile",
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: primaryColor,
                    maxRadius: 32,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 36,
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CText(
                        "${profileController.box.read("userData")["name"]}",
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      CText(
                        "${profileController.box.read("userData")["nik"]}",
                        fontSize: 14,
                        color: Color(0xFF999999),
                      ),
                      CText("${profileController.box.read("userData")["role"]}",
                          fontSize: 14, color: Color(0xFF999999))
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 36,
              ),
              CText(
                "Apps Version: 1.0.0",
                fontSize: 14,
              ),
              SizedBox(
                height: 8,
              ),
              Divider(),
              SizedBox(
                height: 24,
              ),
              GestureDetector(
                onTap: () {
                  confirmMessage(
                    context,
                    "Konfirmasi Logout",
                    "Apakah Anda yakin ingin logout?",
                    () async {
                      profileController.box.remove("token");
                      profileController.box.remove("userData");
                      Get.offAll(() => LoginView());
                    },
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    CText(
                      "Logout",
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Divider(),
              SizedBox(
                height: 16,
              ),
            ],
          ),
        ));
  }
}
