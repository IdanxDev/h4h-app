import 'package:flutter/material.dart';
import 'package:h4h/Comman/Constants.dart';
import 'package:h4h/component/appbar.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class servicesDetail extends StatefulWidget {
  String servicesname;
  servicesDetail({this.servicesname});
  @override
  _servicesDetailState createState() => _servicesDetailState();
}

class _servicesDetailState extends State<servicesDetail> {
  String unitHintText = "Select Area";
  String ratt;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, widget.servicesname),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.025,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  side: new BorderSide(color: Colors.blue[300], width: 1.0),
                  borderRadius: BorderRadius.circular(15.0)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    size: 40,
                    color: Colors.blue[300],
                  ),
                  items: <String>[
                    "Katargam",
                    "Varachha",
                    "Althan",
                    "Pandesara",
                    "Dindoli",
                    "Dabholi",
                    "Bhatar",
                    "vesu"
                  ].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  hint: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.80,
                    child: Center(
                      child: Text(
                        unitHintText,
                        style: TextStyle(color: Colors.black45),
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      unitHintText = value;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) => InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/detail');
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Card(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(15.0),
                                color: Colors.white,
                              ),
                              height: 160,
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 120,
                                      width: 120,
                                      decoration: BoxDecoration(
                                          color: Colors.grey,
                                          image: DecorationImage(
                                              image:
                                                  /* data[index]["itemImage"] ==
                                                null
                                                ?*/
                                                  AssetImage(
                                                      "images/h4hblk.png"),
                                              /*  : NetworkImage(image_url +
                                                data[index]["itemImage"]),*/
                                              fit: BoxFit.fill),
                                          borderRadius:
                                              BorderRadiusDirectional.circular(
                                                  60.0)),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Sohil Construction",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: TextStyle(
                                              color: Colors.blue[300],
                                              fontSize: 18),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        RatingBar.builder(
                                          initialRating: 2.5,
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 25,
                                          glow: false,
                                          itemPadding: EdgeInsets.symmetric(
                                              horizontal: 3.0),
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            var rat = rating;
                                            ratt = rat.toString();
                                          },
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                image: AssetImage(
                                                    "images/whatsapp.png"),
                                              )),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                image: AssetImage(
                                                    "images/telephone.png"),
                                              )),
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
                                            Container(
                                              height: 40,
                                              width: 40,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                image: AssetImage(
                                                    "images/chat.png"),
                                              )),
                                            ),
                                          ],
                                        )
                                      ],
                                    )
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
      ),
    );
  }
}
