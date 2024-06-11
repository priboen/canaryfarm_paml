import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 80,
                            backgroundImage:
                                NetworkImage(controller.profile.value.photo),
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
                                icon: const Icon(Icons.add_a_photo_rounded),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        controller.profile.value.name,
                        style: GoogleFonts.roboto(
                          fontSize: size * 0.040,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        controller.profile.value.id.toString(),
                        style: GoogleFonts.roboto(
                          fontSize: size * 0.030,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {},
                            label: Text(
                              "Edit Profile",
                              style: GoogleFonts.roboto(
                                fontSize: size * 0.030,
                              ),
                            ),
                            icon: const Icon(
                              Icons.edit,
                              size: 15,
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: () {},
                            label: Text(
                              "Hapus Akun",
                              style: GoogleFonts.roboto(
                                fontSize: size * 0.030,
                              ),
                            ),
                            icon: const Icon(
                              Icons.close,
                              size: 15,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Alamat',
                  style: GoogleFonts.roboto(
                    fontSize: size * 0.025,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(controller.profile.value.address),
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'No. HP',
                  style: GoogleFonts.roboto(
                    fontSize: size * 0.025,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(controller.profile.value.phone),
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: () {
                      controller.logout();
                    },
                    label: Text(
                      "Keluar",
                      style: GoogleFonts.roboto(
                        fontSize: size * 0.030,
                        color: Colors.white,
                      ),
                    ),
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
