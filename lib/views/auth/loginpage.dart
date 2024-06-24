import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopx/controllers/logincontroller.dart';
import 'package:shopx/views/home/homepage.dart';

class LoginPage extends StatelessWidget {
  final loginController = Get.put(LoginController());

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        centerTitle: true,
        title: Text("Login Page", style: GoogleFonts.balooBhai2()),
      ),
      body: Center(
        child: Obx(() {
          if (loginController.googleAccount.value == null) {
            return buildLoginButton();
          } else {
            Future.delayed(Duration.zero, () {
              Get.to(() => Homepage());
            });
            return const SizedBox.shrink(); // Return an empty widget while navigating
          }
        }),
      ),
    );
  }

  FloatingActionButton buildLoginButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        if (kDebugMode) {
          print("object");
        }
        loginController.signInWithGoogle();
      },
      icon: Image.asset(
        'assets/images/google_login.png',
        width: 30,
        height: 30,
      ),
      label: Text("Sign in with Google",
          style: GoogleFonts.balooBhai2(fontSize: 16)),
      foregroundColor: Colors.black,
      backgroundColor: Colors.white,
    );
  }

  Column buildProfileView() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CircleAvatar(
          backgroundImage:
              Image.network(loginController.googleAccount.value?.photoUrl ?? "")
                  .image,
          radius: 15,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(loginController.googleAccount.value?.displayName ?? "",
            style: GoogleFonts.balooBhai2(fontSize: 20)),
        const SizedBox(
          height: 10,
        ),
        Text(loginController.googleAccount.value?.email ?? "",
            style: GoogleFonts.balooBhai2(fontSize: 20)),
        const SizedBox(
          height: 10,
        ),
        ActionChip(
          avatar: const Icon(Icons.logout),
          label: Text(
            "Logout",
            style: GoogleFonts.balooBhai2(fontSize: 16),
          ),
          onPressed: () {
            loginController.signOut();
          },
        )
      ],
    );
  }
}
