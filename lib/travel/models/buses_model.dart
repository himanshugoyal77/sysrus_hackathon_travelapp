// /// To parse this JSON data, do
// //
// //     final busesModel = busesModelFromJson(jsonString);

// import 'dart:convert';

// BusesModel busesModelFromJson(String str) => BusesModel.fromJson(json.decode(str));

// String busesModelToJson(BusesModel data) => json.encode(data.toJson());

// class BusesModel {
//     BusesModel({
//         required this.id,
//         required this.routeNo,
//         required this.origin,
//         required this.destination,
//         required this.distance,
//         required this.departureOrigin,
//         required this.v,
//     });

//     String id;
//     String routeNo;
//     String origin;
//     String destination;
//     String distance;
//     List<String> departureOrigin;
//     int v;

//     factory BusesModel.fromJson(Map<String, dynamic> json) => BusesModel(
//         id: json["_id"],
//         routeNo: DateTime.parse(json["route_no"]),
//         origin: json["origin"],
//         destination: json["destination"],
//         distance: DateTime.parse(json["distance"]),
//         departureOrigin: List<String>.from(json["departure_origin"].map((x) => x)),
//         v: json["__v"],
//     );

//     Map<String, dynamic> toJson() => {
//         "_id": id,
//         "route_no": routeNo.toIso8601String(),
//         "origin": origin,
//         "destination": destination,
//         "distance": distance.toIso8601String(),
//         "departure_origin": List<dynamic>.from(departureOrigin.map((x) => x)),
//         "__v": v,
//     };
// // }
