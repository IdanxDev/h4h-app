import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import 'package:happick/globals.dart' as global;
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
//import 'package:happick/globals.dart' as global;
import 'dart:convert';

//import './'
class SideMenu extends StatefulWidget {
  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  var _fullname = "";
  void initState() {
    super.initState();
    this.getName();
  }

  @override
  getName() async {
    /* SharedPreferences pref = await SharedPreferences.getInstance();*/
/*    setState(() {
      _fullname = pref.getString("full_name");
    });*/
    print(_fullname);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue[300]),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Icon(
                      Icons.account_circle,
                      size: 90,
                      color: Colors.white,
                    ),
                    height: 85,
                    width: 85,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Sunny",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: Colors.black54,
            ),
            title: Text(
              "Home",
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.account_box,
              color: Colors.black54,
            ),
            title: Text(
              "My Profile",
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              /*    Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyProfile()));*/
            },
          ),
          ListTile(
            leading: Icon(
              Icons.shopping_cart,
              color: Colors.black54,
            ),
            title: Text(
              "My Order",
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              /*     Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyOrders()));*/
            },
          ),
          ListTile(
            leading: Icon(
              Icons.my_location,
              color: Colors.black54,
            ),
            title: Text(
              "My Address",
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              /*    Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MyAddress()));*/
            },
          ),
          ListTile(
            leading: Icon(
              Icons.contact_phone,
              color: Colors.black54,
            ),
            title: Text(
              "Contact",
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              /*   Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ContactUs()));*/
            },
          ),
          ListTile(
            leading: Icon(
              Icons.featured_play_list,
              color: Colors.black54,
            ),
            title: Text(
              "My Subscription",
              style: TextStyle(color: Colors.black),
            ),
            onTap: () {
              /*       Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MySub()));*/
            },
          ),
          //LOGOUT CODE START
          /*ListTile(
            leading: Icon(
              Icons.lock,
              color: Colors.black54,
            ),
            title: Text(
              "Log Out",
              style: TextStyle(color: Colors.black),
            ),
            onTap: () async {
              SharedPreferences pref = await SharedPreferences.getInstance();
              pref.remove('isLoggedIn');
              pref.remove("user_id");
              pref.remove("full_name");
              pref.remove("contact");
              pref.remove("email");
              //_storeLoggedInStatus(true);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => MainLogin()),
                  (route) => false);
            },
            // onTap: ()=>debugPrint("Loged Out"),
          ),*/
          //LOGOUT CODE OVER
          Padding(
            padding: EdgeInsets.only(top: 40, left: 10),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 25),
            title: Text("About"),
            onTap: () {
              /*            Navigator.push(
                  context, MaterialPageRoute(builder: (context) => About()));*/
            },
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 25),
            title: Text("Privacy Policy"),
            onTap: () {
              /*   Navigator.push(context,
                  MaterialPageRoute(builder: (context) => PrivacyPolicy()));*/
            },
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
          ),
          ListTile(
            contentPadding: EdgeInsets.only(left: 25),
            title: Text("Terms & Conditions"),
            onTap: () {
/*              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => TermsCon()));*/
            },
          ),
          Padding(
            padding: EdgeInsets.only(left: 10),
          ),
          /*ListTile(
            contentPadding: EdgeInsets.only(left:25),
            title: Text(
                "Share App"
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => About()));
            },
          ),
          Padding(padding: EdgeInsets.only(left: 10),),
          ListTile(
            contentPadding: EdgeInsets.only(left:25),
            title: Text(
                "Rate App"
            ),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => About()));
            },
          ),*/
        ],
      ),
    );
  }

/*  void _storeLoggedInStatus(bool isLoggedIn) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('isLoggedIn', isLoggedIn);
  }*/

/*  Future<void> getCart() async {
    var cart_item = "http://admin.happick.in/api/get_cart_badge_counter";
    var cart_item_resp;
    var cart_resp = await http.post(Uri.encodeFull(cart_item), headers: {
      "Accept": "application/json"
    }, body: {
      "secrete": "dacb465d593bd139a6c28bb7289fa798",
      "user_id": global.user_id,
    });
    cart_item_resp = json.decode(cart_resp.body);
    global.in_cart = cart_item_resp['in_cart_items'];
  }*/
}
