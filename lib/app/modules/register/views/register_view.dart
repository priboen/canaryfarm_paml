import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:royal_canary_farm_app/app/modules/login/views/login_view.dart';
import 'package:royal_canary_farm_app/app/modules/widget/input_widget.dart';
import 'package:royal_canary_farm_app/app/modules/widget/maps_screen.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  RegisterView({super.key});

  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

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
                Text(
                  'Register Page',
                  style: GoogleFonts.poppins(fontSize: size * 0.040),
                ),
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
                  controllerParam: nameController,
                  obsecureParam: false,
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: InputForm(
                        labelParam: 'Alamat',
                        controllerParam: addressController,
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
                                  addressController.text = address;
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
                  controllerParam: phoneController,
                  obsecureParam: false,
                ),
                const SizedBox(height: 15),
                InputForm(
                  labelParam: 'Username',
                  controllerParam: usernameController,
                  obsecureParam: false,
                ),
                const SizedBox(height: 15),
                InputForm(
                  labelParam: 'Password',
                  controllerParam: passwordController,
                  obsecureParam: true,
                ),
                const SizedBox(height: 15),
                InputForm(
                  labelParam: 'Konfirmasi Password',
                  controllerParam: confirmPasswordController,
                  obsecureParam: true,
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
                            // Log the current data
                            print('Name: ${nameController.text}');
                            print('Username: ${usernameController.text}');
                            print('Password: ${passwordController.text}');
                            print(
                                'Confirm Password: ${confirmPasswordController.text}');
                            print('Address: ${addressController.text}');
                            print('Phone: ${phoneController.text}');
                            print(
                                'Selected Image: ${controller.selectedImage}');

                            controller.register();
                          },
                    child: controller.isLoading.value
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'Daftar',
                            style: GoogleFonts.poppins(
                                fontSize: size * 0.030, color: Colors.white),
                          ),
                  );
                }),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Sudah memiliki akun?",
                      style: GoogleFonts.poppins(fontSize: size * 0.035),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => LoginView());
                      },
                      child: Text(
                        "Masuk disini!",
                        style: GoogleFonts.poppins(fontSize: size * 0.035),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
