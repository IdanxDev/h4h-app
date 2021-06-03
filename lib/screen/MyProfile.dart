import 'package:flutter/material.dart';
import 'package:h4h/component/appbar.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final contactController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getprofile();
  }

  getprofile() {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(context, "My Profile"),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(5),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "Update Your",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[300]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  "Account",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue[300]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
              ),
              new Image.asset(
                'images/update.jpg',
                width: 290.0,
                height: 290.0,
              ),
              Padding(
                padding: EdgeInsets.only(top: 50),
              ),
              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(18.0)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  counterText: "",
                  hintText: "FULL NAME",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      "images/avatar.png",
                      height: 10,
                      width: 10,
                    ),
                  ),
                ),
                validator: (name) {
                  if (name.length == 0) {
                    return 'Please enter ypur fullname';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              TextFormField(
                maxLength: 10,
                controller: emailController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(18.0)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  counterText: "",
                  hintText: "MOBILE NUMBER",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      "images/phone-call.png",
                      height: 10,
                      width: 10,
                    ),
                  ),
                ),
                validator: (phone) {
                  Pattern pattern = r'(^(?:[+0]9)?[0-9]{10,}$)';
                  RegExp regExp = new RegExp(pattern);
                  if (phone.length == 0) {
                    return 'Please enter mobile number';
                  } else if (!regExp.hasMatch(phone)) {
                    return 'Please enter mobile number';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              TextFormField(
                controller: contactController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(18.0)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                  counterText: "",
                  hintText: "EMAIL ID",
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.asset(
                      "images/email.png",
                      height: 10,
                      width: 10,
                    ),
                  ),
                ),
                validator: (email) {
                  Pattern pattern =
                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
                  RegExp regExp = new RegExp(pattern);
                  if (email.length == 0) {
                    return 'Please enter Email id';
                  } else if (!regExp.hasMatch(email)) {
                    return 'Please enter correct Email id';
                  }
                  return null;
                },
              ),
              Padding(
                padding: EdgeInsets.all(8),
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                height: 50,
                child: RaisedButton(
                  splashColor: Colors.transparent,
                  onPressed: () {
                    print("hello");
                  },
                  child: new Text(
                    "UPDATE PROFILE",
                    style: TextStyle(color: Colors.white),
                  ),
                  elevation: 0.0,
                  color: Colors.blue[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(7.0),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
