import 'package:flutter/material.dart';

class signup extends StatefulWidget {
  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  final _formKey = GlobalKey<FormState>();
  bool iscustomer = true;
  bool iscontracter = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.10),
              Text(
                "SIGN UP",
                style: TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.10),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Row(children: [
                      Text(
                        "You are a?",
                        style: TextStyle(color: Colors.blue[400]),
                      ),
                    ]),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (iscustomer == true) {
                                iscustomer = false;
                              } else {
                                iscustomer = true;
                              }

                              iscontracter = false;
                            });
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadiusDirectional.circular(10.0)),
                            color: iscustomer == true
                                ? Colors.blue[300]
                                : Colors.white,
                            child: Container(
                                height: 45,
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Center(
                                    child: Text(
                                  "Customer",
                                  style: TextStyle(
                                      color: iscustomer == false
                                          ? Colors.blue[300]
                                          : Colors.white),
                                ))),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              if (iscontracter == true) {
                                iscontracter = false;
                              } else {
                                iscontracter = true;
                              }

                              iscustomer = false;
                            });
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadiusDirectional.circular(10.0)),
                            color: iscontracter == true
                                ? Colors.blue[300]
                                : Colors.white,
                            child: Container(
                                height: 45,
                                width: MediaQuery.of(context).size.width * 0.35,
                                child: Center(
                                    child: Text(
                                  "Contractor",
                                  style: TextStyle(
                                      color: iscontracter == false
                                          ? Colors.blue[300]
                                          : Colors.white),
                                ))),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.015,
                    ),
                    iscontracter == true
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Card(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      size: 40,
                                      color: Colors.blue[300],
                                    ),
                                    items: <String>[
                                      'Kg',
                                      'Litre',
                                      'Meter',
                                      'Ton'
                                    ].map((String value) {
                                      return new DropdownMenuItem<String>(
                                        value: value,
                                        child: new Text(value),
                                      );
                                    }).toList(),
                                    hint: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 55.0,
                                      ),
                                      child: Text(
                                        "Services",
                                        style:
                                            TextStyle(color: Colors.blue[300]),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      /* setState(() {
                                  quantityHintText = value;
                                });*/
                                    },
                                  ),
                                ),
                              ),
                              Card(
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      size: 40,
                                      color: Colors.blue[300],
                                    ),
                                    items: <String>[
                                      '1',
                                      '2',
                                      '3',
                                      '4',
                                      '5',
                                      '6'
                                    ].map((String value) {
                                      return new DropdownMenuItem<String>(
                                        value: value,
                                        child: new Text(value),
                                      );
                                    }).toList(),
                                    hint: Padding(
                                      padding: const EdgeInsets.only(
                                        left: 70.0,
                                      ),
                                      child: Text(
                                        "Areas",
                                        style:
                                            TextStyle(color: Colors.blue[300]),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      /* setState(() {
                                  unitHintText = value;
                                });*/
                                    },
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Container()
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              InkWell(
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    Navigator.pushNamed(context, '/login');
                    print("SIGN UP");
                  }
                },
                child: Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.blue[300],
                      borderRadius: BorderRadiusDirectional.circular(30.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white, fontSize: 19),
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.blue[100],
                            borderRadius:
                                BorderRadiusDirectional.circular(20.0),
                          ),
                          child: Center(
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.blue[300],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
