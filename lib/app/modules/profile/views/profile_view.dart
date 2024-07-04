import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_canary_farm_app/app/routes/app_pages.dart';
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
            final photoUrl =
                controller.profile.value.photo; // Now uses full URL from API

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 80,
                        backgroundImage: NetworkImage(photoUrl),
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
                        controller.profile.value.username,
                        style: GoogleFonts.roboto(
                          fontSize: size * 0.030,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.yellow[100],
                        ),
                        onPressed: () {
                          Get.toNamed(Routes.PROFILEUPDATE);
                        },
                        label: Text(
                          "Edit Profile",
                          style: GoogleFonts.roboto(
                            fontSize: size * 0.030,
                            color: Colors.black,
                          ),
                        ),
                        icon: const Icon(
                          color: Colors.black,
                          Icons.edit,
                          size: 15,
                        ),
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
