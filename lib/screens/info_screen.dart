import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/components/custom_button.dart';
import 'package:flutter_assignment/controller/auth_controller.dart';
import 'package:flutter_assignment/controller/user_info_controller.dart';
import 'package:flutter_assignment/screens/home_screen.dart';
import 'package:flutter_assignment/screens/login_screen.dart';
import 'package:flutter_assignment/travel/screens/home_page.dart';
import 'package:flutter_assignment/travel/widgets/bottom_navigation.dart';
import 'package:get/get.dart';

class InfoScreen extends StatelessWidget {
  User? data;
  InfoScreen({
    Key? key,
    this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userController = Get.put(UserInfoController());
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Your Login Information",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadiusDirectional.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(data!.photoURL.toString()))),
            ),
            const SizedBox(
              height: 18,
            ),
            const Text("Name :",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(data!.displayName.toString()),
            const SizedBox(
              height: 18,
            ),
            const Text("Email :",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(data!.email.toString()),
            const SizedBox(
              height: 18,
            ),
            const Text("Phone no :",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text(data!.phoneNumber == null
                ? "91xxxxxxxx"
                : data!.phoneNumber.toString()),
            const SizedBox(
              height: 18,
            ),
            GestureDetector(
                onTap: () {
                  userController.updateUserInfo(data!.uid, data!.displayName,
                      data!.email, data!.photoURL);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (ctx) => BottomNavigationComponent()),
                  );
                },
                child: const CustomButton(
                  btnName: "Continue",
                )),
          ],
        ),
      ),
    );
  }
}
