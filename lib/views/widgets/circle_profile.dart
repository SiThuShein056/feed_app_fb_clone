import 'package:flutter/material.dart';

class CircleProfile extends StatelessWidget {
  final String name;
  final double radius;
  const CircleProfile({
    super.key,
    this.name = "A",
    this.radius = 17,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      child: Text(
        name,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
