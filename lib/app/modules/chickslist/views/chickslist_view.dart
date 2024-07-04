import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_canary_farm_app/app/data/chicks.dart';
import 'package:royal_canary_farm_app/app/modules/chicks/bindings/chicks_binding.dart';
import 'package:royal_canary_farm_app/app/modules/chicks/views/chicks_view.dart';
import 'package:royal_canary_farm_app/app/modules/chicksdetail/bindings/chicksdetail_binding.dart';
import 'package:royal_canary_farm_app/app/modules/chicksdetail/views/chicksdetail_view.dart';

import '../controllers/chickslist_controller.dart';

class ChickslistView extends GetView<ChickslistController> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Anak Burung')),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.chicksList.isEmpty) {
            return const Center(child: Text('Tidak ada data burung'));
          } else {
            return ListView.builder(
              itemCount: controller.chicksList.length,
              itemBuilder: (context, index) {
                Chicks chicks = controller.chicksList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 5,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10.0),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(chicks.photo!),
                        radius: 30,
                      ),
                      title: Text(
                        chicks.ringNumber!,
                        style: GoogleFonts.roboto(
                          fontSize: size * 0.040,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gender: ${chicks.gender}',
                            style: GoogleFonts.roboto(
                              fontSize: size * 0.030,
                            ),
                          ),
                          Text(
                            'Canary Type: ${chicks.canaryType}',
                            style: GoogleFonts.roboto(
                              fontSize: size * 0.030,
                            ),
                          ),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Get.to(() => ChicksdetailView(),
                            arguments: chicks, binding: ChicksdetailBinding());
                        print(chicks.id);
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var result =
              await Get.to(() => ChicksView(), binding: ChicksBinding());
          if (result == true) {
            controller.fetchChicks();
          }
        },
        child: Icon(
          Icons.add,
          color: Colors.grey[800],
        ),
      ),
    );
  }
}
