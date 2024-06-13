import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:royal_canary_farm_app/app/data/gender.dart';

class GenderRadioButton extends StatelessWidget {
  final Rx<Gender> selectedGender;

  const GenderRadioButton({
    Key? key,
    required this.selectedGender,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: Gender.values.map((gender) {
        return Obx(() {
          return RadioListTile<Gender>(
            title: Text(gender.name),
            value: gender,
            groupValue: selectedGender.value,
            onChanged: (Gender? value) {
              if (value != null) {
                selectedGender.value = value;
              }
            },
          );
        });
      }).toList(),
    );
  }
}
