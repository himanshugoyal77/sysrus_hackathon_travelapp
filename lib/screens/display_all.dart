// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_assignment/screens/home_screen.dart';

// import '../components/signout_screen.dart';

// class Display extends StatelessWidget {
//   final User? user;
//   const Display({super.key, this.user});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       drawer: Drawer(),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
//         child: Column(
//           children: [
//             StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection("userInfo")
//                   .doc(user!.uid)
//                   .snapshots(),
//               builder: (BuildContext context, AsyncSnapshot snapshot) {
//                 if (snapshot.hasError) return Text('Error = ${snapshot.error}');

//                 if (snapshot.hasData) {
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 20, vertical: 18),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const Text("Your Login Information",
//                             style: TextStyle(
//                                 fontSize: 24, fontWeight: FontWeight.bold)),
//                         Container(
//                           height: 120,
//                           width: 120,
//                           decoration: BoxDecoration(
//                               borderRadius:
//                                   BorderRadiusDirectional.circular(20),
//                               image: DecorationImage(
//                                   image: NetworkImage(
//                                       snapshot.data!["imageUrl"] ?? ""))),
//                         ),
//                         const SizedBox(
//                           height: 18,
//                         ),
//                         const Text("Name :",
//                             style: TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold)),
//                         Text(snapshot.data!["name"] ?? ""),
//                         const SizedBox(
//                           height: 18,
//                         ),
//                         const Text("Email :",
//                             style: TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold)),
//                         Text(snapshot.data!["email"] ?? ""),
//                         const SizedBox(
//                           height: 18,
//                         ),
//                         const Text("Phone no :",
//                             style: TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold)),
//                         Text(snapshot.data!["Phone"] ?? ""),
//                         const SizedBox(
//                           height: 18,
//                         ),
//                         const Text("Age :",
//                             style: TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold)),
//                         Text(snapshot.data!["age"] ?? ""),
//                         const SizedBox(height: 18),
//                         const Text("Address :",
//                             style: TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold)),
//                         Text(snapshot.data!["address"] ?? ""),
//                         const SizedBox(height: 18),
//                         SignOutScreen()
//                       ],
//                     ),
//                   );
//                 }
//                 return const Center(
//                   child: CircularProgressIndicator(),
//                 );
//               },
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("Delete Info from firebase"),
//                 IconButton(
//                     onPressed: () {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                             builder: (ctx) => HomeScreen(user: user)),
//                       );
//                       FirebaseFirestore.instance
//                           .collection("userInfo")
//                           .doc(user!.uid)
//                           .delete();
//                     },
//                     icon: const Icon(
//                       Icons.delete,
//                       size: 28,
//                       color: Colors.red,
//                     )),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
