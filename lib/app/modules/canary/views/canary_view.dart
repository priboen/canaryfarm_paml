import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:royal_canary_farm_app/app/data/canary_type.dart';
import 'package:royal_canary_farm_app/app/modules/canary/controllers/canary_controller.dart';
import 'package:royal_canary_farm_app/app/modules/widget/canary_type_dropdown.dart';

import 'package:royal_canary_farm_app/app/modules/widget/date_picker.dart';
import 'package:royal_canary_farm_app/app/modules/widget/gender_radio.dart';
import 'package:royal_canary_farm_app/app/modules/widget/input_widget.dart';

class CanaryView extends GetView<CanaryController> {
  CanaryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: GetBuilder<CanaryController>(
                  builder: (controller) {
                    return Stack(
                      children: [
                        CircleAvatar(
                          radius: 80,
                          backgroundImage: controller.selectedImage != null
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
                                          leading: const Icon(Icons.camera),
                                          title: const Text('Camera'),
                                          onTap: () {
                                            controller.pickImage(
                                              ImageSource.camera,
                                            );
                                            Get.back();
                                          },
                                        ),
                                        ListTile(
                                          leading:
                                              const Icon(Icons.photo_album),
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
                              icon: const Icon(Icons.add_a_photo_rounded),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
              SizedBox(height: 20),
              InputForm(
                labelParam: 'Nomor Ring',
                controllerParam: controller.nomorRingController,
                obsecureParam: false,
              ),
              SizedBox(height: 20),
              CanaryTypeDropdown(
                items: CanaryType.canaryItems,
                hint: 'Pilih Jenis Kenari',
                validator: (value) {
                  if (value == null) {
                    return 'Please select a canary type.';
                  }
                  return null;
                },
                onChanged: (value) {
                  controller.selectedCanaryType.value = value.toString();
                },
                onSaved: (value) {
                  controller.selectedCanaryType.value = value.toString();
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
                  InputForm(
                    labelParam: 'Harga',
                    controllerParam: controller.hargaController,
                    obsecureParam: false,
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: controller.deskripsiController,
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
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 50,
                      vertical: 15,
                    ),
                  ),
                  onPressed: () {
                    controller.saveBird();
                    print(context);
                  },
                  child: Text(
                    'Simpan',
                    style: GoogleFonts.roboto(
                      fontSize: size * 0.040,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
