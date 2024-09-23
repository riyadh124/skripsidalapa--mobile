import 'package:get/get.dart';
import 'package:skripsi_dalapa/app/data/material.dart';
import 'package:skripsi_dalapa/app/data/workorder.dart';
import 'package:skripsi_dalapa/app/services/authService.dart';

class DetailWorkorderController extends GetxController {
  //TODO: Implement DetailWorkorderController

  DataWorkorder dataArguments = Get.arguments;
  var selectedMaterials = <Map<String, dynamic>>[];

  @override
  void onInit() async {
    super.onInit();
    print("data arguments: " + dataArguments.toString());
    List<dataMaterial> listMaterialWO =
        await authService().getListMaterialWO(dataArguments.id);

    for (var i = 0; i < listMaterialWO.length; i++) {
      selectedMaterials.add({
        "id": listMaterialWO[i].id,
        "material": listMaterialWO[i].name,
        "quantity": listMaterialWO[i].quantity
      });
    }
    update();
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
