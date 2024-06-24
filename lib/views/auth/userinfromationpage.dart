import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopx/util/utils.dart';

import '../../controllers/authcontroller.dart';
import '../../widgets/custom_button.dart';

class UserInformationPage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  File? image;

  UserInformationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 5.0),
          child: Center(
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    authController.pickImage();
                  },
                  child: Obx(
                        () =>
                        CircleAvatar(
                          backgroundColor: Colors.deepPurpleAccent,
                          radius: 50,
                          child: authController.selectedImage.value == null
                              ? const Icon(
                            Icons.account_circle_rounded,
                            size: 50,
                            color: Colors.white,
                          )
                              : ClipOval(
                            child: Image.file(
                              authController.selectedImage.value!,
                              fit: BoxFit.cover,
                              width: 100,
                              height: 100,
                            ),
                          ),
                        ),
                  ),
                ),
                Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  padding:
                  const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      // name field
                      textField(
                        hintText: "John Smith",
                        icon: Icons.account_circle,
                        inputType: TextInputType.name,
                        maxLines: 1,
                        onChanged: (value) {
                          authController.updateName(value);
                        },
                        initialValue: authController.name.value,
                      ),

                      // email
                      textField(
                        hintText: "abc@example.com",
                        icon: Icons.email,
                        inputType: TextInputType.emailAddress,
                        maxLines: 1,
                        onChanged: (value) {
                          authController.updateEmail(value);
                        },
                        initialValue: authController.email.value,
                      ),

                      // bio
                      textField(
                        hintText: "Enter your bio here...",
                        icon: Icons.edit,
                        inputType: TextInputType.name,
                        maxLines: 2,
                        onChanged: (value) {
                          authController.updateBio(value);
                        },
                        initialValue: authController.bio.value,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Obx(() {
                        return SizedBox(
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          height: 50,
                          child: CustomButton(
                            text: authController.isLoading.value ? 'Please wait...' : "Continue",
                            onPressed: () {
                              authController.isLoading.value = true;
                              authController.saveUserDataToFirebase();
                            },
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget textField({
  required String hintText,
  required IconData icon,
  required TextInputType inputType,
  required int maxLines,
  required Function(String) onChanged,
  required String initialValue,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: TextFormField(
      initialValue: initialValue,
      onChanged: onChanged,
      cursorColor: Colors.deepPurpleAccent,
      keyboardType: inputType,
      maxLines: maxLines,
      decoration: InputDecoration(
        prefixIcon: Container(
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.deepPurpleAccent,
          ),
          child: Icon(
            icon,
            size: 20,
            color: Colors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        hintText: hintText,
        hintStyle: GoogleFonts.balooBhai2(),
        alignLabelWithHint: true,
        border: InputBorder.none,
        fillColor: Colors.purple.shade50,
        filled: true,
      ),
    ),
  );
}