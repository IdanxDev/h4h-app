import 'package:flutter/material.dart';
import 'package:h4h/component/appbar.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: myAppBar(context, 'Contact Us'),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(35),
              color: Colors.grey[100],
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Contact Us',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Align(
                      alignment: Alignment.centerLeft, child: Text('Phone Number: ')),
                  SizedBox(
                    height: 10,
                  ),
                   Align(
                      alignment: Alignment.centerLeft, child: Text('Email: ')),
                ],
              ),
            ),
            SizedBox(height: 15,),
            Container(child: Text('Address', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),)),
            Divider(thickness: 2,),
            Container(margin: EdgeInsets.all(MediaQuery.of(context).size.height*0.01),
            height: MediaQuery.of(context).size.height*0.5,
            color: Colors.green,),
          ],
        ));
  }
}
