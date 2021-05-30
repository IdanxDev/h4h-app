import 'package:flutter/material.dart';
import 'package:h4h/Comman/Constants.dart';
import 'package:h4h/component/appbar.dart';

class detail extends StatefulWidget {
  var data;
  detail({this.data});
  @override
  _detailState createState() => _detailState();
}

class _detailState extends State<detail> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, "Product Detail"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(image_url + widget.data["itemImage"]),
                      fit: BoxFit.fill),
                  color: Colors.green,
                  borderRadius: BorderRadiusDirectional.circular(10.0)),
            ),
          ],
        ),
      ),
    );
  }
}
