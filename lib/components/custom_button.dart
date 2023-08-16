import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String btnName;
  final double height;
  final double width;
  const CustomButton(
      {super.key, required this.btnName, this.height = 60, this.width = 300});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height,
        width: width,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Text(btnName.toString(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold))),
      ),
    );
  }
}
