import 'package:flutter/material.dart';

class SinglePage extends StatefulWidget {
  SinglePage({Key key}) : super(key: key);

  @override
  _SinglePageState createState() => _SinglePageState();
}

class _SinglePageState extends State<SinglePage> {
  ScrollController cardDetailScrollController;
  bool firstFrameRendered = false;
  double carXBasePosition = 0;
  double carXAditionalPositionForAnimation = 0;
  double carImageWidth = 100;

  initState() {
    super.initState();
    cardDetailScrollController = ScrollController();
    cardDetailScrollController.addListener(onCardDetailScrollChanged);
  }

  onCardDetailScrollChanged() {
    // Calculate cardDetail scroll percentage
    double cardDetailScrollPosition = cardDetailScrollController.offset;
    double cardDetailWidth =
        cardDetailScrollController.position.maxScrollExtent;
    double cardDetailScrollPercent =
        cardDetailScrollPosition / (cardDetailWidth / 100);

    // Calculate new value for car image x position
    carXAditionalPositionForAnimation = cardDetailScrollPercent * (carImageWidth/150);
    
    // Build new Frame
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        // Create ScrolView for CardDetails
        double cardDetailBoxSize = constraints.maxWidth / 4;
        carImageWidth = constraints.maxWidth * 1.4;

        ListView cardDetails = ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          controller: cardDetailScrollController,
          itemBuilder: (context, index) {
            return Container(
              width: cardDetailBoxSize,
              height: cardDetailBoxSize,
              margin: EdgeInsets.all(10),
              color: Colors.yellow,
            );
          },
        );

        if (!firstFrameRendered) {
          firstFrameRendered = true;
          carXBasePosition = -carImageWidth / 2;
        }

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
                  right: carXBasePosition + carXAditionalPositionForAnimation,
                  child: Container(
                      child: Image.asset(
                    'assets/images/car-01.png',
                    width: carImageWidth,
                  )),
                ),

                // CARD SCROLLER
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: constraints.maxWidth,
                    height: cardDetailBoxSize,
                    child: cardDetails,
                  ),
                )
              ],
            ));
      }),
    );
  }
}
