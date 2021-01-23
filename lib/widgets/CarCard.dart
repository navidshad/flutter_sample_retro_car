import 'package:flutter/material.dart';
import 'package:sample_retro_car/services/collection.dart';

class CarCard extends StatefulWidget {
  Car detail;
  CarCard({Key key, this.detail}) : super(key: key);

  @override
  _CarCardState createState() => _CarCardState();
}

class _CarCardState extends State<CarCard> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double width = constraints.maxWidth;
      double coverHeight = constraints.maxHeight / 100 * 60;
      double remainHeight = constraints.maxHeight - coverHeight;

      Widget column = Column(
        children: [
          Container(
            height: coverHeight,
            child: Image.asset(
              widget.detail.coverPath,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: Column(
              children: [
                Text(
                  widget.detail.name,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ],
      );

      return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          child: column,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
        ),
      );
    });
  }
}
