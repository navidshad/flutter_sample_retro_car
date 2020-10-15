import 'package:flutter/material.dart';

class SinglePage extends StatefulWidget {
  SinglePage({Key key}) : super(key: key);

  @override
  _SinglePageState createState() => _SinglePageState();
}

class _SinglePageState extends State<SinglePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return SizedBox(
            width: constraints.maxWidth,
            height: constraints.maxHeight,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // GRADIENT BACKGROUND
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0, .5],
                        colors: [
                          Color.fromRGBO(106, 150, 115, 1),
                          Color.fromRGBO(29, 33, 45, 1),
                        ],
                      ),
                    ),
                  ),
                ),

                // CIRCLE BACKGROUND
                Container(
                  width: constraints.maxWidth / 1.4,
                  height: constraints.maxWidth / 1.4,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(222, 215, 161, 1),
                          Colors.transparent,
                        ],
                      )),
                ),

                // CAR IMAGE
                Positioned(
		left: 100,
                  child: Container(
                      child: Image.asset(
                    'assets/images/car-01.png',
                    width: constraints.maxWidth * 1.4,
                  )),
                )
              ],
            ));
      }),
    );
  }
}
