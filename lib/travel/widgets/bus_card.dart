import 'package:flutter/material.dart';

class BusCard extends StatelessWidget {
  final List busList;
  final int index;
  const BusCard({
    Key? key,
    required this.busList,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  Text(busList[index]["start"] ?? ""),
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
                  Text(busList[index]["end"] ?? ""),
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
                  Text(busList[index]["from"] ?? ""),
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
                  Text(busList[index]["to"] ?? ""),
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
                      Icon(Icons.directions_bus_filled_outlined, size: 20),
                      SizedBox(
                        width: 12,
                      ),
                      Text(busList[index]["route"] ?? ""),
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
                      Text(busList[index]["distance"].toString() + " KM" ?? ""),
                    ],
                  ),
                ],
              ),
            ],
          ),
          ElevatedButton(
              onPressed: () {}, child: Icon(Icons.bookmark_border_outlined))
        ],
      ),
    );
  }
}
