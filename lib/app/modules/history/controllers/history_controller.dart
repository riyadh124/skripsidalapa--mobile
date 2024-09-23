import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:skripsi_dalapa/app/data/workorder.dart';
import 'package:skripsi_dalapa/app/services/authService.dart';

class HistoryController extends GetxController {
  //TODO: Implement HistoryController

  var box = GetStorage();

  var userData;
  RxBool isUserDataExist = false.obs;

  TextEditingController status = TextEditingController();
  TextEditingController date = TextEditingController();

  RxBool isWorkordersExist = false.obs;
  List<DataWorkorder> listWorkorders = [];

  RxBool isWorkordersCountExist = false.obs;
  RxInt reportWaitingCount = 0.obs;
  RxInt reportPendingCount = 0.obs;

  Future<void> fetchWorkorders() async {
    isWorkordersExist.value = false;
    listWorkorders = [];
    final response =
        await authService().getListWorkorder(status.text, date.text);
    if (response != false) {
      listWorkorders = response;
      update();
    }
    isWorkordersExist.value = true;
  }

  Future<void> fetchWorkordersCount() async {
    isWorkordersCountExist.value = false;
    final response = await authService().getListWorkorderCount();
    if (response != false) {
      reportPendingCount.value = response['pending'];
      reportWaitingCount.value = response['waiting'];
      update();
    }
    isWorkordersCountExist.value = true;
  }

  @override
  void onInit() async {
    super.onInit();
  }

  fetchData() async {
    userData = box.read("userData");
    isUserDataExist.value = true;
    await fetchWorkordersCount();
    await fetchWorkorders();
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
