import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:royal_canary_farm_app/app/modules/widget/input_widget.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Register Page',
                    style: GoogleFonts.poppins(fontSize: size * 0.040)),
                const SizedBox(height: 30),
                GetBuilder<RegisterController>(
                  builder: (controller) {
                    return Stack(
                      children: [
                        CircleAvatar(
                          radius: 64,
                          backgroundImage: controller.selectedImage != null
                              ? FileImage(controller.selectedImage!)
                              : const NetworkImage(
                                  "https://t4.ftcdn.net/jpg/03/49/49/79/360_F_349497933_Ly4im8BDmHLaLzgyKg2f2yZOvJjBtlw5.webp",
                                ) as ImageProvider,
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
                    obsecureParam: false),
                const SizedBox(height: 15),
                InputForm(
                    labelParam: 'Alamat',
                    controllerParam: controller.addressController,
                    obsecureParam: false),
                const SizedBox(height: 15),
                InputForm(
                    labelParam: 'No. Telepon',
                    controllerParam: controller.phoneController,
                    obsecureParam: false),
                const SizedBox(height: 15),
                InputForm(
                    labelParam: 'Email',
                    controllerParam: controller.emailController,
                    obsecureParam: false),
                const SizedBox(height: 15),
                InputForm(
                    labelParam: 'Username',
                    controllerParam: controller.usernameController,
                    obsecureParam: false),
                const SizedBox(height: 15),
                InputForm(
                    labelParam: 'Password',
                    controllerParam: controller.passwordController,
                    obsecureParam: true),
                const SizedBox(height: 15),
                InputForm(
                    labelParam: 'Konfirmasi Password',
                    controllerParam: controller.confirmPasswordController,
                    obsecureParam: true),
                const SizedBox(height: 15),
                Obx(() {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                    ),
                    onPressed: controller.isLoading.value
                        ? null
                        : () {
                            controller.register();
                            print(controller.nameController.text);
                          },
                    child: controller.isLoading.value
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text('Daftar',
                            style: GoogleFonts.poppins(
                                fontSize: size * 0.030, color: Colors.white)),
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
