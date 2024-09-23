import 'package:get/get.dart';

import '../controllers/create_workorder_controller.dart';

class CreateWorkorderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CreateWorkorderController>(
      () => CreateWorkorderController(),
    );
  }
}
