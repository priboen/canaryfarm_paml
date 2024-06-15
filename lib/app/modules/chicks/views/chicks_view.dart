import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:royal_canary_farm_app/app/modules/widget/canary_type_dropdown.dart';

import '../controllers/chicks_controller.dart';

class ChicksView extends GetView<ChicksController> {
  const ChicksView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Orang Tua Burung'),
      ),
      body: Obx(
        () {
          if (controller.isLoadingMales.value ||
              controller.isLoadingFemales.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CanaryTypeDropdown(
                    items: controller.males
                        .map((male) => male.ringNumber)
                        .toList(),
                    hint: 'Pilih Ayah',
                    onChanged: (selectedValue) {
                      // Implement logic when male is selected
                      controller.selectedMale.value = controller.males
                          .firstWhere(
                              (male) => male.ringNumber == selectedValue);
                    },
                  ),
                  SizedBox(height: 16),
                  CanaryTypeDropdown(
                    items: controller.females
                        .map((female) => female.ringNumber)
                        .toList(),
                    hint: 'Pilih Ibu',
                    onChanged: (selectedValue) {
                      // Implement logic when female is selected
                      controller.selectedFemale.value = controller.females
                          .firstWhere(
                              (female) => female.ringNumber == selectedValue);
                    },
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: ListView(
                      children: [
                        if (controller.selectedMale.value != null)
                          ListTile(
                            title: Text(
                                'Ayah Terpilih: ${controller.selectedMale.value!.ringNumber}'),
                            subtitle: Text(
                                'Tipe: ${controller.selectedMale.value!.canaryType}'),
                          ),
                        if (controller.selectedFemale.value != null)
                          ListTile(
                            title: Text(
                                'Ibu Terpilih: ${controller.selectedFemale.value!.ringNumber}'),
                            subtitle: Text(
                                'Tipe: ${controller.selectedFemale.value!.canaryType}'),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
