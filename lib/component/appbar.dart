import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart';
import 'package:h4h/screen/Detail.dart';
import 'package:h4h/screen/Search.dart';
import 'package:h4h/screen/mycart.dart';
import 'package:h4h/globals.dart' as global;

AppBar myAppBar(BuildContext context, String appbarname) {
  var firstchar = appbarname[0].toUpperCase();
  var remaincher = appbarname.substring(1);
  print(remaincher);
  var uppercase = firstchar + remaincher;
  print(uppercase);
  print(firstchar.toUpperCase());
  return AppBar(
    backgroundColor: Colors.blue[300],
    //backgroundColor: Color.fromARGB(1, 8, 64, 106),
    title: Text(
      uppercase,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.normal,
        fontSize: 17,
      ),
    ),
    actions: [
      IconButton(
        icon: Icon(
          Icons.notifications_none,
          color: Colors.white,
        ),
      ),
      IconButton(
        icon: Icon(
          Icons.search,
          color: Colors.white,
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => search()));
        },
        /*Toast.show("Coming Soon", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);*/
      ),
      Badge(
        badgeContent: Text(
          global.in_cart.toString(),
          style: TextStyle(color: Colors.white),
        ),
        position: BadgePosition.topEnd(top: 3, end: 5),
        child: IconButton(
          icon: Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
          //onPressed: () => debugPrint("Item Selected")
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => mycart()));
          },
        ),
      )
    ],
  );
}
