import 'dart:async';

import 'package:flutter/material.dart';

class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  @override
  void initState() {
    Timer(Duration(seconds: 5), () async {
      Navigator.pushReplacementNamed(context, '/dashboard');
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "H4H",
              style: TextStyle(color: Colors.blue, fontSize: 40),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Hardware For Home",
              style: TextStyle(color: Colors.deepPurpleAccent, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
