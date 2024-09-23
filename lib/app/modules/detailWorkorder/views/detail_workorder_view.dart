import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:skripsi_dalapa/app/widgets/text.dart';

import '../controllers/detail_workorder_controller.dart';

class DetailWorkorderView extends GetView<DetailWorkorderController> {
  DetailWorkorderView({Key? key}) : super(key: key);
  DetailWorkorderController detailWorkorderController =
      Get.put(DetailWorkorderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFAFAFA),
      appBar: AppBar(
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 24, right: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CText(
              "Material Report",
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            SizedBox(
              height: 8,
            ),
            CText(
              "Form Material Report digunakan untuk melaporkan Material yang digunakan.",
              fontSize: 14,
            ),
            SizedBox(
              height: 32,
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height - 200,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        bottom: 8,
                      ),
                      width: MediaQuery.sizeOf(context).width,
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CText(
                            "Nomor Tiket",
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          CText(
                            "${detailWorkorderController.dataArguments.nomorTiket}",
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          CText(
                            "Witel",
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          CText(
                            "${detailWorkorderController.dataArguments.witel}",
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          CText(
                            "STO",
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          CText(
                            "${detailWorkorderController.dataArguments.sto}",
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          CText(
                            "Headline",
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          CText(
                            "${detailWorkorderController.dataArguments.headline}",
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          CText(
                            "Kordinat",
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          CText(
                            "${detailWorkorderController.dataArguments.lat}, ${detailWorkorderController.dataArguments.lng}",
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          CText(
                            "Material",
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          GetBuilder<DetailWorkorderController>(
                            init: DetailWorkorderController(),
                            builder: (controller) {
                              return ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.selectedMaterials.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.only(bottom: 8),
                                    decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Color(0xFFE9E9E9)),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: ListTile(
                                      title: Text(
                                          controller.selectedMaterials[index]
                                              ["material"]),
                                      subtitle: Text(
                                          "Quantity: ${controller.selectedMaterials[index]["quantity"]}"),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          CText(
                            "Dokumentasi Sebelum Pengerjaan",
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          DottedBorder(
                            dashPattern: [8, 4],
                            radius: Radius.circular(5),
                            color: Color(0xFFAAAAAA),
                            borderType: BorderType.RRect,
                            strokeWidth: 2,
                            child: Container(
                              height: 200,
                              child: Image.network(
                                  "${detailWorkorderController.dataArguments.evidenceBefore}"),
                              width: MediaQuery.sizeOf(context).width - 90,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          CText(
                            "Dokumentasi Sesudah Pengerjaan",
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          DottedBorder(
                            dashPattern: [8, 4],
                            radius: Radius.circular(5),
                            color: Color(0xFFAAAAAA),
                            borderType: BorderType.RRect,
                            strokeWidth: 2,
                            child: Container(
                              height: 200,
                              child: Image.network(
                                  "${detailWorkorderController.dataArguments.evidenceAfter}"),
                              width: MediaQuery.sizeOf(context).width - 90,
                            ),
                          ),
                        ],
                      ),
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
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xFFFFFFFF),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
