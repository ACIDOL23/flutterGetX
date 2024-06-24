import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopx/views/auth/loginpage.dart';

import '../../controllers/authcontroller.dart';
import '../../controllers/logincontroller.dart';
import '../auth/welcomepage.dart';

class UserDetailPage extends StatelessWidget {

  final LoginController loginController = Get.find();
  final AuthController authController = Get.put(AuthController());

  UserDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    print("#### ${authController.userModel.profilePic}");
    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        title: Text('Profile Details', style: GoogleFonts.balooBhai2(fontSize: 23),),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: authController.userModel.profilePic.isNotEmpty
                  ? NetworkImage(authController.userModel.profilePic.toString()!)
                  : AssetImage('assets/images/image1.png'),
              // If profilePic is empty or null, AssetImage will be used as fallback
            ),
            const SizedBox(
              height: 10,
            ),
            Text(authController.userModel.name ?? "Aniket",
                style: GoogleFonts.balooBhai2(fontSize: 20)),
            const SizedBox(
              height: 10,
            ),
            Text(authController.userModel.email ?? "Ok",
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
                Get.offAll(WelcomePage());
                authController.signOut();
              },
            )
          ],
        ),
      ),
    );
  }
}
