import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:sample_retro_car/services/collection.dart';
import 'package:sample_retro_car/widgets/CarCard.dart';
import 'package:sample_retro_car/widgets/CustomBottomNavigationBar.dart';

class VitrinePage extends StatefulWidget {
  VitrinePage({Key key}) : super(key: key);

  @override
  _VitrinePageState createState() => _VitrinePageState();
}

class _VitrinePageState extends State<VitrinePage> {
  double sidePading = 40;
  Collection collectionService = Collection();
  int yearIndex = 0;
  List<Car> cars = [];

  @override
  Widget build(BuildContext context) {
    if (!collectionService.loaded) {
      collectionService.loadResource().then((value) {
        int year = collectionService.years[yearIndex];
        cars = collectionService.getListByYear(year);
        setState(() {});
      });
    }

    if (!collectionService.loaded) {
      return Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(
            backgroundColor: Colors.green,
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: LayoutBuilder(builder: (context, constraint) {
        double width = constraint.maxWidth / 100 * 80;
        double height = constraint.maxHeight / 100 * 60;

        Widget header = Container(
            padding: EdgeInsets.only(left: sidePading, right: sidePading),
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
                ),
              ],
            ));

        return Column(
          children: [
            header,
            Swiper(
              itemCount: cars.length,
              layout: SwiperLayout.STACK,
              itemWidth: width,
              itemHeight: height,
              itemBuilder: (context, index) {
                Car car = cars[index];
                return CarCard(
                  detail: car,
                );
              },
            )
          ],
        );
      }),
      bottomNavigationBar: Container(
        padding: EdgeInsets.only(left: sidePading, right: sidePading),
        child: CustomBottomNavigationBar(
          years: collectionService.years,
          yearIndex: yearIndex,
          onTap: (selected) {
            yearIndex = selected;
            int year = collectionService.years[yearIndex];
            cars = collectionService.getListByYear(year);
            setState(() {});
          },
        ),
      ),
    );
  }
}
