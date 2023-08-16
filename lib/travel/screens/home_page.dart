import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/controller/api_controller.dart';
import 'package:flutter_assignment/controller/location_controller.dart';
import 'package:flutter_assignment/travel/models/buses_model.dart';
import 'package:flutter_assignment/travel/screens/bus_details.dart';
import 'package:flutter_assignment/travel/widgets/bus_card.dart';
import 'package:flutter_assignment/travel/widgets/custom_location.dart';
import 'package:flutter_assignment/travel/widgets/search_bar.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:flutter_assignment/controller/user_info_controller.dart';
import 'package:http/http.dart' as http;
import '../widgets/bottom_navigation.dart';
import '../widgets/recommanded.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userController = Get.put(UserInfoController());
  List favBus = [];
  List busList = [];
  void getBusesdata() async {
    var url = Uri.parse(
        "https://buses-data-production-b877.up.railway.app/api/products");
    final response = await http.get(url);
    print("lemon");
    print(response.statusCode);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body)["myData"];
      print(data);
      setState(() {
        busList = data;
      });
    }
  }

  void getData() async {
    var collection = FirebaseFirestore.instance.collection('userInfo');
    var docSnapshot = await collection.doc(userController.uid).get();
    print("doc snapshot");
    print(docSnapshot.data());
    if (docSnapshot.data() != null) {
      setState(() {
        favBus = docSnapshot.data()!["fav"];
      });
      print("fav buses");
      print(favBus);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getBusesdata();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final userController = Get.put(UserInfoController());
    final latlonController = Get.put(LatLonController());
    latlonController.getCurrentPosition();

    // print(latlonController.city);

    return Scaffold(
      //backgroundColor: Color(0xff0a4457).withOpacity(0.8),
      body: Padding(
        padding: const EdgeInsets.only(top: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Hello, \n${userController.username}",
                      style: const TextStyle(
                        color: Colors.black,
                        letterSpacing: 1.1,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CircleAvatar(
                        radius: 22,
                        foregroundImage:
                            NetworkImage(userController.photoUrl.toString())),
                  ],
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              LocationCard(),
              const SizedBox(
                height: 18,
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  //color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Recent",
                            style: TextStyle(
                              color: Colors.black,
                              letterSpacing: 1.1,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                              onPressed: () {}, child: const Text("View All"))
                        ],
                      ),
                    ),
                    favBus.length > 0
                        ? SizedBox(
                            height: 350,
                            child: ListView.builder(
                              itemCount: favBus.length,
                              itemBuilder: (BuildContext context, int index) {
                                return BusCard(busList: favBus, index: index);
                              },
                            ),
                          )
                        : Center(
                            child: Text(
                              "No recent searches",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        "Choose your Transport",
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 1,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    VehicalCard(
                      image: "assets/bus.png",
                      title: "Bus",
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    VehicalCard(
                      image: "assets/mrt.jpg",
                      title: "MRT",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Recommendation",
                            style: TextStyle(
                              color: Colors.black,
                              letterSpacing: 1.1,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextButton(
                              onPressed: () {}, child: const Text("View All"))
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const RecommendedPlaces(),
                    const SizedBox(height: 10),
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

class VehicalCard extends StatelessWidget {
  final String image;
  final String title;

  const VehicalCard({
    Key? key,
    required this.image,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: title == "Bus" ? const Color(0xff78c0db) : Color(0xff3a9ec2),
      ),

      //   color: Color(0xff3a9ec2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 0)),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BusDetails()));
                    },
                    child: const Text("Select"))
              ],
            ),
          ),
          Image.asset(
            image,
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }
}
