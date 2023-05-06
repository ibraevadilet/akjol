import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 150,
        width: 150,
        margin: EdgeInsets.only(top: 75),
        child: Image.asset("assets/images/wheel.png"),
      ),
    );
  }
}
