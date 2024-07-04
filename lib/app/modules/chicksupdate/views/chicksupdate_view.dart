import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:royal_canary_farm_app/app/data/canary_type.dart';
import 'package:royal_canary_farm_app/app/modules/widget/canary_type_dropdown.dart';
import 'package:royal_canary_farm_app/app/modules/widget/date_picker.dart';
import 'package:royal_canary_farm_app/app/modules/widget/gender_radio.dart';
import 'package:royal_canary_farm_app/app/modules/widget/input_widget.dart';

import '../controllers/chicksupdate_controller.dart';

class ChicksupdateView extends GetView<ChicksupdateController> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Anak Burung'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() {
          final photoUrl = controller.bird.photo;
          return SingleChildScrollView(
            child: Form(
              key: controller.formKey,
              child: Column(
                children: [
                  Center(
                    child: GetBuilder<ChicksupdateController>(
                      builder: (controller) {
                        return Stack(
                          children: [
                            CircleAvatar(
                              radius: 80,
                              backgroundImage: NetworkImage(photoUrl!),
                            ),
                            Positioned(
                              bottom: -10,
                              left: 100,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (_) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            ListTile(
                                              leading: const Icon(Icons.camera),
                                              title: const Text('Camera'),
                                              onTap: () {
                                                // Implementasi pengambilan gambar dari kamera
                                                Get.back();
                                              },
                                            ),
                                            ListTile(
                                              leading:
                                                  const Icon(Icons.photo_album),
                                              title: const Text('Gallery'),
                                              onTap: () {
                                                // Implementasi pengambilan gambar dari galeri
                                                Get.back();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  icon: const Icon(
                                    Icons.add_a_photo_rounded,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Masukan Data Anak Burung',
                    style: GoogleFonts.roboto(
                      fontSize: size * 0.040,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputForm(
                    labelParam: 'Nomor Ring',
                    controllerParam: controller.nomorRingController,
                    obsecureParam: false,
                  ),
                  SizedBox(height: 20),
                  CanaryTypeDropdown(
                    items: CanaryType.canaryItems,
                    hint: 'Pilih Jenis Kenari',
                    onChanged: (value) {
                      controller.selectedCanaryType.value = value!;
                    },
                    onSaved: (value) {
                      controller.selectedCanaryType.value = value!;
                    },
                    selectedType: controller.selectedCanaryType.value.isEmpty
                        ? null
                        : controller.selectedCanaryType.value,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  BirthDatePicker(
                    controller: controller.dateController,
                    label: 'Tanggal Lahir',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Silahkan pilih tanggal!';
                      }
                      return null;
                    },
                    onDateSelected: (pickedDate) {
                      controller.setDate(pickedDate);
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Gender Burung',
                        style: GoogleFonts.roboto(fontSize: 16),
                      ),
                      GenderRadioButton(
                        selectedGender: controller.selectedGender,
                      ),
                      SizedBox(height: 20),
                      const SizedBox(height: 15),
                      Center(
                        child: Obx(() {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 50,
                                vertical: 15,
                              ),
                            ),
                            onPressed: controller.isLoading.value
                                ? null
                                : () {
                                    controller.updateChicks();
                                  },
                            child: controller.isLoading.value
                                ? CircularProgressIndicator(color: Colors.white)
                                : Text(
                                    'Update',
                                    style: GoogleFonts.roboto(
                                        fontSize: size * 0.030,
                                        color: Colors.white),
                                  ),
                          );
                        }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
