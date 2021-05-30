import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h4h/component/appbar.dart';
import 'package:h4h/globals.dart' as global;
import 'package:h4h/screen/login.dart';
import 'package:http/http.dart' as http;

class mycart extends StatefulWidget {
  @override
  _mycartState createState() => _mycartState();
}

class _mycartState extends State<mycart> {
  var get_prodlist = "http://admin.happick.in/api/get_cart_products";
  var cart_item = "http://admin.happick.in/api/get_cart_badge_counter";
  var prod_in_cart = "0";
  List data = [];
  var resp;
  var cart_total = "0";
  var in_cart_items = "";
  int len = 0;
  var cart_item_resp;
  var status = "";

  @override
  void initState() {
    super.initState();
    // this.getProductList();
  }

/*
  Future<String> getProductList() async {
    var res = await http.post(Uri.encodeFull(get_prodlist), headers: {
      "Accept": "application/json"
    }, body: {
      "secrete": "dacb465d593bd139a6c28bb7289fa798",
      "user_id": global.user_id,
    });
    //print(res.body);
    setState(() {
      var resp = json.decode(res.body);
      status = resp['status'];
      cart_total = resp['cart_total'];
      //print(cart_total.runtimeType);
      in_cart_items = resp['in_cart_items'];
      var convert = json.decode(res.body)['cart'];
      data = convert;
    });
    var cart_resp = await http.post(Uri.encodeFull(cart_item), headers: {
      "Accept": "application/json"
    }, body: {
      "secrete": "dacb465d593bd139a6c28bb7289fa798",
      "user_id": global.user_id,
    });
    setState(() {
      cart_item_resp = json.decode(cart_resp.body);
      global.in_cart = cart_item_resp['in_cart_items'];
    });
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, "my cart"),
      body: status == "0" ? empty_cart() : response(),
      bottomNavigationBar: status == "0"
          ? BottomAppBar()
          : Container(
              height: 55,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.blue[300],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total: 0",
                      style: TextStyle(color: Colors.white, fontSize: 19),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => login()));
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width * 0.35,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadiusDirectional.circular(20.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Check Out",
                              style: TextStyle(
                                  color: Colors.blue[300],
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.blue[300],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget empty_cart() {
    return Column(
      children: [
        Row(
          children: [
            Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 10),
                child: Text(
                  "My Shopping Bag",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  in_cart_items + " items Added",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        ),
        Image.asset(
          'images/emptycart.png',
          width: 200.0,
          height: 200.0,
        ),
        Center(
          child: Container(
            child: Text(
              "Your Cart is empty!",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 27,
                  color: Colors.black45),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(5),
        ),
        Center(
          child: Container(
            child: Text(
              "You have no items added in the cart",
              style: TextStyle(fontSize: 17, color: Colors.grey),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(25),
        ),
        Center(
          child: FlatButton(
            child: Text(
              "ADD PRODUCTS",
              style: TextStyle(fontSize: 18),
            ),
            color: Color(4278402411),
            textColor: Colors.white,
            disabledColor: Colors.grey,
            disabledTextColor: Colors.black,
            padding: EdgeInsets.only(
                left: 90.0, right: 90.0, bottom: 18.0, top: 18.0),
            splashColor: Colors.transparent,
            onPressed: () {
              /*      Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SidebarMenu()));*/
            },
          ),
        ),
      ],
    );
  }

  Widget response() {
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
      height = deviceHeight * 0.70;
    }
    if (deviceHeight == 1024.0) {
      height = deviceHeight * 0.81;
    }
    if (deviceHeight == 1336.0) {
      height = deviceHeight * 0.85;
    }
    /*print(deviceHeight);
    print(height);*/
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    "My Shopping Bag",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    in_cart_items + " items Added",
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            //height: 580,
            height: height,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: data == null ? 0 : data.length,
              itemBuilder: (context, index) {
                return Container(
                  // padding: EdgeInsets.all(5),
                  margin: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2.0),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: <BoxShadow>[
                              new BoxShadow(
                                color: Colors.black26,
                                blurRadius: 7,
                                // blurRadius: 3.0,
                                offset: new Offset(0.0, 4.0),
                              ),
                            ],
                          ),
                          // color: Colors.white,
                          padding: EdgeInsets.all(3),
                          height: 80,
                          width: 80,
                          child: Image.network(
                            data[index]['image_path'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Container(
                        height: 120,
                        padding: EdgeInsets.all(10),
                        margin: EdgeInsets.only(left: 5),
                        //alignment: Alignment.topLeft,
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                    width: 180.0,
                                    child: Text(
                                      data[index]['product_name'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Quantity : " +
                                    data[index]['quantity'] +
                                    " x " +
                                    data[index]['order_price']),
                                Text(
                                  '                    \u{20B9} ' +
                                      data[index]['product_total_price'],
                                  //"250",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                            ),
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    // color: Color(4278402411),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  width: 25,
                                  height: 25,
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(5.0)),
                                    color: Color(4278402411),
                                    textColor: Colors.white,
                                    disabledColor: Colors.grey,
                                    disabledTextColor: Colors.black,
                                    padding: EdgeInsets.all(5.0),
                                    splashColor: Colors.transparent,
                                    onPressed: () {
                                      print("remove product........");
                                      prod_in_cart = data[index]['quantity'];
                                      //print("cart="+prod_in_cart);
                                      /*    removeProduct(
                                          data[index]['quantity'],
                                          data[index]['product_id'],
                                          data[index]);*/
                                    },
                                    child: Center(
                                      child: Icon(
                                        Icons.remove,
                                        size: 15.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text(
                                    data[index]['quantity'],
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 25,
                                  width: 25,
                                  child: FlatButton(
                                    color: Color(4278402411),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            new BorderRadius.circular(5.0)),
                                    textColor: Colors.white,
                                    disabledColor: Colors.grey,
                                    disabledTextColor: Colors.black,
                                    padding: EdgeInsets.all(5.0),
                                    splashColor: Colors.transparent,
                                    onPressed: () {
                                      print("add product........");
                                      prod_in_cart = data[index]['quantity'];
                                      /*addProduct(
                                          prod_in_cart,
                                          data[index]['product_id'],
                                          data[index]);*/
                                    },
                                    child: Center(
                                      child: Icon(
                                        Icons.add,
                                        size: 15.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /*Future<void> addProduct(qty, prodId, index) async {
    var my_qty = int.parse(qty);
    setState(() {
      for (var i = 0; i < data.length; i++) {
        if (data[i] == index) {
          my_qty++;
          prod_in_cart = my_qty.toString();
          data[i]['quantity'] = prod_in_cart;
        }
      }
    });

    var add_to_cart = "http://admin.happick.in/api/add_to_cart";
    //print("prod_qty = " + qty);

    var res = await http.post(Uri.encodeFull(add_to_cart), headers: {
      "Accept": "application/json"
    }, body: {
      "secrete": "dacb465d593bd139a6c28bb7289fa798",
      "user_id": global.user_id,
      "product_id": prodId,
      "quantity": prod_in_cart,
    });
    var resp = json.decode(res.body);
    if (resp['status'] == "0") {
      getProductList();
    } else {
      getProductList();
    }
    var cart_resp = await http.post(Uri.encodeFull(cart_item), headers: {
      "Accept": "application/json"
    }, body: {
      "secrete": "dacb465d593bd139a6c28bb7289fa798",
      "user_id": global.user_id,
    });
    setState(() {
      cart_item_resp = json.decode(cart_resp.body);
      global.in_cart = cart_item_resp['in_cart_items'];
    });
  }*/

  /* Future<void> removeProduct(qty, prodId, index) async {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Container(
              height: 50,
              width: 50,
              child: CircularProgressIndicator(),
            ),
          );
        });
    var my_qty = int.parse(qty);
    setState(() {
      for (var i = 0; i < data.length; i++) {
        if (data[i] == index) {
          my_qty--;
          if (my_qty < 0) {
            my_qty = 0;
          }
          prod_in_cart = my_qty.toString();
          data[i]['quantity'] = prod_in_cart;
        }
      }
    });

    var add_to_cart = "http://admin.happick.in/api/add_to_cart";

    // ignore: non_constant_identifier_names
    var res = await http.post(Uri.encodeFull(add_to_cart), headers: {
      "Accept": "application/json"
    }, body: {
      "secrete": "dacb465d593bd139a6c28bb7289fa798",
      "user_id": global.user_id,
      "product_id": prodId,
      "quantity": prod_in_cart,
    });
    var resp = json.decode(res.body);

    //getProductList();
    print(resp);
    if (resp['status'] == "1") {
      getProductList();
    }
    Navigator.of(context).pop();
    //print("product_rmv = "+resp['message']);

    var cart_resp = await http.post(Uri.encodeFull(cart_item), headers: {
      "Accept": "application/json"
    }, body: {
      "secrete": "dacb465d593bd139a6c28bb7289fa798",
      "user_id": global.user_id,
    });
    setState(() {
      cart_item_resp = json.decode(cart_resp.body);
      global.in_cart = cart_item_resp['in_cart_items'];
    });
  }*/
}
