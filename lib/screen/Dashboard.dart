import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:h4h/Comman/Constants.dart';
import 'package:h4h/Comman/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:h4h/component/BottomBanners.dart';
import 'package:h4h/component/LoadingComponent.dart';
import 'package:h4h/component/appbar.dart';
import 'package:h4h/screen/Detail.dart';
import 'package:h4h/screen/SideMenu.dart';
import 'package:h4h/screen/Subcat.dart';
import 'package:h4h/screen/item.dart';

class dashboard extends StatefulWidget {
  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  bool isLoading = false;
  List data = [];
  List bdata = [];
  List mdata = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcategory();
    getbanner();
    mostpopular();
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

  mostpopular() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        var body = {};

        Services.apiHandler(apiName: "admin/getPopularItem", body: body)
            .then((responseData) async {
          if (responseData.IsSuccess == true) {
            setState(() {
              mdata = responseData.Data;
              isLoading = false;
              print("123456");
              print(mdata);
            });
          }
        });
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(msg: "No Internet Connection");
    }
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
      appBar: myAppBar(context, "Hardware 4 Home"),
      drawer: SideMenu(),
      body: isLoading == true
          ? LoadingComponent()
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width * 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CarouselSlider(
                              options: CarouselOptions(
                                viewportFraction: 1,
                                autoPlayAnimationDuration:
                                    Duration(milliseconds: 1500),
                                height: 170.0,
                                enlargeCenterPage: false,
                                autoPlay: true,
                                disableCenter: true,
                                initialPage: 0,
                                reverse: false,
                              ),
                              items: bdata.map((i) {
                                return new Builder(
                                  builder: (BuildContext context) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => item(
                                                      catid:
                                                          "${i["categoryId"]}",
                                                      subcatid:
                                                          "${i["subCategoryId"]}",
                                                      name:
                                                          "${i["bannerName"]}",
                                                    )));
                                      },
                                      child: new Container(
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                              image_url + "${i["bannerImage"]}",
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: new EdgeInsets.only(
                                          left: 2.0,
                                        ),
                                        /* child: new Image.network("${i["bannerImage"]}",
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width)*/
                                      ),
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/services');
                          },
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 1,
                            decoration: BoxDecoration(
                                color: Colors.blue[300],
                                borderRadius:
                                    BorderRadiusDirectional.circular(10.0)),
                            child: Center(
                              child: Text(
                                "Services",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 19),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          height: 500,
                          width: MediaQuery.of(context).size.width * 1,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Category",
                                        style: TextStyle(
                                            color: Colors.black45,
                                            fontSize: 16),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pushNamed(
                                              context, '/viewall');
                                        },
                                        child: Text(
                                          "View All",
                                          style: TextStyle(
                                              color: Colors.blue[300],
                                              fontSize: 16),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        padding: EdgeInsets.all(10),
                                        itemCount: 9,
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          mainAxisSpacing: 3,
                                          crossAxisSpacing: 3,
                                          childAspectRatio:
                                              MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.80),
                                        ),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          subcat(
                                                            catid: data[index]
                                                                ["_id"],
                                                            Name: data[index][
                                                                "categoryName"],
                                                          )));
                                            },
                                            child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0.5,
                                                    right: 0.5,
                                                    top: 0.5),
                                                child: Column(
                                                  children: [
                                                    GestureDetector(
                                                      child: Container(
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.15,
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        decoration:
                                                            BoxDecoration(
                                                                image:
                                                                    DecorationImage(
                                                                        image: data[index]["categoryImage"] !=
                                                                                null
                                                                            ? NetworkImage(
                                                                                image_url + data[index]["categoryImage"],
                                                                              )
                                                                            : AssetImage(
                                                                                "images/h4hb.png"),
                                                                        fit: BoxFit
                                                                            .cover),
                                                                color: Colors
                                                                    .white,
                                                                border: Border.all(
                                                                    color: Colors
                                                                            .grey[
                                                                        100],
                                                                    width: 1),
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10.0)),
                                                                boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                      .grey[400]
                                                                      .withOpacity(
                                                                          0.2),
                                                                  blurRadius:
                                                                      1.0,
                                                                  spreadRadius:
                                                                      1.0,
                                                                  offset:
                                                                      Offset(
                                                                          3.0,
                                                                          5.0))
                                                            ]),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 8,
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Center(
                                                            child: Text(data[
                                                                        index][
                                                                    "categoryName"]
                                                                .toString())),
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 220,
                          width: MediaQuery.of(context).size.width,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Most populer",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Container(
                                      child: ListView.builder(
                                          itemCount: mdata.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (BuildContext context,
                                                  int index) =>
                                              InkWell(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              detail(
                                                                data: mdata[
                                                                    index],
                                                              )));
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(9.0),
                                                  child: Column(
                                                    children: [
                                                      Card(
                                                        elevation: 3,
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10.0),
                                                        ),
                                                        color: Colors.white,
                                                        child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  9.0),
                                                          height: 110,
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.30,
                                                          decoration:
                                                              BoxDecoration(
                                                            image:
                                                                DecorationImage(
                                                                    image: mdata[index]["itemImage"] !=
                                                                            null
                                                                        ? NetworkImage(
                                                                            image_url +
                                                                                mdata[index]["itemImage"],
                                                                          )
                                                                        : AssetImage(
                                                                            "images/h4hb.png"),
                                                                    fit: BoxFit
                                                                        .cover),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Container(
                                                        height: 25,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.32,
                                                        child: Text(
                                                          mdata[index]
                                                                  ["itemName"]
                                                              .toString(),
                                                          textAlign:
                                                              TextAlign.center,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          softWrap: true,
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 8.0),
                      // height: height,
                      color: Colors.white,
                      child: BottomBanners(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
