
import 'package:flutter/material.dart';

Color dimGreyColor = const Color.fromRGBO(50, 50, 50, 0.2);

const Color KpurpleColor = Color(0xFF55185D);
const Color kSplashColor = Color(0xFF472D2D);
const Color kPrimaryColor = Color(0xFF004aad);
const Color kLightGreenColor = Color(0xFF80aa23);
const Color kDarkGreenColor = Color(0xFF05342d);

const Color KyellowColor = Color(0xFFFFD524);
const Color KgreenColor = Color(0xFF2EB62C);
const Color KredColor = Color(0xFFFF0000);
TextStyle KtextStyle =
    const TextStyle(fontWeight: FontWeight.bold, fontSize: 20);

class MuyaButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final double circularRadius;
  final fontSize;
  final Color fontColor;

  MuyaButton(
      {required this.text,
      required this.onPressed,
      required this.color,
      this.circularRadius = 25.0,
      this.fontSize,
      required this.fontColor});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width * .5,
      height: 45,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(circularRadius),
          ),
        ),
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class MyContainer extends StatelessWidget {
  const MyContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      alignment: Alignment.centerLeft,
      child: const Column(
        children: [
          Expanded(
              child:
                  Image(image: AssetImage('assets/images/car washiing.jpg'))),
          Text('Car Washing')
        ],
      ),
    );
  }
}

