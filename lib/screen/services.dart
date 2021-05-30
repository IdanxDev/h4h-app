import 'dart:io';

import 'package:flutter/material.dart';
import 'package:h4h/Comman/services.dart';
import 'package:h4h/component/appbar.dart';
import 'package:h4h/screen/servicesDetail.dart';
import 'package:h4h/screen/signup.dart';
import 'package:fluttertoast/fluttertoast.dart';

class services extends StatefulWidget {
  @override
  _servicesState createState() => _servicesState();
}

class _servicesState extends State<services> {
  String unitHintText = "Select Area";
  bool isLoading = false;
  List data = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getservices();
  }

  getservices() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        var body = {};

        Services.apiHandler(apiName: "admin/getAllService", body: body)
            .then((responseData) async {
          if (responseData.IsSuccess == true) {
            setState(() {
              data = responseData.Data;
              isLoading = false;
              print(data);
            });
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
      appBar: myAppBar(context, "Services"),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            GridView.builder(
              physics: BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              itemCount: data.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                mainAxisSpacing: 1,
                crossAxisSpacing: 1,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height * 0.95),
              ),
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => servicesDetail(
                                  servicesname: data[index]["serviceName"],
                                )));
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: [
                          GestureDetector(
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.10,
                              width: MediaQuery.of(context).size.width * 0.18,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage("images/h4hblk.png"),
                                      fit: BoxFit.cover),
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Colors.grey[100], width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0)),
                                  boxShadow: [
                                    BoxShadow(
                                        color:
                                            Colors.grey[400].withOpacity(0.2),
                                        blurRadius: 1.0,
                                        spreadRadius: 1.0,
                                        offset: Offset(3.0, 5.0))
                                  ]),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                  child: Text(
                                      data[index]["serviceName"].toString())),
                            ],
                          ),
                        ],
                      )),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
