import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController{

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  var googleAccount = Rx<GoogleSignInAccount?>(null);
  final RxBool isLoggedIn = false.obs;
  final Rx<String?> image = Rx<String?>(null);
  final Rx<String?> userName = Rx<String?>(null);
  final Rx<String?> userEmail = Rx<String?>(null);

  @override
  void onInit() {
    super.onInit();
    checkLogin(); // Check login status on initialization
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        // Handle successful sign-in here
        isLoggedIn.value = true;
        googleAccount.value = googleUser;
        image.value = googleUser.photoUrl;
        userName.value = googleUser.displayName;
        userEmail.value = googleUser.email;
        saveLoginState(true); // Persist login state
      }
    } catch (error) {
      // Handle sign-in errors
      if (kDebugMode) {
        print('Error signing in: $error');
      }
    }
  }

  void signOut() {
    _googleSignIn.signOut();
    isLoggedIn.value = false;
    saveLoginState(false); // Persist login state
    googleAccount.value =  null;
    image.value = null;
    userName.value = null;
    userEmail.value = null;
  }

  Future<void> checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;
    image.value = prefs.getString('isImage') ?? "";
    userName.value = prefs.getString('isUserName') ?? "";
    userEmail.value = prefs.getString('userEmail') ?? "";
  }

  Future<void> saveLoginState(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
    await prefs.setString('isImage', image.value ?? "");
    await prefs.setString('isUserName', userName.value ?? "");
    await prefs.setString('userEmail', userEmail.value ?? "");
  }
}