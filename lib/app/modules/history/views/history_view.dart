import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:skripsi_dalapa/app/data/workorder.dart';
import 'package:skripsi_dalapa/app/env/colors.dart';
import 'package:skripsi_dalapa/app/modules/createWorkorder/views/create_workorder_view.dart';
import 'package:skripsi_dalapa/app/modules/detailWorkorder/views/detail_workorder_view.dart';
import 'package:skripsi_dalapa/app/modules/profile/views/profile_view.dart';
import 'package:skripsi_dalapa/app/services/authService.dart';
import 'package:skripsi_dalapa/app/widgets/text.dart';

import '../controllers/history_controller.dart';

class HistoryView extends GetView<HistoryController> {
  HistoryView({Key? key}) : super(key: key);
  HistoryController historyController = Get.put(HistoryController());
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    historyController.fetchData();
    return Scaffold(
        body: Stack(children: <Widget>[
      // Background with gradient
      SizedBox(
        height: MediaQuery.sizeOf(context).height,
      ),

      Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background-2.png'),
              fit: BoxFit.fill,
            ),
          ),
          height: 192),
      Positioned(
        top: 110,
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: [
                    CText(
                      'Halo, ',
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    Obx(
                      () => CText(
                        historyController.isUserDataExist.value
                            ? "${historyController.box.read("userData")["name"]}!"
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
              ),
              SizedBox(
                height: 24,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      clipBehavior: Clip.hardEdge,
                      width: MediaQuery.of(context).size.width / 2 - 32,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: AssetImage('assets/images/bg-green.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.edit_document,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Report Waiting",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Obx(
                            () => historyController.isWorkordersCountExist.value
                                ? Text(
                                    historyController.reportWaitingCount.value
                                        .toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 32,
                                      color: Colors.white,
                                    ),
                                  )
                                : Center(
                                    child: CircularProgressIndicator(
                                    color: Colors.white,
                                  )),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      clipBehavior: Clip.hardEdge,
                      width: MediaQuery.of(context).size.width / 2 - 32,
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: AssetImage('assets/images/bg-red.png'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.edit_document,
                                color: Colors.white,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Report Rejected",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Obx(
                            () => historyController.isWorkordersCountExist.value
                                ? Text(
                                    historyController.reportPendingCount.value
                                        .toString(),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 32,
                                      color: Colors.white,
                                    ),
                                  )
                                : Center(
                                    child: CircularProgressIndicator(
                                    color: Colors.white,
                                  )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Removed Expanded here
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 2 - 32,
                      child: TextField(
                        controller: historyController.date,
                        readOnly: true,
                        onTap: () async {
                          DateTime? selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  primaryColor: Colors.blue,
                                  buttonTheme: ButtonThemeData(
                                    textTheme: ButtonTextTheme.primary,
                                  ),
                                ),
                                child: child!,
                              );
                            },
                          );

                          if (selectedDate != null) {
                            // Format tanggal sesuai kebutuhan, misalnya 'dd/MM/yyyy'
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(selectedDate);
                            historyController.date.text = formattedDate;
                            historyController.fetchWorkorders();
                            print(formattedDate);
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Tanggal',
                          suffixIcon: Icon(Icons.date_range),
                          contentPadding: EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
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
                    ),
                    // Removed Expanded here
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width / 2 - 28,
                      child: DropdownButtonFormField<String>(
                        value: historyController.status.text.isEmpty
                            ? null
                            : historyController.status.text,
                        items: ['waiting', 'pending'].map((String status) {
                          return DropdownMenuItem<String>(
                            value: status,
                            child: Text(status),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            historyController.status.text = newValue;
                            historyController
                                .fetchWorkorders(); // Memanggil fetchWorkorders untuk memperbarui data berdasarkan status yang dipilih
                          }
                        },
                        decoration: InputDecoration(
                          hintText: 'Status',
                          contentPadding: EdgeInsets.only(
                              left: 14.0, right: 14.0, bottom: 8.0, top: 8.0),
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
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              GetBuilder<HistoryController>(
                  init: HistoryController(),
                  builder: (controller) {
                    List<DataWorkorder> listWorkorders =
                        controller.listWorkorders;

                    return Obx(() => controller.isWorkordersExist.value
                        ? controller.listWorkorders.length != 0
                            ? SizedBox(
                                height: MediaQuery.sizeOf(context).height - 420,
                                child: RefreshIndicator(
                                  onRefresh: () async {
                                    await historyController.fetchWorkorders();
                                    await historyController
                                        .fetchWorkordersCount();
                                  },
                                  child: ListView.builder(
                                    itemCount: listWorkorders.length,
                                    itemBuilder: (context, index) {
                                      final workorder = listWorkorders[index];

                                      return Container(
                                        margin: EdgeInsets.only(
                                            bottom: 8, left: 24, right: 24),
                                        width: MediaQuery.sizeOf(context).width,
                                        padding: EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              offset: Offset(4, 8),
                                              blurRadius: 24,
                                              spreadRadius: 0,
                                            ),
                                          ],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: Color(0xFFFFFFFF),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CText(
                                                  "${workorder.nomorTiket}",
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                                CText(
                                                  workorder.createdAt.split(
                                                      'T')[0], // Tanggal saja
                                                  color: Color(0xFFAAAAAA),
                                                  fontSize: 12,
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 8),
                                            SizedBox(
                                              width: MediaQuery.sizeOf(context)
                                                      .width -
                                                  140,
                                              child: CText(
                                                "${workorder.headline}",
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  left: 8,
                                                  right: 8,
                                                  top: 2,
                                                  bottom: 2),
                                              child: CText(
                                                workorder.status,
                                                color: Colors.white,
                                                fontSize: 14,
                                              ),
                                              decoration: BoxDecoration(
                                                color: workorder.status ==
                                                        "waiting"
                                                    ? Color(0xFF006CB8)
                                                    : Colors.red,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                              ),
                                            ),
                                            workorder.catatan != ""
                                                ? Column(
                                                    children: [
                                                      SizedBox(height: 8),
                                                      SizedBox(
                                                        width:
                                                            MediaQuery.sizeOf(
                                                                        context)
                                                                    .width -
                                                                140,
                                                        child: CText(
                                                          "Catatan : ${workorder.catatan}",
                                                          color: Colors.red,
                                                          fontSize: 14,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                : SizedBox(),
                                            SizedBox(height: 28),
                                            SizedBox(
                                              height: 20,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () => Get.to(
                                                        () =>
                                                            DetailWorkorderView(),
                                                        arguments: workorder),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .remove_red_eye_outlined,
                                                          size: 18,
                                                          color:
                                                              Color(0xFFAAAAAA),
                                                        ),
                                                        SizedBox(width: 8),
                                                        CText(
                                                          "Detail",
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xFFAAAAAA),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  VerticalDivider(),
                                                  GestureDetector(
                                                    onTap: () => Get.to(
                                                        () =>
                                                            CreateWorkorderView(),
                                                        arguments: workorder),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.edit,
                                                          size: 18,
                                                          color:
                                                              Color(0xFF25476A),
                                                        ),
                                                        SizedBox(width: 8),
                                                        CText(
                                                          "Edit",
                                                          fontSize: 14,
                                                          color:
                                                              Color(0xFF25476A),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: MediaQuery.sizeOf(context).height - 420,
                                child: RefreshIndicator(
                                  onRefresh: () async {
                                    historyController.date.clear();
                                    historyController.status.clear();
                                    await historyController.fetchWorkorders();

                                    await historyController
                                        .fetchWorkordersCount();
                                  },
                                  child: ListView(
                                    children: [
                                      Center(
                                        child: CText("Tidak ada workorder"),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                        : CircularProgressIndicator());
                  })
            ],
          ),
        ),
      ),

      //Above card
    ]));
  }
}
