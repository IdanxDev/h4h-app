import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:h4h/Comman/Constants.dart';
import 'package:h4h/Comman/services.dart';
import 'package:h4h/component/appbar.dart';
import 'package:h4h/screen/Detail.dart';
import 'package:badges/badges.dart';
import 'package:h4h/screen/ProductDetail.dart';

class item extends StatefulWidget {
  String catid, subcatid, name;
  item({this.catid, this.subcatid, this.name});
  @override
  _itemState createState() => _itemState();
}

class _itemState extends State<item> {
  bool isLoading = false;
  List data = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getitem();
  }

  getitem() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        var body = {
          "categoryId": widget.catid,
          "subCategoryId": widget.subcatid,
        };

        Services.apiHandler(apiName: "admin/getItemOfCategory", body: body)
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
      appBar: myAppBar(context, widget.name),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
                itemCount: data.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) => InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductDetail(
                                      product: data[index],
                                    )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Card(
                          elevation: 3.0,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadiusDirectional.circular(10.0)),
                          child: Container(
                            height: 160,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Container(
                                    width: 130,
                                    decoration: BoxDecoration(
                                        color: Colors.grey,
                                        image: DecorationImage(
                                            image: data[index]["itemImage"] ==
                                                    null
                                                ? AssetImage(
                                                    "images/h4hblk.png")
                                                : NetworkImage(image_url +
                                                    data[index]["itemImage"]),
                                            fit: BoxFit.fill),
                                        borderRadius:
                                            BorderRadiusDirectional.circular(
                                                10.0)),
                                  ),
                                  SizedBox(
                                    width: 20.0,
                                  ),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.50,
                                            child: Text(
                                              data[index]["itemName"]
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.blue[300],
                                                fontSize: 18,
                                              ),
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 2,
                                            ),
                                          ),
                                          Text(
                                            data[index]["volumeId"][0]
                                                    ["volumeName"]
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.blue[300],
                                                fontSize: 15),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '\u{20B9}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            data[index]["price"].toString(),
                                            style: TextStyle(
                                                color: Colors.black45,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  height: 30,
                                                  width: 40,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadiusDirectional
                                                            .only(
                                                                topStart: Radius
                                                                    .circular(
                                                                        8.0),
                                                                bottomStart: Radius
                                                                    .circular(
                                                                        8.0)),
                                                    color: Colors.blue[300],
                                                  ),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.remove,
                                                      color: Colors.white,
                                                      size: 20.0,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: 30,
                                                width: 40,
                                                color: Colors.blue[100],
                                                child: Center(
                                                    child: Text(
                                                  "00",
                                                  style: TextStyle(
                                                      color: Colors.black45),
                                                )),
                                              ),
                                              InkWell(
                                                onTap: () {},
                                                child: Container(
                                                  height: 30,
                                                  width: 40,
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                      size: 20.0,
                                                    ),
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadiusDirectional
                                                            .only(
                                                                topEnd: Radius
                                                                    .circular(
                                                                        10.0),
                                                                bottomEnd: Radius
                                                                    .circular(
                                                                        10.0)),
                                                    color: Colors.blue[300],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    )),
          ),
        ],
      ),
    );
  }
}
