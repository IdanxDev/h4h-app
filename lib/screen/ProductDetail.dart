import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h4h/Comman/Constants.dart';
import 'package:h4h/component/appbar.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:badges/badges.dart';

class ProductDetail extends StatefulWidget {
  var product;

  ProductDetail({this.product});

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  var get_prod = "http://admin.happick.in/api/get_single_product";
  var related_prod_url = "http://admin.happick.in/api/similar_products";
  var cart_item = "http://admin.happick.in/api/get_cart_badge_counter";

  var prod_name = "";
  var prod_id = "";
  var prod_sell_price = "";
  var prod_desc = "";
  var prod_img = "";
  var prod_img_name = "";
  var prod_in_cart = "";
  var prod_cat_name = "";
  var prod_ingredient_type = "";
  var prod_price = "";
  var prod_offer = "";
  var prod_offer_price = "";
  var prod_include_texes = "";
  var prod_cat_id = "";
  var real_resp;
  var cart_item_resp;
  var discount_per;
  var prod_discount = 0;
  List imagedata = [];
  List slideimage = [];
  @override
  void initState() {
    super.initState();
    setState(() {
      slideimage.add(NetworkImage(image_url + widget.product["itemImage"]));
    });
    print(slideimage);
    print(widget.product["description"]);
    //  slideimage.add(NetworkImage(image_url + widget.product["itemImage"]));
  }
/*
  Future<String> getSingleProd() async {
    var res = await http.post(Uri.encodeFull(get_prod), headers: {
      "Accept": "application/json"
    }, body: {
      "secrete": "dacb465d593bd139a6c28bb7289fa798",
      "product_id": widget.product_id,
      "user_id": global.user_id,
    });

    var related_resp = await http.post(Uri.encodeFull(related_prod_url), headers: {
      "Accept": "application/json"
    }, body: {
      "secrete": "dacb465d593bd139a6c28bb7289fa798",
      "product_id": widget.product_id,
    });
    var cart_resp = await http.post(Uri.encodeFull(cart_item), headers: {
      "Accept": "application/json"
    }, body: {
      "secrete": "dacb465d593bd139a6c28bb7289fa798",
      "user_id": global.user_id,
    });
    //print(res.body);
    setState(() {
      Map data = json.decode(res.body) as Map;
      var resp = json.decode(res.body)['product_image'];
      imagedata=resp;
      print(data);
      prod_name = data['product_name'];
      prod_sell_price = data['sell_price'];
      prod_desc = data['short_desc'];
      prod_img = data['image_path'];
      prod_img_name = resp[0]['product_image'];
      prod_in_cart = data['in_cart'];
      prod_cat_name = data['category_name'];
      prod_ingredient_type = data['ingredient_type'];
      prod_price = data['price'];
      prod_offer = data['show_offer'];
      prod_id = data['product_id'];
      prod_cat_id = data['category_id'];
      discount_per = data['discount_percentage'];
      prod_discount = data['discount_percentage'];
      imagedata.forEach((element) {
        //slideimage.add(prod_img+element['product_image']);
        slideimage.add(NetworkImage(prod_img+element['product_image']));
      });
      var in_cart = int.parse(prod_in_cart);
      if (prod_offer == "true") {
        prod_include_texes = '\u{20B9}' + prod_price;
        prod_offer_price = data['offer_price'];
      } else {
        prod_offer_price = "";
      }
      real_resp = json.decode(related_resp.body)['popular_category'];
      cart_item_resp = json.decode(cart_resp.body);
      global.in_cart = cart_item_resp['in_cart_items'];
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: SideMenu(),
      appBar: myAppBar(context, "Product Detail"),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                color: Colors.white38,
                padding: EdgeInsets.all(10),
                child: discount_per != 0
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(
                            child: Stack(
                              children: [
                                Container(
                                  width: 50.0,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(top: 12, left: 4.0),
                                  child: Text(
                                    prod_discount.toString() + "% ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0),
                                  ),
                                ),
                                Container(
                                  width: 50.0,
                                  alignment: Alignment.center,
                                  margin: EdgeInsets.only(top: 24, left: 4.0),
                                  child: Text(
                                    "OFF",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.80,
                            child: Text(
                              //"asdaa aaaa aaaaaa aaaaaaaa",
                              widget.product["itemName"].toString(),
                              // prod_name,
                              style: TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          ),
                        ],
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width * 0.80,
                        child: Text(
                          //"asdaa aaaa aaaaaa aaaaaaaa",
                          widget.product["itemName"].toString(),
                          // prod_name,
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          softWrap: true,
                        ),
                      ),
              ),
              CarouselSlider(slideimage),
              Container(
                margin: EdgeInsets.only(top: 60),
                padding: EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        prod_offer_price,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.green,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 15),
                        alignment: Alignment.topLeft,
                        child: Row(
                          children: [
                            Text(
                              //"67",
                              '\u{20B9} ',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  // ignore: non_constant_identifier_names
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              widget.product["price"].toString() +
                                  " (Incl. Of All Taxes)",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        )),
                    Container(
                      alignment: Alignment.topLeft,
                      height: 40,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(left: 0, right: 10, top: 10),
                      color: Colors.blue[300],
                      child: Text(
                        "Stay Home Stay Safe",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
                // child: Text('\u{20B9} 30 ',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 30),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2.0),
                  color: Colors.white,
                  // borderRadius: BorderRadius.all(Radius.circular(10.0),),
                  boxShadow: <BoxShadow>[
                    new BoxShadow(
                      color: Colors.black26,
                      blurRadius: 7,
                      // blurRadius: 3.0,
                      offset: new Offset(0.0, 4.0),
                    ),
                  ],
                ),
                padding: EdgeInsets.only(left: 15, top: 10),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Description",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        //"123123asdasd",
                        widget.product["description"].toString(),
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        //"123123asdasd",
                        prod_desc,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10, right: 10, top: 30),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2.0),
                  color: Colors.white,
                  // borderRadius: BorderRadius.all(Radius.circular(10.0),),
                  boxShadow: <BoxShadow>[
                    new BoxShadow(
                      color: Colors.black26,
                      blurRadius: 7,
                      // blurRadius: 3.0,
                      offset: new Offset(0.0, 4.0),
                    ),
                  ],
                ),
                padding: EdgeInsets.only(left: 10, top: 10),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Product Information",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20, right: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Category",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.grey),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                // "asduhasbfihab",
                                prod_cat_name,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.teal),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Ingrediant Type",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.grey),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                // "asiofjnaoijvnzdojv",
                                prod_ingredient_type,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.teal),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 15, left: 10),
                child: Text(
                  "Don't Forget To Add",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              real_resp == null
                  ? Container(
                      height: 40,
                    )
                  : Container(
                      margin: EdgeInsets.only(top: 8.0),
                      height: 230.0,
                      color: Colors.white54,
                      //color: Color.fromRGBO(243, 243, 242, 1),
                      child: RelatedProduct(),
                    ),
            ],
          ),
          new Positioned(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      color: Colors.white,
                      height: 60,
                      // width: 220,
                      padding: EdgeInsets.only(top: 10, left: 5),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Text(
                                      "Shop More And Save More !",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 5),
                              ),
                              Row(
                                textDirection: TextDirection.ltr,
                                children: [
                                  new GestureDetector(
                                    onTap: () {
                                      /*    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AllCatMain(),
                                        ),
                                      );*/
                                    },
                                    child: new Text(
                                      "View All Category >",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      // margin: EdgeInsets.only(left: 10),
                      color: Colors.white,
                      height: 60,
                      width: 115,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              print("remove start");
                              // removeProduct(prod_in_cart);
                            },
                            child: Container(
                              width: 25.0,
                              height: 25.0,
                              decoration: BoxDecoration(
                                color: Colors.blue[300],
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Icon(
                                Icons.remove,
                                size: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              '$prod_in_cart',
                              // "0",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              print("Add Start");
                              // addProduct(prod_in_cart);
                            },
                            child: Container(
                              width: 25.0,
                              height: 25.0,
                              decoration: BoxDecoration(
                                color: Colors.blue[300],
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Icon(
                                Icons.add,
                                size: 20.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget Discount() {
    Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Center(
          child: Stack(
            children: [
              /* Container(
                alignment: Alignment.center,
                child: Image.asset(
                  "images/price_badge.png",
                  width: 55.0,
                  height: 50.0,
                ),
              ),
              Container(
                width: 50.0,
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 12, left: 4.0),
                child: Text(
                  discount_per.toString() + "% ",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0),
                ),
              ),*/
              Container(
                width: 50.0,
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 24, left: 4.0),
                child: Text(
                  "OFF",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12.0),
                ),
              ),
            ],
          ),
        ),
        Text(
          //"asdaa aaaa aaaaaa aaaaaaaa",
          prod_name,
          // prod_name,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  Widget RelatedProduct() {
    var deviceOrientetion = MediaQuery.of(context).orientation;
    var heightx = MediaQuery.of(context).size.width < 570
        ? 170.0
        : MediaQuery.of(context).size.width < 768
            ? 200.0
            : 200.0;
    return Wrap(
      children: [
        Container(
            margin: EdgeInsets.only(top: 15.0),
            height: heightx,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: real_resp == null ? 0 : real_resp.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      /*   Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductDetail(
                                  product_id: real_resp[index]['product_id'])));*/
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 5),
                      width: (deviceOrientetion == Orientation.portrait)
                          ? MediaQuery.of(context).size.width / 2
                          : MediaQuery.of(context).size.width / 4,
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: heightx - 50,
                            margin: EdgeInsets.only(
                              left: 10.0,
                            ),
                            child: Image.network(
                              real_resp[index]['image_path'],
                              height: 100,
                            ),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white, width: 2.0),
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              boxShadow: <BoxShadow>[
                                new BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 3.0,
                                  offset: new Offset(0.0, 3.0),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 3.0),
                            //child:Expanded(
                            alignment: Alignment.center,
                            padding: EdgeInsets.only(right: 10, left: 10),
                            child: Text(
                              real_resp[index]['product_name'],
                              style: TextStyle(
                                color: Colors.black,
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              //textDirection: TextDirection.ltr,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                })),
      ],
    );
  }

  @override
  Widget CarouselSlider(listitem) => SizedBox(
        height: 360.0,
        child: Carousel(
          boxFit: BoxFit.fill,
          images: listitem,
          autoplay: false,
          showIndicator: true,
          dotBgColor: Colors.transparent,
          dotSize: 5,
          dotColor: Color(4278402411),
          dotIncreasedColor: Color((4278402411)),
        ),
      );

  /* Future<void> addProduct(qty) async {
    var add_to_cart = "http://admin.happick.in/api/add_to_cart";
    print(qty);
    setState(() {
      var my_qty = int.parse(qty) + 1;
      prod_in_cart = my_qty.toString();
      print(prod_in_cart);
    });

    var res = await http.post(Uri.encodeFull(add_to_cart), headers: {
      "Accept": "application/json"
    }, body: {
      "secrete": "dacb465d593bd139a6c28bb7289fa798",
      "user_id": global.user_id,
      "product_id": prod_id,
      "quantity": prod_in_cart,
    });
    var resp = json.decode(res.body);
    print(resp);
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
  /* Future<void> removeProduct(qty) async {
    var add_to_cart = "http://admin.happick.in/api/add_to_cart";
    print(qty);
    setState(() {
      var my_qty = int.parse(qty) - 1;
      if (my_qty < 0) {
        my_qty = 0;
        prod_in_cart = my_qty.toString();
      } else {
        prod_in_cart = my_qty.toString();
      }
      print(prod_in_cart);
    });

    var res = await http.post(Uri.encodeFull(add_to_cart), headers: {
      "Accept": "application/json"
    }, body: {
      "secrete": "dacb465d593bd139a6c28bb7289fa798",
      "user_id": global.user_id,
      "product_id": prod_id,
      "quantity": prod_in_cart,
    });
    var resp = json.decode(res.body);
    print(resp);
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
