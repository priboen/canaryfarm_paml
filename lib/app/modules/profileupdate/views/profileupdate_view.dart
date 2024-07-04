import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:royal_canary_farm_app/app/modules/widget/input_widget.dart';
import 'package:royal_canary_farm_app/app/modules/widget/maps_screen.dart';

import '../controllers/profileupdate_controller.dart';

class ProfileupdateView extends GetView<ProfileupdateController> {
  const ProfileupdateView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: GoogleFonts.roboto(),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Edit Profile',
                  style: GoogleFonts.poppins(fontSize: size * 0.040),
                ),
                const SizedBox(height: 30),
                GetBuilder<ProfileupdateController>(
                  builder: (controller) {
                    return Stack(
                      children: [
                        CircleAvatar(
                          radius: 64,
                          backgroundImage: controller.selectedImage != null
                              ? FileImage(controller.selectedImage!)
                              : NetworkImage(controller.profile.value.photo)
                                  as ImageProvider,
                        ),
                        Positioned(
                          bottom: -10,
                          left: 80,
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
                                          controller
                                              .pickImage(ImageSource.camera);
                                          Get.back();
                                        },
                                      ),
                                      ListTile(
                                        leading: const Icon(Icons.photo_album),
                                        title: const Text('Gallery'),
                                        onTap: () {
                                          controller
                                              .pickImage(ImageSource.gallery);
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
                      ],
                    );
                  },
                ),
                const SizedBox(height: 15),
                InputForm(
                  labelParam: 'Nama Lengkap',
                  controllerParam: controller.nameController,
                  obsecureParam: false,
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: InputForm(
                        labelParam: 'Alamat',
                        controllerParam: controller.addressController,
                        obsecureParam: false,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                          Get.to(() => MapsScreen(
                                onLocationSelected: (address) {
                                  controller.addressController.text = address;
                                },
                              ));
                        },
                        label: Text(
                          'Maps',
                          style: GoogleFonts.roboto(
                            fontSize: size * 0.030,
                            color: Colors.white,
                          ),
                        ),
                        icon: Icon(
                          Icons.location_pin,
                          color: Colors.white,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                        )),
                  ],
                ),
                const SizedBox(height: 15),
                InputForm(
                  labelParam: 'No. Telepon',
                  controllerParam: controller.phoneController,
                  obsecureParam: false,
                ),
                const SizedBox(height: 15),
                Obx(() {
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
                            controller.updateProfile();
                          },
                    child: controller.isLoading.value
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Update',
                            style: GoogleFonts.poppins(
                                fontSize: size * 0.030, color: Colors.white),
                          ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
