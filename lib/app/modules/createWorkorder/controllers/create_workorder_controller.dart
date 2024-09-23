import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skripsi_dalapa/app/components/loading.dart';
import 'package:skripsi_dalapa/app/data/material.dart';
import 'package:skripsi_dalapa/app/data/workorder.dart';
import 'package:skripsi_dalapa/app/services/authService.dart';

class CreateWorkorderController extends GetxController {
  //TODO: Implement CreateW`orkorderController

  var dataArguments = Get.arguments;

  TextEditingController witelController = TextEditingController();
  TextEditingController stoController = TextEditingController();
  TextEditingController tiketController = TextEditingController();
  TextEditingController headlineController = TextEditingController();
  TextEditingController kordinatController = TextEditingController();

  RxString evidenceBeforePath = "".obs;
  RxString evidenceAfterPath = "".obs;

  var lat;
  var lng;

  List<String> listSTO = [];

  var isQuantityValid = true; // Tambahkan properti ini

  void updateQuantityValidity(bool isValid) {
    isQuantityValid = isValid;
    update();
  }

  final Map<String, List<String>> listWitel = {
    "Witel Balikpapan": [
      "STO Balikpapan Kota",
      "STO Balikpapan Baru",
      "STO Balikpapan Selatan"
    ],
    "Witel Samarinda": [
      "STO Samarinda Utara",
      "STO Samarinda Ilir",
      "STO Samarinda Seberang"
    ],
    "Witel Pontianak": [
      "STO Pontianak Kota",
      "STO Pontianak Barat",
      "STO Pontianak Timur"
    ],
    "Witel Banjarmasin": [
      "STO Banjarmasin Utara",
      "STO Banjarmasin Tengah",
      "STO Banjarmasin Selatan"
    ],
    "Witel Palangkaraya": [
      "STO Palangkaraya Pahandut",
      "STO Palangkaraya Bukit Batu",
      "STO Palangkaraya Sabangau"
    ],
    "Witel Tarakan": [
      "STO Tarakan Tengah",
      "STO Tarakan Barat",
      "STO Tarakan Timur"
    ]
  };

  final TextEditingController quantityController = TextEditingController();
  String? selectedMaterial;

  RxBool isListMaterialExist = false.obs;
  List<dataMaterial> listMaterial = [];

  int? selectedMaterialId;
  String? selectedMaterialName;
  var selectedMaterials = <Map<String, dynamic>>[];

  void updateListSTO(String? witel) {
    if (witel != null && listWitel.containsKey(witel)) {
      listSTO = listWitel[witel]!;
      stoController.text =
          listWitel[witel]![0]; // Reset selected STO when Witel changes
    } else {
      listSTO = [];
    }
    update();
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  void onInit() async {
    super.onInit();
    print("data arguments edit: " + dataArguments.toString());

    witelController.text = "Witel Balikpapan";
    print("witelController.text: ${witelController.text}");
    updateListSTO(witelController.text);

    if (dataArguments != null) {
      showLoading();
      witelController.text = dataArguments.witel;
      updateListSTO(witelController.text);
      stoController.text = dataArguments.sto;
      tiketController.text = dataArguments.nomorTiket;
      headlineController.text = dataArguments.headline;
      kordinatController.text = '${dataArguments.lat}, ${dataArguments.lng}';
      lat = dataArguments.lat;
      lng = dataArguments.lng;
      evidenceAfterPath.value = dataArguments.evidenceBefore;
      evidenceBeforePath.value = dataArguments.evidenceAfter;

      // Jika material sudah ada, update kuantitasnya

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
      onLoadingDismiss();
    }
  }

  void showImagePicker(BuildContext context, String type) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          height: 150,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  getImage(ImageSource.camera, type);
                  Navigator.pop(context);
                },
                child: Text('Ambil Gambar dari Kamera'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  getImage(ImageSource.gallery, type);
                  Navigator.pop(context);
                },
                child: Text('Pilih Gambar dari Galeri'),
              ),
            ],
          ),
        );
      },
    );
  }

  XFile? imageFile;

  Future<void> getImage(ImageSource source, type) async {
    try {
      final ImagePicker picker = ImagePicker();
      XFile? imageFile =
          await picker.pickImage(source: source, imageQuality: 25);

      if (imageFile != null) {
        showLoading();

        var result = await FlutterImageCompress.compressWithFile(
          imageFile.path,
          minHeight: 1024,
          quality: 30,
        );

        if (type == "before") {
          evidenceBeforePath.value = await authService().uploadImage(result);
        } else {
          evidenceAfterPath.value = await authService().uploadImage(result);
        }

        onLoadingDismiss();
      }
    } catch (e) {
      print('Error saat mengambil gambar: $e');
    }
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
