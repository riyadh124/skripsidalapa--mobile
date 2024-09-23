import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController

  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberUser = false;
  RxBool isPassword = true.obs;

  void openWhatsApp(String phoneNumber) async {
    // Format the phone number as needed. Remove non-numeric characters except '+'
    String formattedNumber = phoneNumber.replaceAll(RegExp(r'\D'), '');

    // WhatsApp URL schema
    Uri url = Uri.parse('https://wa.me/$formattedNumber');

    // Check if the URL can be launched
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void onInit() {
    super.onInit();
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
