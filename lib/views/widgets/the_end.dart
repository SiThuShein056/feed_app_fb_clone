import 'package:flutter/material.dart';

class TheEnd extends StatelessWidget {
  const TheEnd({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Row(
        children: [
          Expanded(
              child: Divider(
            height: 1,
            color: Colors.white60,
          )),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text("End"),
          ),
          Expanded(
              child: Divider(
            height: 1,
            color: Colors.white60,
          )),
        ],
      ),
    );
  }
}
