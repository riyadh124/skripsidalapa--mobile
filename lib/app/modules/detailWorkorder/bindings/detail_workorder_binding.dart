import 'package:get/get.dart';

import '../controllers/detail_workorder_controller.dart';

class DetailWorkorderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailWorkorderController>(
      () => DetailWorkorderController(),
    );
  }
}
