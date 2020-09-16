import 'package:flutter/material.dart';

class VitrinePage extends StatefulWidget {
  VitrinePage({Key key}) : super(key: key);

  @override
  _VitrinePageState createState() => _VitrinePageState();
}

class _VitrinePageState extends State<VitrinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(left: 40, right: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Container(
              margin: EdgeInsets.only(top: 40, bottom: 35),
              child: Text(
                'Retro Cars'.toUpperCase(),
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),

            // Search
            TextField(
              decoration: InputDecoration(
                  hintText: 'Search Car',
                  icon: Icon(Icons.search),
                  border: InputBorder.none),
            ),
            Divider(
              color: Colors.grey[300],
              thickness: .5,
            )

            // tabbar

            // tab content

            // year caroucel
          ],
        ),
      ),
    );
  }
}
