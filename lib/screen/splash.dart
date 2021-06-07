import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h4h/Comman/Constants.dart';
import 'package:h4h/Comman/services.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:h4h/globals.dart' as global;

class splash extends StatefulWidget {
  @override
  _splashState createState() => _splashState();
}

class _splashState extends State<splash> {
  var data;
  bool isLoading = false;
  var fcmtoken;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getfcmtoken();
  }

  getfcmtoken() async {
    await _firebaseMessaging.getToken().then((token) {
      print(token);
      setState(() {
        fcmtoken = token;
      });
    });
    fcmlogin();
  }

  fcmlogin() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        var body = {"fcmToken": fcmtoken};
        print(body);
        Services.apiHandler(apiName: "user/addfcmToken", body: body)
            .then((responseData) async {
          if (responseData.IsSuccess == true) {
            setState(() {
              data = responseData.Data;
              isLoading = false;
              print("123456");
              print(data);
            });
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString(Session.id, data[0]["_id"].toString());
            print(prefs.getString(Session.id));

            setState(() {
              global.user_id = prefs.getString(Session.id);
              print("GLOBAL USER ID = " + global.user_id);
            });
            await getCartTotalItems();


            Timer(Duration(seconds: 5), () async {
              Navigator.pushReplacementNamed(context, '/dashboard');
            });
          }
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection");
    }
  }
  getCartTotalItems() async {
    try {
      print("Get Cart User ID = "+global.user_id.toString());
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        var body = {"userId":global.user_id};

        Services.apiHandler(apiName: "order/userCartCount", body: body)
            .then((responseData) async {
          if (responseData.IsSuccess == true) {
            var incart = responseData.Data;
            print("GLOBAL ======");
            print(incart);
            /*if(incart.length <= 0){
              incart = "0";
              print("in_cart === "+ incart.toString());
            }else{
              incart = incart;
              print("in_cart === "+ incart.toString());
            }*/
            setState(() {
              global.in_cart = incart.toString();
            });
            print("In Cart = " + incart.toString());
          }
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection");
    }
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
