import 'package:flutter/material.dart';

class BirthDatePicker extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final Function(DateTime)? onDateSelected;

  const BirthDatePicker({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
    this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );

        if (pickedDate != null) {
          controller.text = "${pickedDate.toLocal()}".split(' ')[0];
          if (onDateSelected != null) {
            onDateSelected!(pickedDate);
          }
        }
      },
      validator: validator,
    );
  }
}
