import 'package:flutter/material.dart';
import 'package:h4h/component/appbar.dart';

import 'add_address.dart';

class MyAddress extends StatefulWidget {
  @override
  _MyAddressState createState() => _MyAddressState();
}

class _MyAddressState extends State<MyAddress> {
  List data = [
    {"address": "b-5254, gajanand soc. near rander chowk , surat 395010"},
    {"address": "thyagyu thagu"}
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, "My Address"),
      body: My_Address(),
    );
  }

  Widget My_Address() {
    double deviceHeight = MediaQuery.of(context).size.height;
    double height;
    if (deviceHeight == 568.0) {
      height = deviceHeight * 0.66;
    }
    if (deviceHeight == 645.0) {
      height = deviceHeight * 0.70;
    }
    if (deviceHeight == 812.0) {
      height = deviceHeight * 0.69;
    }
    if (deviceHeight == 896.0) {
      height = deviceHeight * 0.80;
    }
    if (deviceHeight == 1024.0) {
      height = deviceHeight * 0.81;
    }
    if (deviceHeight == 1336.0) {
      height = deviceHeight * 0.85;
    }
    print(deviceHeight);
    print(height);

    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          TextButton(
            onPressed: () {
               Navigator.push(
              context, MaterialPageRoute(builder: (context) => addaddress()));
            },
            child: Row(
              children: [
                Icon(
                  Icons.add_box_rounded,
                  size: 30,
                  color: Colors.blue[300],
                ),
                SizedBox(width: 8),
                Text(
                  "Add New Address",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.blue[300]),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            margin: EdgeInsets.only(top: 10),
            height: height,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 80,
                  color: Colors.white,
                  // padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Container(
                            child: Text(
                              data[index]['address'],
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Container(
                          child: IconButton(
                            icon: Icon(
                              Icons.delete_forever,
                              color: Colors.blueAccent,
                            ),
                            onPressed: () {
                              print("delete");

                              /*Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => CartPage()));*/
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    Divider(
                      color: Colors.grey,
                    ),
                    
                  ]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
