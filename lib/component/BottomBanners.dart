import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h4h/Comman/Constants.dart';
import 'package:h4h/Comman/services.dart';
import 'package:h4h/screen/item.dart';

class BottomBanners extends StatefulWidget {
  @override
  _BottomBannersState createState() => _BottomBannersState();
}

class _BottomBannersState extends State<BottomBanners> {
  bool isLoading = false;
  List bdata = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getbanner();
  }

  getbanner() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        var body = {};

        Services.apiHandler(apiName: "admin/getAllBanner", body: body)
            .then((responseData) async {
          if (responseData.IsSuccess == true) {
            setState(() {
              bdata = responseData.Data;
              isLoading = false;
              print("123456");
              print(bdata);
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
    return body();
  }

  Widget body() {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: bdata.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) => InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => item(
                              catid: bdata[index]["categoryId"],
                              subcatid: bdata[index]["subCategoryId"],
                              name: bdata[index]["bannerName"],
                            )));
              },
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Card(
                  child: Container(
                    height: 220,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                            image: NetworkImage(
                                image_url + bdata[index]["bannerImage"]),
                            fit: BoxFit.cover)),
                  ),
                ),
              ),
            ));
  }
}
