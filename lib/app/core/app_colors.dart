import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:leasure_nft/app/core/ui.dart';
import 'package:leasure_nft/app/services/initial_setting_services.dart';

class AppColors {
  static Color get whiteColor => UI.parseColor("#ffffff");
  static Color get primaryColor => Get.theme.primaryColor;
  static Color get primaryColor100 => UI.parseColor("#FFEDEA");
  static Color get scaffoldColor => UI.parseColor("#f6faea");
  // static Color get primaryColor300 => UI.parseColor("#FFC0C1");
  // static Color get primaryColor400 => UI.parseColor("#FFB0B9");
  static Color get blackColor => UI.parseColor("#212121");
  // static Color get orangeColor => UI.parseColor("##f9672c");
  static Color get blackColor300 => UI.parseColor("#bcbcbc");
  static Color get blackColor200 => UI.parseColor("#e8e8e8");
  static Color get blackColor100 => UI.parseColor(" #f3f3f3");
  static Color get transparentColor => Colors.transparent;
  static Color get hintTextColor => Get.theme.hintColor;

  static Color get purpleColor => UI.parseColor("#bb8dd1");
  static Color get purpleColor100 => UI.parseColor("#f5f0f7");
  static Color get purpleColor200 => UI.parseColor("#ebe1ef");
  static Color get purpleColor300 => UI.parseColor("#e0d3e7");
  static Color get purpleColor400 => UI.parseColor("#d6c4df");
  static Color get accentColor => UI.parseColor(
      Get.find<InitialSettingServices>().settingmodel.lightTheme!.accentColor!);
  static Color get accentColor100 => UI.parseColor("#fdfcfd");
  // static Color get accentColor200 => UI.parseColor("#fbf9fc");
  static Color get accentColor300 => UI.parseColor("#f9f6fa");
  // static Color get accentColor400 => UI.parseColor("#f7f3f9");
  // static Color get primaryColorLite500 => UI.parseColor("#feead3");
  // static Color get primaryColorLite400 => UI.parseColor("#feeedc");
  // static Color get primaryColorLite300 => UI.parseColor("#f7f3f9");
  static Color get primaryColorLite200 => UI.parseColor("#fff7ed");
  // static Color get primaryColorLite100 => UI.parseColor("#fffbf6");
  static Color get errorColor => UI.parseColor("#fc202e");
  static Color get primaryDallColor => UI.parseColor("#f9aa4d");
  static Color get buttonShadowColor =>
      UI.parseColor("#4df89521").withOpacity(0.2);
  static Color get errorShadowColor =>
      UI.parseColor("#fc202e").withOpacity(0.2);
  static Color get primaryGradianColor => UI.parseColor("#fcd5a6");
  static Color get greenColor => UI.parseColor("#a9d534");
  // static Color get secondarycolors => Get.theme.focusColor;

  /////// Dark Theme Colors

  static Color get darkBlack => UI.parseColor("#3b3b3b");
  static Color get darkShadowColor => UI.parseColor("#585858");
  static Color get darkGradianColor => UI.parseColor("#4d4c4c");
  static Color get darkShadowColor2 => UI.parseColor("#565656");
  static Color get darkDividerColor =>
      UI.parseColor("#f5f0f7").withOpacity(0.5);
  static Color get darkJournalsColor => UI.parseColor("#4d4c4c");
}
