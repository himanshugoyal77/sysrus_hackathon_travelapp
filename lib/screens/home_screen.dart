import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/components/custom_button.dart';
import 'package:flutter_assignment/controller/auth_controller.dart';
import 'package:flutter_assignment/screens/display_all.dart';
import 'package:flutter_assignment/screens/login_screen.dart';

class HomeScreen extends StatefulWidget {
  User? user;
  HomeScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController addressController = TextEditingController();

  TextEditingController phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String dropdownvalue = '18';
  var items = [
    '18',
    '19',
    '20',
    '21',
    '22',
  ];

  void saveToFirebase() {
    FirebaseFirestore.instance
        .collection("userInfo")
        .doc(widget.user!.uid)
        .set({
      "Phone": phoneController.text,
      "address": addressController.text,
      "age": dropdownvalue,
      "name": widget.user!.displayName,
      "imageUrl": widget.user!.photoURL,
      "email": widget.user!.email
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('data added successfully')));
    });
  }

  @override
  void initState() {
    for (int i = 23; i <= 40; i++) {
      items.add(i.toString());
    }
    super.initState();
  }

  bool _isNumeric(String str) {
    if (str == null) {
      return false;
    }
    return double.tryParse(str) != null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Authentication.signOut(context: context).then((value) =>
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const LoginScreen()))));
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hello ${widget.user!.displayName.toString()}",
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 18,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Enter Phone no :",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    TextFormField(
                      validator: ((value) {
                        if (value == null ||
                            value.length != 10 ||
                            value.isEmpty ||
                            !_isNumeric(value)) {
                          return 'Enter a valid number';
                        }
                        return null;
                      }),
                      controller: phoneController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: Color(0xff0063F5))),
                        hintText: 'phone number',
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    const Text("Enter your address :",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    TextFormField(
                      validator: ((value) {
                        if (value!.length < 10) {
                          return 'Enter a valid address';
                        }
                        return null;
                      }),
                      maxLines: 8,
                      controller: addressController,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.white)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide:
                                const BorderSide(color: Color(0xff0063F5))),
                        hintText: 'address',
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      children: [
                        const Text("Select your age : ",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold)),
                        DropdownButton(
                          value: dropdownvalue,
                          icon: const Icon(Icons.keyboard_arrow_down),
                          items: items.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              dropdownvalue = newValue!;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    GestureDetector(
                        onTap: (() {
                          if (_formKey.currentState!.validate()) {
                            saveToFirebase();
                          }
                        }),
                        child: const CustomButton(
                          btnName: "Save to Firebase",
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
