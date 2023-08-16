import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/controller/user_info_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class BusDetails extends StatefulWidget {
  const BusDetails({super.key});

  @override
  State<BusDetails> createState() => _BusDetailsState();
}

class _BusDetailsState extends State<BusDetails> {
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

  @override
  void initState() {
    // TODO: implement initState
    getBusesdata();
    super.initState();
  }

  @override
  final fromController = TextEditingController();
  final toController = TextEditingController();
  Widget build(BuildContext context) {
    String start = '';
    String end = '';
    final w = MediaQuery.of(context).size.width;

    void searchStation(String query) {
      if (busList.length > 0) {
        final suggestion = busList.where((element) {
          final from = element["destination"].toString().toLowerCase();
          final input = query.toLowerCase();

          return from.contains(input);
        }).toList();

        setState(() {
          busList = suggestion;
        });
      }
    }

    return Scaffold(
      backgroundColor: Color(0xff3a9ec2),
      body: Padding(
        padding: const EdgeInsets.only(top: 44),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "MRT",
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              Image.asset(
                "assets/mrt.jpg",
                // height: 300,
                width: w,
                fit: BoxFit.contain,
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 150,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 4),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 4),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ]),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.blue,
                                ),
                                Text("|"),
                                Text("|"),
                                Icon(Icons.location_on),
                              ],
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "From",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                                SizedBox(
                                    height: 20,
                                    width: 150,
                                    child: TextFormField(
                                      controller: fromController,
                                      onChanged: searchStation,
                                    )),
                                const SizedBox(
                                  height: 12.0,
                                ),
                                const Text(
                                  "To",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 12.0,
                                ),
                                SizedBox(
                                    height: 20,
                                    width: 150,
                                    child: TextFormField(
                                      controller: toController,
                                      onChanged: searchStation,
                                    )),
                              ],
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xff3a9ec2)),
                                  padding: MaterialStateProperty.all(
                                      const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 0)),
                                ),
                                onPressed: () {
                                  setState(() {});
                                },
                                child: const Text(
                                  "Search",
                                  style: TextStyle(color: Colors.white),
                                ))
                          ],
                        )),
                    const Padding(
                      padding: EdgeInsets.only(left: 18.0, top: 18),
                      child: Text(
                        "Choose Schedule",
                        style: TextStyle(
                          color: Colors.black,
                          letterSpacing: 0.8,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 310,
                      child: ListView.builder(
                        itemCount: busList.length,
                        itemBuilder: (BuildContext context, int index) {
                          print(fromController.text);
                          return BusTimmingCard(
                            start: fromController.text,
                            end: toController.text,
                            index: index,
                            busList: busList,
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    )
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

class BusTimmingCard extends StatefulWidget {
  final String start;
  final String end;
  final List busList;
  final int index;
  const BusTimmingCard({
    Key? key,
    required this.start,
    required this.end,
    required this.busList,
    required this.index,
  }) : super(key: key);

  @override
  State<BusTimmingCard> createState() => _BusTimmingCardState();
}

class _BusTimmingCardState extends State<BusTimmingCard> {
  List data = [];
  final userController = Get.put(UserInfoController());

  void getData() async {
    var collection = FirebaseFirestore.instance.collection('userInfo');
    var docSnapshot = await collection.doc(userController.uid).get();
    print("doc snapshot");
    print(docSnapshot.data());
    if (docSnapshot.data() != null) {
      setState(() {
        data = docSnapshot.data()!["fav"];
      });
    }
  }

  void saveToFirebase() {
    print("here");
    print(userController.uid);
    FirebaseFirestore.instance
        .collection("userInfo")
        .doc(userController.uid)
        .set({
      "fav": [
        ...data,
        {
          "uid": "lemon",
          "from": widget.busList[widget.index]["origin"],
          "to": widget.busList[widget.index]["destination"],
          "start": widget.busList[widget.index]["departure_origin"][0],
          "end": widget.busList[widget.index]["departure_origin"][12],
          "route": widget.busList[widget.index]["route_no"],
          "distance": widget.busList[widget.index]["distance"].toString()
        }
      ]
    }).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('data added successfully')));
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return widget.busList[widget.index]['start']
                .toString()
                .toLowerCase()
                .toLowerCase()
                .contains(widget.start) ||
            widget.busList[widget.index]['end']
                .toString()
                .toLowerCase()
                .contains(widget.end.toLowerCase())
        ? Container(
            height: 150,
            margin: const EdgeInsets.only(left: 18, right: 18, bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.watch_later_outlined,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(widget.busList[widget.index]["departure_origin"]
                                [0] ??
                            ""),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.horizontal_rule_rounded,
                          size: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(widget.busList[widget.index]["departure_origin"]
                                [12] ??
                            ""),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("From : "),
                        SizedBox(
                          width: 10,
                        ),
                        Text(widget.busList[widget.index]["origin"] ?? ""),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("To : "),
                        SizedBox(
                          width: 10,
                        ),
                        Text(widget.busList[widget.index]["destination"] ?? ""),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.directions_bus_filled_outlined,
                                size: 20),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                                widget.busList[widget.index]["route_no"] ?? ""),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.route, size: 20),
                            SizedBox(
                              width: 12,
                            ),
                            Text(widget.busList[widget.index]["distance"]
                                        .toString() +
                                    " KM" ??
                                ""),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      print("clicked");
                      saveToFirebase();
                    },
                    child: Icon(Icons.bookmark_border_outlined))
              ],
            ),
          )
        : Container(
            height: 150,
            margin: const EdgeInsets.only(left: 18, right: 18, bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.watch_later_outlined,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(widget.busList[widget.index]["departure_origin"]
                                [0] ??
                            ""),
                        const SizedBox(
                          width: 10,
                        ),
                        const Icon(
                          Icons.horizontal_rule_rounded,
                          size: 14,
                          color: Colors.grey,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(widget.busList[widget.index]["departure_origin"]
                                [12] ??
                            ""),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("From : "),
                        SizedBox(
                          width: 10,
                        ),
                        Text(widget.busList[widget.index]["origin"] ?? ""),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("To : "),
                        SizedBox(
                          width: 10,
                        ),
                        Text(widget.busList[widget.index]["destination"] ?? ""),
                      ],
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.directions_bus_filled_outlined,
                                size: 20),
                            SizedBox(
                              width: 12,
                            ),
                            Text(
                                widget.busList[widget.index]["route_no"] ?? ""),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.route, size: 20),
                            SizedBox(
                              width: 12,
                            ),
                            Text(widget.busList[widget.index]["distance"]
                                        .toString() +
                                    " KM" ??
                                ""),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      print("click");
                      saveToFirebase();
                    },
                    child: Icon(Icons.bookmark_border_outlined))
              ],
            ),
          );
  }
}
