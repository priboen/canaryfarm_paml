import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:royal_canary_farm_app/app/data/canary_type.dart';
import 'package:royal_canary_farm_app/app/modules/widget/canary_type_dropdown.dart';
import 'package:royal_canary_farm_app/app/modules/widget/date_picker.dart';
import 'package:royal_canary_farm_app/app/modules/widget/gender_radio.dart';
import 'package:royal_canary_farm_app/app/modules/widget/input_widget.dart';

import '../controllers/chicks_controller.dart';

class ChicksView extends GetView<ChicksController> {
  const ChicksView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Anak Burung'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(
          () {
            if (controller.isLoadingMales.value ||
                controller.isLoadingFemales.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    children: [
                      Center(
                        child: GetBuilder<ChicksController>(
                          builder: (controller) {
                            return Stack(
                              children: [
                                CircleAvatar(
                                  radius: 80,
                                  backgroundImage:
                                      controller.selectedImage != null
                                          ? FileImage(controller.selectedImage!)
                                          : const NetworkImage(
                                              "https://t4.ftcdn.net/jpg/03/49/49/79/360_F_349497933_Ly4im8BDmHLaLzgyKg2f2yZOvJjBtlw5.webp",
                                            ) as ImageProvider,
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
                                                  leading:
                                                      const Icon(Icons.camera),
                                                  title: const Text('Camera'),
                                                  onTap: () {
                                                    controller.pickImage(
                                                      ImageSource.camera,
                                                    );
                                                    Get.back();
                                                  },
                                                ),
                                                ListTile(
                                                  leading: const Icon(
                                                      Icons.photo_album),
                                                  title: const Text('Gallery'),
                                                  onTap: () {
                                                    controller.pickImage(
                                                      ImageSource.gallery,
                                                    );
                                                    Get.back();
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                      icon:
                                          const Icon(Icons.add_a_photo_rounded),
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
                          controller.selectedCanaryType.value =
                              value.toString();
                        },
                        onSaved: (value) {
                          controller.selectedCanaryType.value =
                              value.toString();
                        },
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
                          CanaryTypeDropdown(
                            items: controller.males
                                .map((male) => male.ringNumber!)
                                .toList(),
                            hint: 'Pilih Indukan Jantan',
                            onChanged: (selectedValue) {
                              controller.selectedMale.value = controller.males
                                  .firstWhere((male) =>
                                      male.ringNumber == selectedValue);
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          CanaryTypeDropdown(
                            items: controller.females
                                .map((female) => female.ringNumber!)
                                .toList(),
                            hint: 'Pilih Ibu',
                            onChanged: (selectedValue) {
                              controller.selectedFemale.value =
                                  controller.females.firstWhere((female) =>
                                      female.ringNumber == selectedValue);
                            },
                          ),
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
                                        controller.saveData();
                                      },
                                child: controller.isLoading.value
                                    ? CircularProgressIndicator(
                                        color: Colors.white)
                                    : Text(
                                        'Simpan',
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
            }
          },
        ),
      ),
    );
  }
}
