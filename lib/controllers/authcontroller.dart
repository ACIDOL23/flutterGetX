import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopx/views/home/homepage.dart';
import 'package:shopx/views/auth/userinfromationpage.dart';

import '../models/usermodel.dart';
import '../views/auth/optscreen.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  final RxBool isLoggedIn = false.obs;


  final RxBool isUserExist = true.obs;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  RxString _verificationId = "".obs;
  RxString userOTP = "".obs;
  RxString userId = "".obs;

  var name = ''.obs;
  var email = ''.obs;
  var bio = ''.obs;

  UserModel? _userModel;

  UserModel get userModel => _userModel!;

  @override
  void onInit() {
    getUserModelFromPreferences();
    checkSign();
    super.onInit();
  }

  void checkSign() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool("is_signedIn") ?? false;
  }

  Future<void> setSignIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("is_signedIn", true);
    isLoggedIn.value = true;
  }



  // signin
  signInWithPhone(String countryCode, String phoneNumber) async {
    print("#### ${countryCode} ${phoneNumber}}");
    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: countryCode + phoneNumber,
          verificationCompleted:
              (PhoneAuthCredential phoneAuthCredential) async {
            Get.snackbar(
                'Success', 'User verified successfully.');
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error) {
            Get.snackbar('Failed', '${error}');
            print("#### Code error sent to ${error}");
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken) {
            Get.snackbar(
                'Success', 'Code sent to ${countryCode} ${phoneNumber}');
            _verificationId.value = verificationId;
            print("#### Code sent to ${countryCode} ${phoneNumber}");
            Get.to(OtpScreen());
          },
          codeAutoRetrievalTimeout: (verificationId) {});
    } on FirebaseAuthException catch (e) {
      print(e);
    }
  }

  // verifyOTP
  void verifyOTP() async {
    print("####  OTP ${userOTP.value}");
    isLoading.value = true;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId.value, smsCode: userOTP.value);
    User? user = (await _firebaseAuth.signInWithCredential(credential)).user!;
    if (user != null) {
      userId.value = user.uid;
      checkExistingUser();
    }
  }

  Future<bool> checkExistingUser() async {
    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection("users").doc(userId.value).get();
    print("### snapshoe ${snapshot.id}");
    if (snapshot.exists) {
      isUserExist.value = false;
      Get.snackbar(
          'Success', 'Welcome back..enjoy the ride.');
      checkForLogin();
      print("NEW USER");
      isLoading.value = false;

      return false;
      return true;
    } else {
      isUserExist.value = true;
      print("NEW USER");
      isLoading.value = false;
      Get.to(UserInformationPage());
      return false;
    }
  }

  var selectedImage = Rxn<File>();

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      print("### ${pickedFile.path}");
      selectedImage.value = File(pickedFile.path);
    }
  }

  void updateName(String newName) {
    name.value = newName;
  }

  void updateEmail(String newEmail) {
    email.value = newEmail;
  }

  void updateBio(String newBio) {
    bio.value = newBio;
  }

  void saveUserDataToFirebase() async {
    RxString image = "".obs;
    try {
      // Upload image to storage and wait for the result
      String imageUrl =
          await storeFileToStorage("profilePic/$userId", selectedImage.value!);

      // Once image upload is complete, update the RxString
      image.value = imageUrl;

      // Now that image.value is updated, upload data to Firestore
      await FirebaseFirestore.instance
          .collection("users")
          .doc(_firebaseAuth.currentUser!.uid)
          .set({
        "name": name.value,
        "email": email.value,
        "uid": userId.value,
        "bio": bio.value,
        "profilePic": image.value,
        "phoneNumber": _firebaseAuth.currentUser!.phoneNumber!,
        "createdAt": DateTime.now().millisecondsSinceEpoch.toString(),
      });

      setSignIn();
      getDataFromFirestore();

/*      await _firebaseFirestore.collection('your_collection').add({
        'timestamp': FieldValue.serverTimestamp(),
      });*/
    } on FirebaseAuthException catch (e) {
      print("### ${e}");
    }
  }

  Future<void> saveUserModelToPreferences(UserModel userModel) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userModelJson = jsonEncode(userModel.toJson());
    await prefs.setString("user_model", userModelJson);
  }

  Future<void> getUserModelFromPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userModelJson = prefs.getString("user_model");
    if (userModelJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userModelJson);
      _userModel = UserModel.fromJson(userMap);
      print("#### ${_userModel}");
      update(); // Notify listeners to update UI
    }
  }

  Future<String> storeFileToStorage(String ref, File file) async {
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  Future checkForLogin() async{
    DocumentSnapshot snapshot = await _firebaseFirestore.collection("users").doc(userId.value).get();
    DocumentSnapshot data = await _firebaseFirestore
        .collection("users")
        .doc(snapshot.id)
        .get();

    // Populate _userModel after Firestore query completes
    _userModel = UserModel(
      name: data['name'],
      email: data['email'],
      createdAt: data['createdAt'],
      bio: data['bio'],
      uid: data['uid'],
      profilePic: data['profilePic'],
      phoneNumber: data['phoneNumber'],
    );

    if(userModel.email == data['email'] && userModel.phoneNumber == data['phoneNumber']){
      print("### data $_userModel");
      print("### data ${userModel.profilePic}");
      setSignIn();
      saveUserModelToPreferences(userModel);
      Get.to(Homepage());
    }else {
      print("### data Nope");
    }



  }

  Future getDataFromFirestore() async {
    // Perform Firestore query and await for the result
    print("#### ${_firebaseAuth.currentUser!.uid}");
    DocumentSnapshot snapshot = await _firebaseFirestore
        .collection("users")
        .doc(_firebaseAuth.currentUser!.uid)
        .get();
    // Populate _userModel after Firestore query completes
    _userModel = UserModel(
      name: snapshot['name'],
      email: snapshot['email'],
      createdAt: snapshot['createdAt'],
      bio: snapshot['bio'],
      uid: snapshot['uid'],
      profilePic: snapshot['profilePic'],
      phoneNumber: snapshot['phoneNumber'],
    );
    saveUserModelToPreferences(userModel);
    print("### data $_userModel");
    print("### data ${userModel.profilePic}");
    Get.to(Homepage());
  }
  Future<void> clearPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
  Future signOut() async {
    await _firebaseAuth.signOut();
    isLoggedIn.value = false;
    isLoading.value = false;
    clearPreferences();
  }
}
