import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:h4h/Comman/Constants.dart';
import 'package:h4h/Comman/services.dart';
import 'package:h4h/component/appbar.dart';
import 'package:h4h/screen/item.dart';

class subcat extends StatefulWidget {
  String catid, Name;
  subcat({this.catid, this.Name});

  @override
  _subcatState createState() => _subcatState();
}

class _subcatState extends State<subcat> {
  bool isLoading = false;
  List data = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getsubcat();
  }

  getsubcat() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        var body = {"categoryId": widget.catid};

        Services.apiHandler(
                apiName: "admin/getSubCategoryfromCategory", body: body)
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
      appBar: myAppBar(context, widget.Name),
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
                      (MediaQuery.of(context).size.height * 0.80),
                ),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => item(
                                    catid: widget.catid,
                                    subcatid: data[index]["_id"],
                                    name: data[index]["subCategoryName"],
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
                                        image: NetworkImage(image_url +
                                            data[index]["subCategoryImage"]
                                                .toString()),
                                        fit: BoxFit.fill),
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
                              height: 10,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Center(
                                    child:
                                        Text(data[index]["subCategoryName"])),
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
