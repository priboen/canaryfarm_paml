import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:royal_canary_farm_app/app/modules/widget/input_widget.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({super.key});

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const LoginHeader(),
            Text("Login Page",
                style: GoogleFonts.poppins(fontSize: size * 0.080)),
            Text("Royal Canary Bird Farm",
                style: GoogleFonts.poppins(fontSize: size * 0.040)),
            const SizedBox(
              height: 15,
            ),
            InputForm(
              labelParam: "Username",
              controllerParam: _usernameController,
              obsecureParam: false,
            ),
            const SizedBox(
              height: 15,
            ),
            InputForm(
              labelParam: "Password",
              controllerParam: _passwordController,
              obsecureParam: true,
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                elevation: 0,
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 15,
                ),
              ),
              onPressed: () async {
                await loginController.login(
                  username: _usernameController.text.trim(),
                  password: _passwordController.text.trim(),
                );
              },
              child: Obx(
                () {
                  return loginController.isLoading.value
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          "Login",
                          style: GoogleFonts.poppins(
                            fontSize: size * 0.080,
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginHeader extends StatelessWidget {
  const LoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://images-platform.99static.com/pcoX0s_A7IEG7CpjnmLbcLwyH_o=/652x189:1367x904/500x500/top/smart/99designs-contests-attachments/86/86135/attachment_86135086"),
              radius: 80,
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
