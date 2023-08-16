import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assignment/screens/info_screen.dart';
import 'package:flutter_assignment/screens/login_screen.dart';
import 'package:flutter_assignment/travel/screens/bus_details.dart';
import 'package:flutter_assignment/travel/screens/directions.dart';
import 'package:flutter_assignment/travel/screens/home_page.dart';
import 'package:flutter_assignment/travel/screens/maps.dart';

class BottomNavigationComponent extends StatefulWidget {
  const BottomNavigationComponent({super.key});

  @override
  State<BottomNavigationComponent> createState() =>
      _BottomNavigationComponentState();
}

class _BottomNavigationComponentState extends State<BottomNavigationComponent> {
  List<Widget> screens = [const HomePage(), DirectionsPage(), MapsPage()];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.white,
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: 'Home',
            backgroundColor: Colors.black),
        BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.location_fill,
              color: Colors.black,
            ),
            label: 'direaction',
            backgroundColor: Colors.black),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.supervised_user_circle_sharp,
              color: Colors.black,
            ),
            label: 'Profile',
            backgroundColor: Colors.black),
      ], iconSize: 26, onTap: _onItemTapped, elevation: 5),
    );
  }
}
