import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_canary_farm_app/app/modules/chicksupdate/bindings/chicksupdate_binding.dart';
import 'package:royal_canary_farm_app/app/modules/chicksupdate/views/chicksupdate_view.dart';

import '../controllers/chicksdetail_controller.dart';

class ChicksdetailView extends GetView<ChicksdetailController> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Burung ${controller.bird.ringNumber}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(controller.bird.photo ?? ''),
                        radius: 90,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        '${controller.bird.ringNumber}',
                        style: GoogleFonts.roboto(
                          fontSize: size * 0.050,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Gender: ${controller.bird.gender}',
                  style: GoogleFonts.roboto(
                    fontSize: size * 0.040,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Canary Type: ${controller.bird.canaryType}',
                  style: GoogleFonts.roboto(
                    fontSize: size * 0.040,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Date of Birth: ${controller.bird.dateOfBirth}',
                  style: GoogleFonts.roboto(
                    fontSize: size * 0.040,
                  ),
                ),
                SizedBox(height: 20),
                Obx(() {
                  if (controller.maleParent.value.parent?.ringNumber == null) {
                    return Text('Induk Jantan: Data tidak tersedia');
                  }
                  return Text(
                    'Induk Jantan: ${controller.maleParent.value.parent?.ringNumber}',
                    style: GoogleFonts.roboto(
                      fontSize: size * 0.040,
                    ),
                  );
                }),
                SizedBox(height: 20),
                Obx(() {
                  if (controller.femaleParent.value.parent?.ringNumber ==
                      null) {
                    return Text('Induk Betina: Data tidak tersedia');
                  }
                  return Text(
                    'Induk Betina: ${controller.femaleParent.value.parent?.ringNumber}',
                    style: GoogleFonts.roboto(
                      fontSize: size * 0.040,
                    ),
                  );
                }),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.to(() => ChicksupdateView(),
                            arguments: {
                              'bird': controller.bird,
                              'maleParent': controller.maleParent.value,
                              'femaleParent': controller.femaleParent.value,
                            },
                            binding: ChicksupdateBinding());
                      },
                      child: Text('Update'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        controller.showDeleteConfirmationDialog();
                      },
                      child: Text(
                        'Delete',
                        style: GoogleFonts.roboto(
                          fontSize: size * 0.040,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
