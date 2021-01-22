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
    return Container(
      height: 100,
      child: Text(widget.detail.name),
      color: Colors.blueAccent,
    );
  }
}
