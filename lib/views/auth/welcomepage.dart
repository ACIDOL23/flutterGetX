import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopx/views/auth/registerpage.dart';
import 'package:shopx/views/home/homepage.dart';
import 'package:shopx/widgets/custom_button.dart';
import 'package:get/get.dart';

import '../../controllers/authcontroller.dart';


class WelcomePage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/image1.png",
                    height: 300,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Let's get started",
                    style: GoogleFonts.balooBhai2(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Never a better time then now to start.",
                    style: GoogleFonts.balooBhai2(
                        fontSize: 14,
                        color: Colors.black38,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // custom button
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: CustomButton(
                        text: 'Get started',
                        onPressed: () {
                          if (authController.isLoggedIn.value) {
                            Get.to(Homepage());
                          } else {
                            Get.to(RegisterScreen());
                          }
                        }),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}