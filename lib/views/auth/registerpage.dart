import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopx/controllers/authcontroller.dart';
import 'package:shopx/controllers/registercontroller.dart';
import '../../widgets/custom_button.dart';

class RegisterScreen extends StatelessWidget {
  final RegisterController registerController = Get.put(RegisterController());
  final AuthController authController = Get.find();


  RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 35),
            child: Form(
              key: _formKey, // Add the key here
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: 200,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.purple.shade50,
                      ),
                      padding: const EdgeInsets.all(20.00),
                      child: Image.asset("assets/images/image2.png"),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Register User",
                      style: GoogleFonts.balooBhai2(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Add your phone number. We'll send you a verification code.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.balooBhai2(
                        fontSize: 14,
                        color: Colors.black38,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      style: GoogleFonts.balooBhai2(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                      cursorColor: Colors.deepPurpleAccent,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: "Enter phone number",
                        hintStyle: GoogleFonts.balooBhai2(color: Colors.black38),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black12),
                        ),
                        prefixIcon: Container(
                          padding: const EdgeInsets.all(12.0),
                          child: InkWell(
                            onTap: () {
                              showCountryPicker(
                                countryListTheme: const CountryListThemeData(
                                  bottomSheetHeight: 550,
                                ),
                                context: context,
                                showPhoneCode: true,
                                onSelect: (Country country) {
                                  registerController.updateCountry(country);
                                },
                              );
                            },
                            child: Obx(() {
                              return Text(
                                textAlign: TextAlign.center,
                                "${registerController.selectedCountry.value
                                    .flagEmoji} +${registerController
                                    .selectedCountry.value.phoneCode}",
                                style: GoogleFonts.balooBhai2(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              );
                            }),
                          ),
                        ),
                        suffixIcon: Obx(() {
                          if (registerController.number.value.length > 9) {
                            return Container(
                              height: 18,
                              width: 18,
                              margin: const EdgeInsets.all(10.0),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                              child: const Icon(
                                Icons.done,
                                color: Colors.white,
                                size: 20,
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        }),
                      ),
                      onChanged: (value) {
                        registerController.updateNumber(value);
                      },
                      validator: (value) {
                        return registerController.validateNumber(value!);
                      },
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: Obx(() {
                        return CustomButton(
                          text: registerController.isLoading.value ? 'Please wait...' : 'Login',
                          onPressed: () {
                            registerController.setLoading(true);
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, start the loading state and initiate the login process.
                
                              authController.signInWithPhone(
                                "+${registerController.selectedCountry.value
                                    .phoneCode}",
                                registerController.number.value,
                              ).then((_) {
                
                                // After login process is complete, reset the loading state.
                                Get.snackbar('Success',
                                    'You will receive an OTP in few minutes.');
                              }).catchError((error) {
                                // If an error occurs, reset the loading state and show an error message.
                                registerController.setLoading(false);
                                Get.snackbar(
                                    'Error', 'Login failed. Please try again.');
                              });
                            } else {
                              // If the form is invalid, display a snackbar.
                              Get.snackbar(
                                  'Error', 'Please enter a valid phone number');
                            }
                          },
                        );
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
