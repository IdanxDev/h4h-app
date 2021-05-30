import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h4h/screen/OTP.dart';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_number/mobile_number.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'mycart.dart';

class login extends StatefulWidget {
  @override
  _loginState createState() => _loginState();
}

class _loginState extends State<login> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController txtMobileNumber = TextEditingController();
  String _mobileNumber = '', country_code = "+91";
  List<SimCard> _simCard = <SimCard>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MobileNumber.listenPhonePermission((isPermissionGranted) {
      if (isPermissionGranted) {
        initMobileNumberState();
      } else {}
    });

    initMobileNumberState();
  }

  Future<void> initMobileNumberState() async {
    if (!await MobileNumber.hasPhonePermission) {
      await MobileNumber.requestPhonePermission;
      return;
    }
    String mobileNumber = '';
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      mobileNumber = (await MobileNumber.mobileNumber);
      _simCard = (await MobileNumber.getSimCards);
    } on PlatformException catch (e) {
      debugPrint("Failed to get mobile number because of '${e.message}'");
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _mobileNumber = mobileNumber;
      print(_mobileNumber);
    });
  }

  Widget fillCards() {
    List<Widget> widgets = _simCard
        .map((SimCard sim) => Text(
            'Sim Card Number: (${sim.countryPhonePrefix}) - ${sim.number}\nCarrier Name: ${sim.carrierName}\nCountry Iso: ${sim.countryIso}\nDisplay Name: ${sim.displayName}\nSim Slot Index: ${sim.slotIndex}\n\n'))
        .toList();
    return Column(children: widgets);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "SIGN IN",
                style: TextStyle(
                    color: Colors.black45,
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.10),
              Form(
                key: _formKey,
                child: Center(
                  child: TextFormField(
                    maxLength: 10,
                    controller: txtMobileNumber,
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
                      /*prefixIcon: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Image.asset(
                          "images/phone-call.png",
                          height: 10,
                          width: 10,
                        ),
                      ),*/
                      prefixIcon: CountryCodePicker(
                        onChanged: (c) {
                          country_code = c.toString();
                        },
                        initialSelection: 'IN',
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                        /* alignLeft: true,
                        showFlag: false,*/
                        favorite: ['+91', 'IN'],
                      ),
                    ),
                    validator: (phone) {
                      Pattern pattern = r'(^(?:[+0]9)?[0-9]{10,}$)';
                      RegExp regExp = new RegExp(pattern);
                      if (phone.length == 0) {
                        return 'Please enter mobile number';
                        Fluttertoast.showToast(
                            msg: "Please enter mobile number",
                            backgroundColor: Colors.red,
                            gravity: ToastGravity.TOP);
                      } else if (!regExp.hasMatch(phone)) {
                        return 'Please enter mobile number';
                        Fluttertoast.showToast(
                            msg: "Please enter valid mobile number",
                            backgroundColor: Colors.red,
                            gravity: ToastGravity.TOP);
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
              ),
              InkWell(
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    print("Next");
                  }
                },
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OTP(
                                  mobileNo: txtMobileNumber.text,
                                  countrycode: country_code,
                                  onSuccess: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => mycart()));
                                  },
                                )));
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
                            "Login",
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
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.025,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?   "),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/signup');
                      print("SIGN UP");
                    },
                    child: Text(
                      "SIGN UP",
                      style: TextStyle(color: Colors.blue[300]),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
