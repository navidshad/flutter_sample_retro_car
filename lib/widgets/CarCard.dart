import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sample_retro_car/screens/single.dart';
import 'package:sample_retro_car/services/collection.dart';

class CarCard extends StatefulWidget {
  Car detail;
  CarCard({Key key, this.detail}) : super(key: key);

  @override
  _CarCardState createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  String heroTag;
  @override
  Widget build(BuildContext context) {
    heroTag =
        Random().nextDouble().toString() + Random().nextDouble().toString();

    return LayoutBuilder(builder: (context, constraints) {
      double shadowMargin = 23;
      double width = constraints.maxWidth - shadowMargin;
      double coverHeight = (constraints.maxHeight - shadowMargin) / 100 * 60;
      double remainHeight =
          constraints.maxHeight - coverHeight - (shadowMargin * 2);

      Widget column = Column(
        children: [
          Container(
            height: coverHeight,
            child: Hero(
              tag: heroTag,
              child: Image.asset(
                widget.detail.coverPath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 35, right: 35, top: 10),
            color: Colors.white,
            width: width,
            height: remainHeight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.detail.name,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text("\$" + widget.detail.price.toString(), style: TextStyle()),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Text(
                        "Book Now",
                        style: TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, top: 6),
                        width: 20,
                        height: 3,
                        color: Colors.green,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      );

      return GestureDetector(
        child: Container(
          margin: EdgeInsets.all(shadowMargin),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                // spreadRadius: .0,
                blurRadius: 20,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Container(
              child: column,
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => SinglePage(
                      detail: widget.detail,
                      heroTag: heroTag,
                    )),
          );
        },
      );
    });
  }
}
