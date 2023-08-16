// import 'dart:convert';

// import 'package:flutter_assignment/travel/models/buses_model.dart';
// import 'package:http/http.dart' as http;

// class ApiController {
//   static Future<List<BusesModel>> getBusesdata() async {
//     List<BusesModel> coinList = [];
//     var url = Uri.parse(
//         "https://buses-data-production-b877.up.railway.app/api/products");
//     final response = await http.get(url);
//     print("lemon");
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body)["myData"];
//       for (var d in data) {
//         coinList.add(BusesModel.fromJson(d));
//       }
//     }
//     return coinList;
//   }
// }
