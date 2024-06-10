import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputForm extends StatelessWidget {
  const InputForm(
      {super.key,
      required this.labelParam,
      required this.controllerParam,
      required this.obsecureParam});

  final String labelParam;
  final TextEditingController controllerParam;
  final bool obsecureParam;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controllerParam,
        decoration: InputDecoration(
          labelText: labelParam,
          hintText: 'Masukan $labelParam disini',
          hintStyle: GoogleFonts.poppins(fontSize: 12),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        obscureText: obsecureParam,
      ),
    );
  }
}
