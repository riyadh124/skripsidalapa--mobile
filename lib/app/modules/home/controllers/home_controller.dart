import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:skripsi_dalapa/app/services/authService.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  var box = GetStorage();

  var userData;
  RxBool isUserDataExist = false.obs;

  List listNotifications = [];
  RxBool isListNotificationsExist = false.obs;

  ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    super.onInit();
  }

  getData() async {
    userData = box.read("userData");
    isUserDataExist.value = true;
    isListNotificationsExist.value = false;
    listNotifications = await authService().getNotifications();
    isListNotificationsExist.value = true;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  String formatDateTime(String isoDate) {
    DateTime dateTime = DateTime.parse(isoDate);
    DateTime localDateTime = dateTime.toLocal();
    // Atur format sesuai dengan yang diinginkan
    DateFormat formatter = DateFormat('dd/MM/yyyy, HH.mm');
    return formatter.format(localDateTime);
  }
}
