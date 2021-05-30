import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

class OTP extends StatefulWidget {
  String mobileNo, newuser, countrycode;
  Function onSuccess;

  OTP({this.mobileNo, this.onSuccess, this.countrycode});

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  TextEditingController controller = TextEditingController();
  var rndnumber = "";
  bool isLoading = false;
  //ProgressDialog pr;
  String fcmToken = "";
  String error;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool isCodeSent = false;
  String _verificationId;
  @override
  void initState() {
    _onVerifyCode();
  }

  void _onVerifyCode() async {
    setState(() {
      isCodeSent = true;
    });
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _firebaseAuth
          .signInWithCredential(phoneAuthCredential)
          .then((UserCredential value) {
        if (value.user != null) {
          widget.onSuccess();
        } else {
          Fluttertoast.showToast(msg: "Error validating OTP, try again");
        }
      }).catchError((error) {
        Fluttertoast.showToast(msg: "Try again in sometime");
      });
    };
    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException authException) {
      Fluttertoast.showToast(msg: authException.message);
      setState(() {
        isCodeSent = false;
        error = authException.message;
      });
    };

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      _verificationId = verificationId;
      setState(() {
        _verificationId = verificationId;
      });
    };

    // TODO: Change country code

    await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: "${widget.countrycode}${widget.mobileNo}",
        timeout: const Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void _onFormSubmitted() async {
    AuthCredential _authCredential = PhoneAuthProvider.getCredential(
        verificationId: _verificationId, smsCode: controller.text);
    _firebaseAuth
        .signInWithCredential(_authCredential)
        .then((UserCredential value) {
      if (value.user != null) {
        widget.onSuccess();
      } else {
        Fluttertoast.showToast(msg: "Error validating OTP, try again");
      }
    }).catchError((error) {
      Fluttertoast.showToast(msg: "Something went wrong");
    });
  }

  showMsg(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Kolour Box - Error"),
          content: new Text(msg),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(
                "Close",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 10,
              left: 30,
              right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Verification",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 27,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              Text(
                "Enter the code we sent to your Mobile Number:" +
                    widget.mobileNo,
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
              SizedBox(height: 110),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PinInputTextField(
                  pinLength: 6,
                  controller: controller,
                  autoFocus: true,
                  textInputAction: TextInputAction.done,
                  onSubmit: (pin) {
                    if (pin.length == 6) {
                      _onFormSubmitted();
                    } else {
                      Fluttertoast.showToast(msg: "Invalid OTP");
                    }
                  },
                ),
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  margin: EdgeInsets.only(top: 20),
                  height: 45,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        colors: [Colors.blue[300], Colors.blue[300]],
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(6))),
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(10.0)),
                    //color: cnst.appPrimaryMaterialColor1,
                    minWidth: MediaQuery.of(context).size.width - 20,
                    onPressed: () {
                      if (controller.text.length == 6) {
                        _onFormSubmitted();
                      }
                    },
                    child: Text(
                      "Verify",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Didn't get Code? ",
                      style:
                          TextStyle(fontSize: 17, color: Colors.grey.shade600)),
                  InkWell(
                    onTap: () {
                      Fluttertoast.showToast(
                          msg: "OTP Sending",
                          textColor: Colors.white,
                          backgroundColor: Colors.blue);
                      _onVerifyCode();
                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text("RESEND CODE",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.blue[300],
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
