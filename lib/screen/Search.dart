import 'dart:io';
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:h4h/Comman/Constants.dart';
import 'package:h4h/Comman/services.dart';
import 'package:h4h/component/appbar.dart';
import 'package:h4h/screen/Detail.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_recognition_result.dart';

class search extends StatefulWidget {
  @override
  _searchState createState() => _searchState();
}

class _searchState extends State<search> {
  final globalKey = new GlobalKey<ScaffoldState>();
  final TextEditingController _controller = new TextEditingController();
  bool isLoading = false;
  List data = [];
  List _list = [];
  List searchresult = [];
  bool _hasSpeech = false;
  bool search = false;
  bool ifspeech = false;
  double level = 0.0;
  String _currentLocaleId = '';
  double minSoundLevel = 50000;
  double maxSoundLevel = -50000;
  String lastStatus = '';
  String lastWords = '';
  String lastError = '';
  int resultListened = 0;
  List<LocaleName> _localeNames = [];
  final SpeechToText speech = SpeechToText();
  bool _isSearching;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getallitem();
    initSpeechState();
  }

  getallitem() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          isLoading = true;
        });
        var body = {};

        Services.apiHandler(apiName: "admin/getAllItem", body: body)
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

  void searchOperation(String searchText) {
    searchresult.clear();
    if (searchText != "") {
      for (int i = 0; i < data.length; i++) {
        String data1 = data[i]["itemName"];
        if (data[i]["itemName"]
            .toLowerCase()
            .contains(searchText.toLowerCase())) {
          setState(() {
            searchresult.add(data[i]);
          });
        }
      }
      print(searchresult);
    }
  }

  Future<void> initSpeechState() async {
    var hasSpeech = await speech.initialize(
        onError: errorListener,
        onStatus: statusListener,
        debugLogging: true,
        finalTimeout: Duration(milliseconds: 0));
    if (hasSpeech) {
      _localeNames = await speech.locales();
      var systemLocale = await speech.systemLocale();
      _currentLocaleId = systemLocale.localeId;
    }

    if (!mounted) return;
    setState(() {
      _hasSpeech = hasSpeech;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, "Hardware 4 Home"),
      body: Column(
        children: [
          Container(
            color: Colors.blue[300],
            child: new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Card(
                child: new ListTile(
                  leading: new InkWell(
                    onTap: () {
                      setState(() {});
                      print("hellooooooo");
                      if (!_hasSpeech || speech.isListening) {
                      } else {
                        print("helloo");
                        search = true;
                        startListening();
                        setState(() {
                          ifspeech = true;
                        });
                      }
                    },
                    child: Icon(
                      Icons.mic,
                      color: ifspeech == true ? Colors.blue[300] : Colors.grey,
                    ),
                  ),
                  title: new TextField(
                    controller: _controller,
                    decoration: new InputDecoration(
                        hintText: 'Search', border: InputBorder.none),
                    onChanged: searchOperation,
                  ),
                  trailing: new IconButton(
                    icon: new Icon(Icons.cancel),
                    onPressed: () {
                      print("hello");
                      _controller.clear();
                      searchOperation('');
                    },
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: searchresult.length != 0
                ? ListView.builder(
                    itemCount: searchresult.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) => InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => detail(
                                          data: searchresult[index],
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
                                                image: searchresult[index]
                                                            ["itemImage"] ==
                                                        null
                                                    ? AssetImage(
                                                        "images/h4hblk.png")
                                                    : NetworkImage(image_url +
                                                        searchresult[index]
                                                            ["itemImage"]),
                                                fit: BoxFit.fill),
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(10.0)),
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
                                              Text(
                                                searchresult[index]["itemName"]
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.blue[300],
                                                    fontSize: 18),
                                              ),
                                              Text(
                                                searchresult[index]["volumeId"]
                                                        [0]["volumeName"]
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                searchresult[index]["price"]
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.black45,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                            BorderRadiusDirectional.only(
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
                                                          color:
                                                              Colors.black45),
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
                                                            BorderRadiusDirectional.only(
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
                        ))
                : ListView.builder(
                    itemCount: data.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) => InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => detail(
                                          data: data[index],
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
                                                image: data[index]
                                                            ["itemImage"] ==
                                                        null
                                                    ? AssetImage(
                                                        "images/h4hblk.png")
                                                    : NetworkImage(image_url +
                                                        data[index]
                                                            ["itemImage"]),
                                                fit: BoxFit.fill),
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(10.0)),
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
                                              Text(
                                                data[index]["itemName"]
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.blue[300],
                                                    fontSize: 18),
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                data[index]["price"].toString(),
                                                style: TextStyle(
                                                    color: Colors.black45,
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                                                            BorderRadiusDirectional.only(
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
                                                          color:
                                                              Colors.black45),
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
                                                            BorderRadiusDirectional.only(
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

  void startListening() {
    lastWords = '';
    lastError = '';
    speech.listen(
        onResult: resultListener,
        listenFor: Duration(seconds: 5),
        pauseFor: Duration(seconds: 5),
        partialResults: false,
        localeId: _currentLocaleId,
        onSoundLevelChange: soundLevelListener,
        cancelOnError: true,
        listenMode: ListenMode.confirmation);
    setState(() {});
  }

  void resultListener(SpeechRecognitionResult result) {
    ++resultListened;

    setState(() {
      _controller.text =
          '${result.recognizedWords}'.replaceAll(" ", "").toUpperCase();
      searchOperation(_controller.text);
      ifspeech = false;
    });
  }

  void soundLevelListener(double level) {
    minSoundLevel = min(minSoundLevel, level);
    maxSoundLevel = max(maxSoundLevel, level);

    setState(() {
      this.level = level;
    });
  }

  void stopListening() {
    speech.stop();
    setState(() {
      level = 0.0;
    });
  }

  void cancelListening() {
    speech.cancel();
    setState(() {
      level = 0.0;
    });
  }

  void errorListener(SpeechRecognitionError error) {
    setState(() {
      lastError = '${error.errorMsg} - ${error.permanent}';
    });
  }

  void statusListener(String status) {
    setState(() {
      lastStatus = '$status';
    });
  }

  void _switchLang(selectedVal) {
    setState(() {
      _currentLocaleId = selectedVal;
    });
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      _isSearching = false;
      _controller.clear();
    });
  }
}
