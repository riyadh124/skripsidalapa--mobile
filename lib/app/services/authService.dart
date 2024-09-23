import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:skripsi_dalapa/app/components/dialog.dart';
import 'package:skripsi_dalapa/app/components/loading.dart';
import 'package:skripsi_dalapa/app/data/material.dart';
import 'package:skripsi_dalapa/app/data/workorder.dart';
import 'package:skripsi_dalapa/app/env/global_var.dart';
import 'package:skripsi_dalapa/app/modules/createWorkorder/controllers/create_workorder_controller.dart';
import 'package:skripsi_dalapa/app/modules/home/views/home_view.dart';
import 'package:skripsi_dalapa/app/modules/login/views/login_view.dart';
import 'package:skripsi_dalapa/app/modules/tab/views/tab_view.dart';

class authService extends GetConnect {
  Future uploadImage(image) async {
    try {
      final token = await GetStorage().read("token");

      print("image : $image");

      if (token != null) {
        final response = await post(
            '$urlApi/api/upload-image',
            FormData({
              'image': MultipartFile(image, filename: 'image.jpg'),
            }),
            headers: {'Authorization': "Bearer $token"});

        var data = response.body;

        print("upload image : $data");

        if (data["status"]) {
          return data["url"];
        }
      } else {
        errorMessage("Token is null");
        throw Exception("Token is null");
      }
    } catch (e) {
      errorMessage("uploadImage : $e");
    }
  }

  Future<List<dataMaterial>> getListMaterial() async {
    CreateWorkorderController createWorkorderController =
        Get.put(CreateWorkorderController());

    try {
      createWorkorderController.isListMaterialExist.value = true;
      createWorkorderController.listMaterial = [];

      final token = await GetStorage().read("token");

      if (token != null) {
        print("token : $token");

        final response = await get('$urlApi/api/material',
            headers: {'Authorization': "Bearer $token"});

        print("response : $response");

        var data = response.body;

        print("data list material : $data");

        if (data != null && data is List) {
          createWorkorderController.isListMaterialExist.value = true;
          createWorkorderController.listMaterial = List<dataMaterial>.from(
              data.map((item) => dataMaterial.fromJson(item)));
          return createWorkorderController.listMaterial;
        } else {
          errorMessage("Failed to load materials");
          return [];
        }
      } else {
        errorMessage("Token is null");
        throw Exception("Token is null");
      }
    } catch (e) {
      errorMessage("getListMaterial : $e");
      return [];
    }
  }

  Future getListWorkorder(String status, String date) async {
    try {
      final token = await GetStorage().read("token");

      if (token != null) {
        print("token : $token");

        final response = await get(
            '$urlApi/api/workorders?status=$status&date=$date',
            headers: {'Authorization': "Bearer $token"});

        print("response : $response");

        var data = response.body;

        print("data list workorder : $data");

        if (data != null && data['status'] == true) {
          List<DataWorkorder> workorders = List<DataWorkorder>.from(
              data["workorder"].map((item) => DataWorkorder.fromJson(item)));
          return workorders;
        } else {
          errorMessage("Failed to load workorders");
          return false;
        }
      } else {
        errorMessage("Token is null");
        return false;
      }
    } catch (e) {
      GetStorage().remove("token");
      Get.offAll(LoginView());
      errorMessage("getListWorkorder : $e");
      return false;
    }
  }

  Future getListWorkorderCount() async {
    try {
      final token = await GetStorage().read("token");

      if (token != null) {
        print("token : $token");

        final response = await get('$urlApi/api/workorders-count',
            headers: {'Authorization': "Bearer $token"});

        print("response : $response");

        var data = response.body;

        print("data count workorder : $data");

        if (data['status'] == true) {
          var counts = {
            'waiting': data['waiting_workorders'],
            'pending': data['pending_workorders']
          };
          return counts;
        } else {
          errorMessage("Failed to load workorders");
          return false;
        }
      } else {
        errorMessage("Token is null");
        return false;
      }
    } catch (e) {
      GetStorage().remove("token");
      Get.offAll(LoginView());
      errorMessage("getListWorkorder : $e");
      return false;
    }
  }

  Future<List<dataMaterial>> getListMaterialWO(id) async {
    try {
      final token = await GetStorage().read("token");
      print("id : ${id}");
      if (token != null) {
        print("token : $token");

        final response = await get('$urlApi/api/workorders/$id/materials',
            headers: {'Authorization': "Bearer $token"});

        print("response : $response");

        var data = response.body;

        print("data list material wo : ${data}");

        if (data != null) {
          List<dataMaterial> listMaterial = List<dataMaterial>.from(
              data["workorder"].map((item) => dataMaterial.fromJson(item)));
          print("ListMaterial : $listMaterial");
          return listMaterial;
        } else {
          errorMessage("Failed to load materials");
          return [];
        }
      } else {
        errorMessage("Token is null");
        throw Exception("Token is null");
      }
    } catch (e) {
      errorMessage("getListMaterial : $e");
      return [];
    }
  }

  void login(context, id, pass) async {
    print("username: " + id);
    print("password: " + pass);

    if (id != '' && pass != '') {
      showLoading();

      try {
        final response = await post('$urlApi/api/auth/login', {
          'nik': id,
          'password': pass,
        });

        var data = response.body;
        print("response $data");

        if (data['message'] == 'User Logged In Successfully') {
          GetStorage().write("token", data["token"]);
          GetStorage().write("userData", data["data"]);
          onLoadingDismiss();
          Get.offAll(() => TabView());
          successMessage(context, data['message']);
        } else {
          onLoadingDismiss();
          errorMessage(data['message']);
        }
      } catch (e) {
        onLoadingDismiss();
        errorMessage(e);
      }
    } else {
      errorMessage("Lengkapi ID dan Password terlebih dahulu.");
    }
  }

  Future<bool> submitForm() async {
    CreateWorkorderController createWorkorderController =
        Get.put(CreateWorkorderController());

    final userData = await GetStorage().read("userData");

    final formData = {
      "user_id": userData["id"],
      "nomor_tiket": createWorkorderController.tiketController.text,
      "witel": createWorkorderController.witelController.text,
      "sto": createWorkorderController.stoController.text,
      "headline": createWorkorderController.headlineController.text,
      "lat": createWorkorderController.lat,
      "lng": createWorkorderController.lng,
      "list_material": createWorkorderController.selectedMaterials,
      "evidence_before": createWorkorderController.evidenceBeforePath.value,
      "evidence_after": createWorkorderController.evidenceAfterPath.value,
      "status": "waiting"
    };

    print("formdata: $formData");

    final token = await GetStorage().read("token");

    try {
      final response = await post('$urlApi/api/workorder', formData,
          headers: {'Authorization': "Bearer $token"});

      var data = response.body;
      print("response $data");

      if (data['message'] == "Workorder created successfully" ||
          data['message'] == "Workorder updated successfully") {
        // successMessage(Get.context, data['message']);
        Get.back();
        Future.delayed(Duration(seconds: 1), () {
          successMessage(Get.context, data['message']);
        });

        // homeController.getDataForms("");
        return true;
      } else {
        // onLoadingDismiss();
        if (data['message'] == "Validation failed") {
          errorMessage(data['errors']);
        } else {
          errorMessage(data['message']);
        }
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to submit form: $e');
      return false;
    }
  }

  Future<List> getNotifications() async {
    final token = await GetStorage().read("token");
    try {
      final response = await get('$urlApi/api/notifications',
          headers: {'Authorization': "Bearer $token"});
      var data = response.body;
      print("response $data");

      if (data['status']) {
        // successMessage(Get.context, data['message']);
        return data['data'];
      } else {
        // onLoadingDismiss();
        errorMessage("Terjadi Kesalahan");
        return [];
      }
    } catch (e) {
      onLoadingDismiss();
      errorMessage(e);
      return [];
    }
  }
}
