// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_canary_farm_app/app/modules/canaryupdate/bindings/canaryupdate_binding.dart';
import 'package:royal_canary_farm_app/app/modules/canaryupdate/views/canaryupdate_view.dart';

import '../controllers/canarydetail_controller.dart';

class CanarydetailView extends GetView<CanarydetailController> {
  const CanarydetailView({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar:
          AppBar(title: Text('Detail Burung ${controller.bird.ringNumber}')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(controller.bird.photo!),
                    radius: 90,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
            SizedBox(height: 10),
            Text(
              'Canary Type: ${controller.bird.canaryType}',
              style: GoogleFonts.roboto(
                fontSize: size * 0.040,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Price: Rp. ${controller.bird.price}',
              style: GoogleFonts.roboto(
                fontSize: size * 0.040,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => CanaryupdateView(),
                        arguments: controller.bird,
                        binding: CanaryupdateBinding());
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
      ),
    );
  }
}
