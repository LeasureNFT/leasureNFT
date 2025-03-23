import 'package:flutter/material.dart';

class AppTextStyles {
  static final TextStyle _baseStyle = TextStyle(
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
    color: Colors.black, // Default color is black
    fontFamily: 'Outfit', // Default font family (change as needed)
  );

  
  static TextStyle text(double size) => _baseStyle.copyWith(fontSize: size);

  static TextStyle text10() => text(10);
  static TextStyle text12() => text(12);
  static TextStyle text14() => text(14);
  static TextStyle text16() => text(16);
  static TextStyle text18() => text(18);
  static TextStyle text20() => text(20);
  static TextStyle text24() => text(24);
  static TextStyle text34() => text(34);

  // Function to get font size based on device type using copyWith
  static TextStyle adaptiveText(BuildContext context, double baseSize) {
    double screenWidth = MediaQuery.of(context).size.width;

    double adjustedSize;

    if (screenWidth < 600) {
      // Mobile
      adjustedSize = baseSize;
    } else if (screenWidth >= 600 && screenWidth < 1200) {
      // Tablet
      adjustedSize = baseSize * 1.2;
    } else {
      // Laptop/Desktop
      adjustedSize = baseSize * 1.5;
    }

    return _baseStyle.copyWith(fontSize: adjustedSize);
  }
}