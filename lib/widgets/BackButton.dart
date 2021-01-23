import 'package:flutter/material.dart';

class CustomBackButton extends StatelessWidget {
  final Function onPressed;
  const CustomBackButton({Key key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onPressed(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.chevron_left,
            color: Colors.grey[300],
          ),
          Text(
            "Back",
            style: TextStyle(
                color: Colors.grey[300],
                //fontFamily: 'bebas-neue',
                fontSize: 18),
          )
        ],
      ),
    );
  }
}
