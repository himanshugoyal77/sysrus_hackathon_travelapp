import 'package:get/get.dart';

class UserInfoController extends GetxController {
  String? username = '';
  String? email = '';
  String? photoUrl = '';
  String? uid = '';
  String? phone = '';
  String? address = '';
  String? age = '';
  String? name = '';
  String? imageUrl = '';

  //  "Phone": phoneController.text,
  //     "address": addressController.text,
  //     "age": dropdownvalue,
  //     "name": widget.user!.displayName,
  //     "imageUrl": widget.user!.photoURL,
  //     "email": widget.user!.email

  void updateUserInfo(
      String? uid, String? username, String? email, String? photoUrl) {
    this.uid = uid;
    this.username = username;
    this.email = email;
    this.photoUrl = photoUrl;
    print("username:" + username.toString());
    update();
  }

  updateDetails(phone, address, age, name, imageUrl) {
    this.phone = phone;
    this.address = address;
    this.age = age;
    this.name = name;
    this.imageUrl = imageUrl;
    this.name = name;
  }
}
