import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';

class CarInformation {
  Map _detail;
  CarInformation(Map detail) {
    _detail = detail;
  }

  String get title => _detail['title'];
  List<String> keys() {
    return _detail.keys
        .toList()
        .where((element) => element != 'title' && element != "Description")
        .toList();
  }

  String getValue(String key) {
    return _detail[key];
  }
}

class Car {
  String name;
  int price;
  int year;
  String coverPath;
  String sidePath;
  List<CarInformation> details;

  Car(
      {this.name,
      this.year,
      this.price,
      this.details,
      this.coverPath,
      this.sidePath});

  dynamic getDetailProperty({String category = "Overview", String property}) {
    String value = "";

    value = details
        .firstWhere((element) => element.title == category)
        .getValue(property);

    return value;
  }

  List<Map<String, String>> getAllProperties() {
    List<Map<String, String>> list = [];

    details.forEach((detail) {
      detail.keys().forEach((property) {
        list.add(
          {
            'property': property,
            'value': detail.getValue(property),
          },
        );
      });
    });

    return list;
  }
}

class Collection {
  static Collection _instance;
  List<Car> list = [];
  bool loaded = false;

  List<int> get years {
    List<int> years = [];

    list.map<int>((car) => car.year).toList().forEach((year) {
      if (!years.contains(year)) years.add(year);
    });

    return years;
  }

  factory Collection() {
    if (Collection._instance == null) {
      Collection._instance = Collection._internal();
    }

    return Collection._instance;
  }

  Collection._internal();

  List<Car> getListByYear(int year) {
    return list.where((car) => car.year == year).toList();
  }

  Future<void> loadResource() async {
    String data = await rootBundle.loadString('assets/list.txt');
    if (data == null) return;

    Completer compeleter = Completer();

    List<String> lines = data.trim().split('\n');
    for (var i = 0; i < lines.length; i++) {
      String line = lines[i];

      List<String> parts = line.split('-');
      String name = parts[1].trim();
      int year = int.parse(parts[0].trim());
      String dir = 'assets/images/$name';
      String coverPath = dir + '_cover.jpg';
      String sidePath = dir + '_side.png';

      // load json info of car
      List<CarInformation> infoList;
      await rootBundle.loadStructuredData<List<CarInformation>>(
          dir + '_info.json', (value) async {
        List details = jsonDecode(value);
        List<CarInformation> list = [];

        details.forEach((detail) {
          CarInformation carInfo = CarInformation(detail as Map);
          list.add(carInfo);
        });

        return list;
      }).then((value) => infoList = value);

      Car car = Car(
        name: name,
        year: year,
        coverPath: coverPath,
        sidePath: sidePath,
        price: 157000,
        details: infoList,
      );

      list.add(car);

      if (i == lines.length - 1) {
        compeleter.complete();
        loaded = true;
      }
    }

    return compeleter;
  }
}
