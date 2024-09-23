import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:skripsi_dalapa/app/data/material.dart';
import 'package:skripsi_dalapa/app/env/global_var.dart';
import 'package:skripsi_dalapa/app/modules/history/controllers/history_controller.dart';
import 'package:skripsi_dalapa/app/services/authService.dart';
import 'package:skripsi_dalapa/app/widgets/button.dart';
import 'package:skripsi_dalapa/app/widgets/text.dart';
import '../controllers/create_workorder_controller.dart';

class CreateWorkorderView extends GetView<CreateWorkorderController> {
  CreateWorkorderView({Key? key}) : super(key: key);
  CreateWorkorderController createWorkorderController =
      Get.put(CreateWorkorderController());
  HistoryController historyController = Get.put(HistoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 8, left: 24, right: 24),
              width: MediaQuery.sizeOf(context).width,
              padding: EdgeInsets.all(16),
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
                  CText(
                    "Nomor Tiket",
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  TextField(
                    controller: createWorkorderController.tiketController,
                    decoration: InputDecoration(
                      hintText: 'Masukan Nomor Tiket',
                      contentPadding:
                          EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
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
                  GetBuilder<CreateWorkorderController>(
                    init: CreateWorkorderController(),
                    builder: (context) {
                      return DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          hintText: 'Masukan STO',
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
                        value: createWorkorderController.witelController.text,
                        hint: Text('Pilih Witel'),
                        onChanged: (String? newWitel) {
                          createWorkorderController.witelController.text =
                              newWitel!;
                          createWorkorderController.updateListSTO(newWitel);
                        },
                        items: createWorkorderController.listWitel.keys
                            .map((witel) {
                          return DropdownMenuItem<String>(
                            value: witel,
                            child: Text(witel),
                          );
                        }).toList(),
                        isExpanded: true,
                      );
                    },
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
                  GetBuilder<CreateWorkorderController>(
                    init: CreateWorkorderController(),
                    builder: (context) {
                      return DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          hintText: 'Masukan STO',
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
                        value: createWorkorderController.stoController.text,
                        hint: Text('Pilih STO'),
                        onChanged: (String? newSTO) {
                          createWorkorderController.stoController.text =
                              newSTO!;
                        },
                        items: createWorkorderController.listSTO.map((sto) {
                          return DropdownMenuItem<String>(
                            value: sto,
                            child: Text(sto),
                          );
                        }).toList(),
                        isExpanded: true,
                      );
                    },
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
                  TextField(
                    controller: createWorkorderController.headlineController,
                    decoration: InputDecoration(
                      hintText: 'Masukan Headline',
                      contentPadding:
                          EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
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
                  GetBuilder<CreateWorkorderController>(
                      init: CreateWorkorderController(),
                      builder: (context) {
                        return TextField(
                          readOnly: true,
                          controller:
                              createWorkorderController.kordinatController,
                          onTap: () async {
                            Position position = await createWorkorderController
                                .determinePosition();
                            createWorkorderController.kordinatController.text =
                                '${position.latitude}, ${position.longitude}';
                            createWorkorderController.lat = position.latitude;
                            createWorkorderController.lng = position.longitude;
                            createWorkorderController.update();
                          },
                          decoration: InputDecoration(
                            hintText: 'Masukan Kordinat',
                            suffixIcon: Icon(Icons.location_pin),
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
                        );
                      }),
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
                  TextField(
                    readOnly: true,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return GetBuilder<CreateWorkorderController>(
                            init: CreateWorkorderController(),
                            builder: (_) {
                              return AlertDialog(
                                title: Text("Tambahkan Material"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    FutureBuilder<List<dataMaterial>>(
                                      future: authService().getListMaterial(),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return CircularProgressIndicator();
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              "Error: ${snapshot.error}");
                                        } else if (!snapshot.hasData ||
                                            snapshot.data!.isEmpty) {
                                          return Text("No materials available");
                                        } else {
                                          return DropdownButton<int>(
                                            hint: Text("Pilih Material"),
                                            value: createWorkorderController
                                                .selectedMaterialId,
                                            onChanged: (int? newValue) {
                                              createWorkorderController
                                                      .selectedMaterialId =
                                                  newValue;
                                              createWorkorderController
                                                      .selectedMaterialName =
                                                  snapshot.data!
                                                      .firstWhere((material) =>
                                                          material.id ==
                                                          newValue)
                                                      .name;
                                              createWorkorderController
                                                  .update();
                                            },
                                            items: snapshot.data!
                                                .map<DropdownMenuItem<int>>(
                                                    (dataMaterial material) {
                                              return DropdownMenuItem<int>(
                                                value: material.id,
                                                child: Text(material.name),
                                              );
                                            }).toList(),
                                            isExpanded: true,
                                          );
                                        }
                                      },
                                    ),
                                    TextField(
                                      controller: createWorkorderController
                                          .quantityController,
                                      decoration: InputDecoration(
                                        labelText: "Quantity",
                                        errorText: createWorkorderController
                                                .isQuantityValid
                                            ? null
                                            : 'Quantity must be a positive number',
                                      ),
                                      onChanged: (value) {
                                        final quantity = int.tryParse(value);
                                        if (quantity == null || quantity < 0) {
                                          createWorkorderController
                                              .isQuantityValid = false;
                                        } else {
                                          createWorkorderController
                                              .isQuantityValid = true;
                                        }
                                        createWorkorderController.update();
                                      },
                                      keyboardType: TextInputType.number,
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text("Cancel"),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text("Add"),
                                    onPressed: () {
                                      if (createWorkorderController
                                                  .selectedMaterialId !=
                                              null &&
                                          createWorkorderController
                                              .quantityController
                                              .text
                                              .isNotEmpty) {
                                        bool materialExists =
                                            createWorkorderController
                                                .selectedMaterials
                                                .any((material) =>
                                                    material["id"] ==
                                                    createWorkorderController
                                                        .selectedMaterialId);
                                        if (materialExists) {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Peringatan"),
                                                content: Text(
                                                    "Material sudah ada dalam daftar."),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: Text("OK"),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        } else {
                                          createWorkorderController
                                              .selectedMaterials
                                              .add({
                                            "id": createWorkorderController
                                                .selectedMaterialId,
                                            "material":
                                                createWorkorderController
                                                    .selectedMaterialName,
                                            "quantity": int.parse(
                                                createWorkorderController
                                                    .quantityController.text)
                                          });
                                          createWorkorderController.update();
                                          Navigator.of(context).pop();
                                        }
                                      }
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                    decoration: InputDecoration(
                      suffixIcon: Icon(Icons.add),
                      hintText: 'Tambah Material',
                      contentPadding:
                          EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
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
                  SizedBox(
                    height: 8,
                  ),
                  GetBuilder<CreateWorkorderController>(
                    init: CreateWorkorderController(),
                    builder: (context) {
                      return ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            createWorkorderController.selectedMaterials.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 8),
                            decoration: BoxDecoration(
                              border: Border.all(color: Color(0xFFE9E9E9)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              trailing: IconButton(
                                onPressed: () {
                                  createWorkorderController.selectedMaterials
                                      .removeAt(index);
                                  createWorkorderController.update();
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                              title: Text(createWorkorderController
                                  .selectedMaterials[index]["material"]),
                              subtitle: Text(
                                  "Quantity: ${createWorkorderController.selectedMaterials[index]["quantity"]}"),
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
                    child: GestureDetector(
                      onTap: () => createWorkorderController.showImagePicker(
                          context, "before"),
                      child: Container(
                        height: 200,
                        child: Obx(
                          () => createWorkorderController
                                      .evidenceBeforePath.value ==
                                  ""
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.image_outlined,
                                          color: Color(0xFFAAAAAA),
                                        ),
                                        Icon(
                                          Icons.camera_alt_outlined,
                                          color: Color(0xFFAAAAAA),
                                        )
                                      ],
                                    ),
                                    CText(
                                      "Masukkan foto atau ambil foto",
                                      fontSize: 14,
                                      color: Color(0xFFAAAAAA),
                                    )
                                  ],
                                )
                              : Image.network(
                                  "${createWorkorderController.evidenceBeforePath.value}"),
                        ),
                        width: MediaQuery.sizeOf(context).width - 90,
                      ),
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
                    child: GestureDetector(
                      onTap: () => createWorkorderController.showImagePicker(
                          context, "after"),
                      child: Container(
                        height: 200,
                        child: Obx(
                          () => createWorkorderController
                                      .evidenceAfterPath.value ==
                                  ""
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.image_outlined,
                                          color: Color(0xFFAAAAAA),
                                        ),
                                        Icon(
                                          Icons.camera_alt_outlined,
                                          color: Color(0xFFAAAAAA),
                                        )
                                      ],
                                    ),
                                    CText(
                                      "Masukkan foto atau ambil foto",
                                      fontSize: 14,
                                      color: Color(0xFFAAAAAA),
                                    )
                                  ],
                                )
                              : Image.network(
                                  "${createWorkorderController.evidenceAfterPath.value}"),
                        ),
                        width: MediaQuery.sizeOf(context).width - 90,
                      ),
                    ),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1), // #000000 Opacity 10%
                    offset: Offset(4, 8), // X: 4, Y: 8
                    blurRadius: 24, // Blur: 24
                    spreadRadius: 0, // Spread: 0
                  ),
                ],
                borderRadius: BorderRadius.circular(8),
                color: Color(0xFFFFFFFF),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: PrimaryButton(
                  text: "Simpan",
                  onTap: () async {
                    bool isSend = await authService().submitForm();
                    if (isSend) {
                      await historyController.fetchWorkordersCount();
                      await historyController.fetchWorkorders();
                      Get.back();
                    }
                  }),
            )
          ],
        ),
      ),
    );
  }
}
