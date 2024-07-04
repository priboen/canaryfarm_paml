import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_canary_farm_app/app/data/canary_type.dart';
import 'package:royal_canary_farm_app/app/modules/widget/canary_type_dropdown.dart';
import 'package:royal_canary_farm_app/app/modules/widget/date_picker.dart';
import 'package:royal_canary_farm_app/app/modules/widget/gender_radio.dart';
import 'package:royal_canary_farm_app/app/modules/widget/input_widget.dart';

import '../controllers/canaryupdate_controller.dart';

class CanaryupdateView extends GetView<CanaryupdateController> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar:
          AppBar(title: Text('Update Burung ${controller.bird.ringNumber}')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          final photoUrl = controller.bird.photo;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Stack(
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
                                        leading: const Icon(Icons.photo_album),
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputForm(
                    labelParam: 'Nomor Ring',
                    controllerParam: controller.ringNumberController,
                    obsecureParam: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                    height: 20,
                  ),
                  InputForm(
                    labelParam: 'Harga',
                    controllerParam: controller.priceController,
                    obsecureParam: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BirthDatePicker(
                    controller: controller.dateOfBirthController,
                    label: 'Date of Birth',
                  ),
                  const SizedBox(
                    height: 20,
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
                      TextFormField(
                        controller: controller.typeDescriptionController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          labelText: 'Deskripsi',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      elevation: 0,
                    ),
                    onPressed: () {
                      controller.updateBird();
                    },
                    child: Obx(() {
                      return controller.isLoading.value
                          ? CircularProgressIndicator()
                          : Text(
                              'Simpan Data',
                              style: GoogleFonts.roboto(
                                fontSize: size * 0.040,
                                color: Colors.white,
                              ),
                            );
                    }),
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
