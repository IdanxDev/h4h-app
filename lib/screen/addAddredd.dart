import 'package:flutter/material.dart';
import 'package:h4h/component/appbar.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:location/location.dart' as loc;

const kGoogleApiKey = "AIzaSyCmlDl68iTBoWTJfxft3e0GXqElJzzbOhc";

GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);

class addaddress extends StatefulWidget {
  @override
  _addaddressState createState() => _addaddressState();
}

class _addaddressState extends State<addaddress> {
  bool isLoading = false;
  List data = [];
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  String pickAddress = "", deliverAddress = "";
  double pickLat, pickLong, deliveryLat, deliveryLong;
  TextEditingController _addController = TextEditingController();
  loc.LocationData currentLocation;

  searchPickLocation(String addresstype) async {
    try {
      print("Current Location");
      Prediction p = await PlacesAutocomplete.show(
        context: context,
        hint: addresstype == "pickup"
            ? "Search your pick location"
            : "Search your drop location",
        apiKey: kGoogleApiKey,

        onError: onError,
        mode: Mode.overlay,
        language: "en",
        components: [
          Component(Component.country, "in"),
        ],
        location: currentLocation == null
            ? null
            : Location(currentLocation.latitude, currentLocation.longitude),
        //radius: currentLocation == null ? null : 10000
      );
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);
      if (addresstype == "pickup") {
        setState(() {
          pickAddress = p.description;
          pickLat = detail.result.geometry.location.lat;
          pickLong = detail.result.geometry.location.lng;
        });
        print("pickLat");
        print(pickLat);
        print("pickLong");
        print(pickLong);
        Navigator.of(context).pop(true);
        if (deliverAddress != null) {
          setState(() {
            deliverAddress = "";
          });
        }
      } else {
        setState(() {
          deliverAddress = p.description;
          _addController.text = deliverAddress;
          deliveryLat = detail.result.geometry.location.lat;
          deliveryLong = detail.result.geometry.location.lng;
        });
        print("deliveryLat");
        print(deliveryLat);
        print("deliveryLong");
        print(deliveryLong);
        print("deliverAddress");
        print(deliverAddress);
      }
    } catch (e) {
      return;
    }
  }

  void onError(PlacesAutocompleteResponse response) {
    homeScaffoldKey.currentState.showSnackBar(
      SnackBar(content: Text(response.errorMessage)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(context, 'Add New Address'),
      body: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          InkWell(
            onTap: () {
              searchPickLocation("get address");
            },
            child: Container(
              height: 45,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  color: Colors.blue[300],
                  borderRadius: BorderRadiusDirectional.circular(10.0)),
              child: Center(
                  child: GestureDetector(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.white,
                      size: 28,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      "Find Your Location ",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              )),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.03),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: TextField(
              controller: _addController,
              maxLines: 3,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(18.0)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[300]),
                  borderRadius: BorderRadius.circular(18.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue[300]),
                  borderRadius: BorderRadius.circular(18.0),
                ),
                fillColor: Colors.white,
                filled: true,
                counterText: "",
                labelText: "Address",
                contentPadding: EdgeInsets.only(top: 50),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Image.asset(
                    "images/location.png",
                    height: 10,
                    width: 10,
                  ),
                ),
              ),
            ),
          ),
          SizedBox( height: MediaQuery.of(context).size.height*0.03),
          InkWell(
            onTap: () {
              print('address sumited');
            },
            child: Column(
                          children: [Container(
                height: 45,
                width: MediaQuery.of(context).size.width * 0.4,
                decoration: BoxDecoration(
                    color: Colors.blue[300],
                    borderRadius: BorderRadiusDirectional.circular(10.0)),
                child: Center(
                    child: GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     
                      
                      Text(
                        "Submit",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w700),
                      ),
                    ],
                  ),
                )),
              ),]
            ),
          ),],
      ),
    );
  }
}

