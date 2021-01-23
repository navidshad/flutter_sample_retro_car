import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  List<int> years = [];
  int yearIndex = -1;
  Function(int selected) onTap;
  CustomBottomNavigationBar(
      {Key key, @required this.years, @required this.onTap, this.yearIndex})
      : super(key: key);

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int selected = -1;
  @override
  Widget build(BuildContext context) {
    selected = widget.yearIndex;
    return Container(
      height: 50,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.years.length,
        itemBuilder: (context, index) {
          int year = widget.years[index];

          return GestureDetector(
            onTap: () {
              this.selected = index;
              widget.onTap(selected);
              setState(() {});
            },
            child: Container(
              margin: EdgeInsets.only(right: 40, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    year.toString(),
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'bebas-neue',
                        color: selected == index
                            ? Colors.black
                            : Colors.grey[500]),
                  ),
                  if (selected == index)
                    Container(
                      width: 30,
                      height: 3,
                      color: Colors.green,
                    )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
