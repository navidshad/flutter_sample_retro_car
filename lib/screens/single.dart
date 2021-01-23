import 'package:flutter/material.dart';
import 'package:sample_retro_car/services/collection.dart';
import 'package:sample_retro_car/widgets/BackButton.dart';
//import 'package:sample_retro_car/widgets/BackButton.dart';

class SinglePage extends StatefulWidget {
  Car detail;
  String heroTag;
  SinglePage({Key key, @required this.detail, this.heroTag}) : super(key: key);

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
    carXAditionalPositionForAnimation =
        cardDetailScrollPercent * (carImageWidth / 150);

    // Build new Frame
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        // Create ScrolView for CardDetails
        double cardDetailBoxSize = constraints.maxWidth / 3;
        carImageWidth = constraints.maxWidth * 1.9;

        List<Map> infoList = widget.detail.getAllProperties();
        Widget cardDetails = Container(
            height: cardDetailBoxSize / 100 * 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: infoList.length,
              controller: cardDetailScrollController,
              itemBuilder: (context, index) {
                String property = infoList[index]['property'];
                String properyValue = infoList[index]['value'];

                return Card(
                  color: Colors.black12,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  margin: EdgeInsets.only(left: 40, right: 5),
                  child: Container(
                    width: cardDetailBoxSize,
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          property,
                          style: TextStyle(
                              fontFamily: "bebas-neue",
                              fontSize: 20,
                              color: Colors.grey[400]),
                        ),
                        Text(
                          properyValue,
                          style: TextStyle(
                              // fontFamily: "bebas-neue",
                              fontSize: 14,
                              color: Colors.grey[400]),
                        )
                      ],
                    ),
                  ),
                );
              },
            ));

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
                Positioned(
                  top: 100,
                  right: -70,
                  child: Container(
                    width: constraints.maxWidth / 1.1,
                    height: constraints.maxWidth / 1.1,
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
                ),

                // CAR IMAGE
                Positioned(
                  top: 80,
                  right: carXBasePosition + carXAditionalPositionForAnimation,
                  child: Container(
                      child: Hero(
                    tag: widget.heroTag,
                    child: Image.asset(
                      widget.detail.sidePath,
                      width: carImageWidth,
                    ),
                  )),
                ),

                // Header Detail
                Positioned(
                  top: 80,
                  left: 40,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Back Button
                      CustomBackButton(
                          onPressed: () => Navigator.of(context).pop()),
                      // Title
                      Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Text(
                          widget.detail.name,
                          style: TextStyle(
                            fontFamily: "bebas-neue",
                            color: Colors.grey[200],
                            fontSize: 40,
                          ),
                        ),
                      ),
                      // Price
                      Text("\$" + widget.detail.price.toString(),
                          style: TextStyle(color: Colors.grey[200])),
                    ],
                  ),
                ),

                // Buttom detail
                Positioned(
                    left: 40,
                    bottom: 140,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Book Now
                        Row(
                          children: [
                            Text(
                              "Book Now",
                              style: TextStyle(
                                  color: Colors.yellow[400],
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5, top: 6),
                              width: 20,
                              height: 3,
                              color: Colors.yellow[400],
                            )
                          ],
                        ),
                        // Description
                        Container(
                            width: constraints.maxWidth - 80,
                            height: 70,
                            margin: EdgeInsets.only(top: 20),
                            child: Text(
                              widget.detail
                                  .getDetailProperty(property: "Description"),
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey[400]),
                            ))
                      ],
                    )),

                // CARD SCROLLER
                Positioned(
                  bottom: 20,
                  child: Container(
                    width: constraints.maxWidth,
                    child: cardDetails,
                  ),
                )
              ],
            ));
      }),
    );
  }
}
