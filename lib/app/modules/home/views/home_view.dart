import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:skripsi_dalapa/app/data/workorder.dart';
import 'package:skripsi_dalapa/app/env/colors.dart';
import 'package:skripsi_dalapa/app/modules/createWorkorder/views/create_workorder_view.dart';
import 'package:skripsi_dalapa/app/modules/detailWorkorder/views/detail_workorder_view.dart';
import 'package:skripsi_dalapa/app/modules/notification/views/notification_view.dart';
import 'package:skripsi_dalapa/app/modules/profile/views/profile_view.dart';
import 'package:skripsi_dalapa/app/services/authService.dart';
import 'package:skripsi_dalapa/app/widgets/text.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    homeController.getData();
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          homeController.isListNotificationsExist.value = false;
          homeController.listNotifications = [];
          homeController.update();
          homeController.listNotifications =
              await authService().getNotifications();
          homeController.isListNotificationsExist.value = true;
          homeController.update();
        },
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              scrolledUnderElevation: 0,
              backgroundColor: Color(0xFF1D3956),
              pinned: true,
              stretch: true,
              // floating: true,
              expandedHeight: 120.0,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                titlePadding: EdgeInsets.all(24),
                expandedTitleScale: 1,
                title: Row(
                  children: [
                    CText(
                      'Halo, ',
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    Obx(
                      () => CText(
                        homeController.isUserDataExist.value
                            ? "${homeController.box.read("userData")["name"]}!"
                            : "Username!",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () => Get.to(() => ProfileView()),
                      child: CircleAvatar(
                        maxRadius: 14,
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: primaryColor,
                          size: 24,
                        ),
                      ),
                    )
                  ],
                ),
                background: Image.asset(
                  'assets/images/background.png',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            //3
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        CText(
                          "Selamat Datang di",
                          color: Color(0xFF222222),
                          fontSize: 14,
                        ),
                        CText(
                          "Dalapa Material Reporting",
                          color: Color(0xFF25476A),
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CText(
                                "Buat Pelaporan Material",
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              GestureDetector(
                                onTap: () =>
                                    Get.to(() => CreateWorkorderView()),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16, vertical: 8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.edit_document),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      CText(
                                        "Material Report",
                                        fontSize: 14,
                                        color: Colors.black,
                                      ),
                                    ],
                                  ),
                                  width: MediaQuery.sizeOf(context).width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              colors: [
                                Color(0xFF1D3956),
                                Color(0xFF5887B9),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Container(
                          padding:
                              EdgeInsets.only(left: 16, top: 16, bottom: 16),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 16.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CText(
                                      "Notifikasi Terbaru",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    GestureDetector(
                                      onTap: () =>
                                          Get.to(() => NotificationView()),
                                      child: CText(
                                        "Lihat semua",
                                        fontSize: 12,
                                        color: Color(0xFF25476A),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              SizedBox(
                                height: 260,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Obx(
                                    () => homeController
                                            .isListNotificationsExist.value
                                        ? homeController
                                                    .listNotifications.length !=
                                                0
                                            ? Scrollbar(
                                                controller: homeController
                                                    .scrollController,
                                                thumbVisibility: true,
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 6.0),
                                                    child: ListView.builder(
                                                      shrinkWrap: false,
                                                      controller: homeController
                                                          .scrollController,
                                                      itemCount: homeController
                                                          .listNotifications
                                                          .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        var workorderJson =
                                                            homeController
                                                                    .listNotifications[
                                                                index]["workorder"];
                                                        var workorder =
                                                            DataWorkorder.fromJson(
                                                                workorderJson);

                                                        return GestureDetector(
                                                          onTap: () => Get.to(
                                                              () =>
                                                                  DetailWorkorderView(),
                                                              arguments:
                                                                  workorder),
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    bottom: 8),
                                                            width: MediaQuery
                                                                    .sizeOf(
                                                                        context)
                                                                .width,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    16),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                                color: Color(
                                                                    0xFFEEEEEE)),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    CText(
                                                                      homeController.formatDateTime(
                                                                          homeController.listNotifications[index]
                                                                              [
                                                                              "created_at"]),
                                                                      color: Color(
                                                                          0xFFAAAAAA),
                                                                      fontSize:
                                                                          12,
                                                                    ),
                                                                    homeController.listNotifications[index]["status"] ==
                                                                            "completed"
                                                                        ? CircleAvatar(
                                                                            backgroundColor:
                                                                                Color(0xFFACC42A),
                                                                            maxRadius:
                                                                                6,
                                                                          )
                                                                        : homeController.listNotifications[index]["status"] ==
                                                                                "waiting"
                                                                            ? CircleAvatar(
                                                                                backgroundColor: primaryColor,
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
                                                                    homeController.listNotifications[index]["status"] ==
                                                                            "completed"
                                                                        ? Icon(
                                                                            Icons.check_circle_outline,
                                                                            size:
                                                                                24,
                                                                            color:
                                                                                Color(0xFFACC42A),
                                                                          )
                                                                        : homeController.listNotifications[index]["status"] ==
                                                                                "waiting"
                                                                            ? Icon(Icons.error,
                                                                                size: 24,
                                                                                color: primaryColor)
                                                                            : Icon(Icons.warning_amber_outlined, size: 24, color: Colors.red),
                                                                    SizedBox(
                                                                      width: 4,
                                                                    ),
                                                                    SizedBox(
                                                                      width: MediaQuery.sizeOf(context)
                                                                              .width -
                                                                          140,
                                                                      child:
                                                                          CText(
                                                                        "${homeController.listNotifications[index]["isi_notifikasi"]}",
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    )
                                                                  ],
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    )),
                                              )
                                            : Center(
                                                child: CText(
                                                    "Tidak ada notifikasi"),
                                              )
                                        : Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          width: MediaQuery.sizeOf(context).width,
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(0.1), // #000000 Opacity 10%
                                  offset: Offset(4, 8), // X: 4, Y: 8
                                  blurRadius: 24, // Blur: 24
                                  spreadRadius: 0, // Spread: 0
                                ),
                              ],
                              borderRadius: BorderRadius.circular(12),
                              color: Color(0xFFFFFFFF)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
