import 'package:country_picker/country_picker.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  var selectedCountry = Country(
    phoneCode: "91",
    countryCode: "IN",
    e164Sc: 0,
    geographic: true,
    level: 1,
    name: "India",
    displayName: "India",
    displayNameNoCountryCode: "IN",
    e164Key: "",
    example: 'new',
  ).obs;
  var isLoading = false.obs;

  void updateCountry(Country country) {
    selectedCountry.value = country;
  }


  @override
  void onClose() {
    isLoading.value = false;
    super.onClose();
  }

  var number = ''.obs;
  var maxLength = 9.obs;  // You can set your desired max length here

  void updateNumber(String value) {
    if (value.length >= maxLength.value) {
      number.value = value;
    }
  }


  String? validateNumber(String value) {
    print("### ${value.length}");
    print("### ${maxLength.value}");
    if (value.isEmpty) {
      isLoading.value = false;
      return 'Please enter a number';
    }
    else if (value.length <= 9) {
      isLoading.value = false;
      return 'Number must be greater than 9 digits';
    }
    return null;
  }

  void setLoading(bool value) {
    isLoading.value = value;
  }
}
