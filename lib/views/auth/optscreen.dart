import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:shopx/views/auth/registerpage.dart';

import '../../controllers/authcontroller.dart';
import '../../widgets/custom_button.dart';

class OtpScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.purple.shade50,
                    ),
                    padding: const EdgeInsets.all(20.00),
                    child: Image.asset(
                      "assets/images/image2.png",
                      height: 300,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Verification",
                    style: GoogleFonts.balooBhai2(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Enter 6 digit OTP that you receive on your phone.",
                    style: GoogleFonts.balooBhai2(
                      fontSize: 14,
                      color: Colors.black38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Pinput(
                    length: 6,
                    showCursor: true,
                    defaultPinTheme: PinTheme(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.purple.shade200,
                        ),
                      ),
                      textStyle: GoogleFonts.balooBhai2(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onChanged: (otp) {
                      // This ensures the OTP is captured as the user types
                      authController.userOTP.value = otp;
                    },
                    onSubmitted: (otp) {
                      print("OTP Submitted: $otp");
                      authController.userOTP.value = otp;
                    },
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: CustomButton(
                      text:
                          authController.isLoading.value ? 'Please wait...' : 'Verify',
                      onPressed: () {
                        print("Verifying OTP: ${authController.userOTP.value}");
                        authController.verifyOTP();
                      },
                    ),
                  ),
                  const SizedBox(height: 25),
                  /*Obx(() {
                    if (authController.isUserExist.value == false) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(RegisterScreen());
                        },
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "User with this number is already exist. ",
                                style: GoogleFonts.balooBhai2(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0,
                                ),
                              ),
                              TextSpan(
                                text: "Click here",
                                style: GoogleFonts.balooBhai2(
                                  color: Colors.redAccent,
                                  // You can change the color to make it look like a link
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.0,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.to(RegisterScreen());
                                  },
                              ),
                              TextSpan(
                                text: " to try with another phone number.",
                                style: GoogleFonts.balooBhai2(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
                  }),*/
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
