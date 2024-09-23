import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:skripsi_dalapa/app/modules/login/views/login_view.dart';
import 'package:skripsi_dalapa/app/modules/tab/views/tab_view.dart';

class SplashController extends GetxController {
  //TODO: Implement SplashController
  GetStorage box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    var token = box.read("token");
    Future.delayed(
      const Duration(seconds: 3),
      () async {
        if (token == null) {
          Get.off(() => LoginView());
        } else {
          Get.off(() => TabView());
        }
      },
    );
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
