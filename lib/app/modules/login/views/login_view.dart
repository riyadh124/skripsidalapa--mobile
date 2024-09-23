import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:skripsi_dalapa/app/env/colors.dart';
import 'package:skripsi_dalapa/app/modules/tab/views/tab_view.dart';
import 'package:skripsi_dalapa/app/services/authService.dart';
import 'package:skripsi_dalapa/app/widgets/button.dart';
import 'package:skripsi_dalapa/app/widgets/text.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);
  LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 24.0),
        child: ListView(
          shrinkWrap: true,
          children: [
            CText(
              "Sign In",
              color: primaryColor,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 8,
            ),
            CText(
              "Selamat Datang di Aplikasi Dalapa Material Reporting. Sign In terlebih dahulu agar bisa masuk ke aplikasi.",
              fontSize: 14,
            ),
            SizedBox(
              height: 48,
            ),
            CText(
              "ID",
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 8,
            ),
            TextField(
              controller: loginController.idController,
              decoration: InputDecoration(
                hintText: 'ID',
                prefixIcon: Icon(Icons.person),
                contentPadding:
                    EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFFE9E9E9)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Color(0xFFE9E9E9)),
                ),
              ),
            ),
            SizedBox(
              height: 24,
            ),
            CText(
              "Password",
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 8,
            ),
            Obx(
              () => TextField(
                controller: loginController.passwordController,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    onPressed: () => loginController.isPassword.value =
                        !loginController.isPassword.value,
                    icon: loginController.isPassword.value
                        ? const Icon(Icons.remove_red_eye)
                        : const Icon(Icons.visibility_off),
                  ),
                  hintText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  contentPadding:
                      EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFFE9E9E9)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Color(0xFFE9E9E9)),
                  ),
                ),
                obscureText: loginController.isPassword.value,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              children: [
                CText(
                  "Lupa password?",
                ),
                GestureDetector(
                  onTap: () => loginController.openWhatsApp('08115991111'),
                  child: CText(
                    " Hubungi Admin",
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48,
            ),
            PrimaryButton(
              text: "Sign In",
              onTap: () {
                authService().login(context, loginController.idController.text,
                    loginController.passwordController.text);
              },
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CText(
                  "Belum punya akun?",
                ),
                GestureDetector(
                  onTap: () => loginController.openWhatsApp('08115991111'),
                  child: CText(
                    " Hubungi Admin",
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
