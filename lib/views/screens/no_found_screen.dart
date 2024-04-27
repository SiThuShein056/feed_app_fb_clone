import 'package:flutter/material.dart';

class NoFoundScreen extends StatelessWidget {
  const NoFoundScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed("/");
            },
            child: Text("Go Home")),
      ),
    );
  }
}
