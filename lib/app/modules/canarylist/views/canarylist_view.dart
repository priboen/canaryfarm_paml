import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_canary_farm_app/app/data/bird_parent.dart';
import 'package:royal_canary_farm_app/app/modules/canary/bindings/canary_binding.dart';
import 'package:royal_canary_farm_app/app/modules/canary/views/canary_view.dart';
import 'package:royal_canary_farm_app/app/modules/canarydetail/bindings/canarydetail_binding.dart';
import 'package:royal_canary_farm_app/app/modules/canarydetail/views/canarydetail_view.dart';
import '../controllers/canarylist_controller.dart';

class CanarylistView extends GetView<CanarylistController> {
  const CanarylistView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Induk Burung')),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          } else if (controller.birdsList.isEmpty) {
            return const Center(child: Text('No Birds Found'));
          } else {
            return ListView.builder(
              itemCount: controller.birdsList.length,
              itemBuilder: (context, index) {
                BirdParent bird = controller.birdsList[index];
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
                        backgroundImage: NetworkImage(bird.photo),
                        radius: 30,
                      ),
                      title: Text(
                        bird.ringNumber,
                        style: GoogleFonts.roboto(
                          fontSize: size * 0.040,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gender: ${bird.gender}',
                            style: GoogleFonts.roboto(
                              fontSize: size * 0.030,
                            ),
                          ),
                          Text(
                            'Canary Type: ${bird.canaryType}',
                            style: GoogleFonts.roboto(
                              fontSize: size * 0.030,
                            ),
                          ),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Get.to(() => CanarydetailView(),
                            arguments: bird, binding: CanarydetailBinding());
                        print(bird.id);
                        print(bird.ringNumber);
                        print(bird.price);
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
              await Get.to(() => CanaryView(), binding: CanaryBinding());
          if (result == true) {
            controller.fetchBirds();
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
