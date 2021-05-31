import 'dart:io';

import 'package:flutter/material.dart';
import 'package:h4h/Comman/Constants.dart';
import 'package:h4h/Comman/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h4h/screen/Subcat.dart';

class viewall extends StatefulWidget {
  @override
  _viewallState createState() => _viewallState();
}

class _viewallState extends State<viewall> {
  bool isLoading = false;
  List data = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcategory();
  }

  getcategory() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        var body = {};

        Services.apiHandler(apiName: "admin/getAllcategory", body: body)
            .then((responseData) async {
          if (responseData.IsSuccess == true) {
            setState(() {
              data = responseData.Data;
              isLoading = false;
              print("123456");
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
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
        centerTitle: true,
        title: Text(
          "Category",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              child: GridView.builder(
                physics: BouncingScrollPhysics(),
                primary: false,
                shrinkWrap: true,
                padding: EdgeInsets.all(10),
                itemCount: data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  childAspectRatio: MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.height * 0.75),
                ),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => subcat(
                                    catid: data[index]["_id"],
                                    Name: data[index]["categoryName"],
                                  )));
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            GestureDetector(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.15,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            data[index]["categoryImage"] != null
                                                ? NetworkImage(
                                                    image_url +
                                                        data[index]
                                                            ["categoryImage"],
                                                  )
                                                : AssetImage("images/h4hb.png"),
                                        fit: BoxFit.cover),
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.grey[100], width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
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
                              height: 8,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                    child: Text(data[index]["categoryName"]
                                        .toString())),
                              ],
                            ),
                          ],
                        )),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
