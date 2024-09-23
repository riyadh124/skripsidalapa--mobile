import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:skripsi_dalapa/app/env/colors.dart';
import 'package:skripsi_dalapa/app/widgets/text.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  NotificationView({Key? key}) : super(key: key);
  NotificationController notificationController =
      Get.put(NotificationController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(centerTitle: true, elevation: 0, scrolledUnderElevation: 0),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CText(
                "Notifikasi",
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
              SizedBox(
                height: 24,
              ),
              SizedBox(
                height: MediaQuery.sizeOf(context).height - 145,
                child: Obx(() => notificationController
                        .isListNotificationsExist.value
                    ? notificationController.listNotifications.length != 0
                        ? ListView.builder(
                            itemCount:
                                notificationController.listNotifications.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.only(bottom: 8),
                                width: MediaQuery.sizeOf(context).width,
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: Color(0xFFEEEEEE)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        CText(
                                          notificationController.formatDateTime(
                                              notificationController
                                                      .listNotifications[index]
                                                  ["created_at"]),
                                          color: Color(0xFFAAAAAA),
                                          fontSize: 12,
                                        ),
                                        notificationController
                                                        .listNotifications[
                                                    index]["status"] ==
                                                "completed"
                                            ? CircleAvatar(
                                                backgroundColor:
                                                    Color(0xFFACC42A),
                                                maxRadius: 6,
                                              )
                                            : notificationController
                                                            .listNotifications[
                                                        index]["status"] ==
                                                    "waiting"
                                                ? CircleAvatar(
                                                    backgroundColor:
                                                        primaryColor,
                                                    maxRadius: 6,
                                                  )
                                                : CircleAvatar(
                                                    backgroundColor: Colors.red,
                                                    maxRadius: 6,
                                                  )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Row(
                                      children: [
                                        notificationController
                                                        .listNotifications[
                                                    index]["status"] ==
                                                "completed"
                                            ? Icon(
                                                Icons.check_circle_outline,
                                                size: 24,
                                                color: Color(0xFFACC42A),
                                              )
                                            : notificationController
                                                            .listNotifications[
                                                        index]["status"] ==
                                                    "waiting"
                                                ? Icon(Icons.error,
                                                    size: 24,
                                                    color: primaryColor)
                                                : Icon(
                                                    Icons
                                                        .warning_amber_outlined,
                                                    size: 24,
                                                    color: Colors.red),
                                        SizedBox(
                                          width: 4,
                                        ),
                                        SizedBox(
                                          width:
                                              MediaQuery.sizeOf(context).width -
                                                  140,
                                          child: CText(
                                            "${notificationController.listNotifications[index]["isi_notifikasi"]}",
                                            color: Colors.black,
                                            fontSize: 14,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              );
                            },
                          )
                        : Center(
                            child: CText("Tidak ada notifikasi"),
                          )
                    : Center(
                        child: CircularProgressIndicator(),
                      )),
              ),
            ],
          ),
        ));
  }
}
