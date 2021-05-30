import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:h4h/screen/Dashboard.dart';
import 'package:h4h/screen/Detail.dart';
import 'package:h4h/screen/Subcat.dart';
import 'package:h4h/screen/item.dart';
import 'package:h4h/screen/login.dart';
import 'package:h4h/screen/mycart.dart';
import 'package:h4h/screen/services.dart';
import 'package:h4h/screen/servicesDetail.dart';
import 'package:h4h/screen/signup.dart';
import 'package:h4h/screen/splash.dart';
import 'package:h4h/screen/viewall.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      initialRoute: '/',
      routes: {
        '/': (context) => splash(),
        '/login': (context) => login(),
        '/signup': (context) => signup(),
        '/dashboard': (context) => dashboard(),
        '/viewall': (context) => viewall(),
        '/services': (context) => services(),
        '/subcat': (context) => subcat(),
        '/item': (context) => item(),
        '/detail': (context) => detail(),
        '/mycart': (context) => mycart(),
        '/servicesDetail': (context) => servicesDetail(),
      },
    );
  }
}
