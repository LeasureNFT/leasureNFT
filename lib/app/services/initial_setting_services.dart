// ignore_for_file: deprecated_member_use

import "dart:convert" as convert;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:leasure_nft/app/core/app_colors.dart';
import 'package:leasure_nft/app/core/ui.dart';
import 'package:leasure_nft/app/users/models/initial_setting_model.dart';

class InitialSettingServices extends GetxService {
  late Initail_Setting_Model settingmodel;
  Future<InitialSettingServices> init() async {
    final response = await getjsonfile("assets/setting/initial_settings.json");
    if (response != null) {
      settingmodel = Initail_Setting_Model.fromJson(response);
    }

    return this;
  }

  static Future<dynamic> getjsonfile(String path) async {
    return rootBundle.loadString(path).then(convert.jsonDecode);
  }

  Object getThememode() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark));
    return getLightTheme();
  }

  ThemeData getLightTheme() {
    final lightTheme = settingmodel.lightTheme!;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: AppColors.transparentColor,
      statusBarBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: AppColors.transparentColor,
    ));
    return ThemeData(
        sliderTheme: SliderThemeData(
          activeTickMarkColor: AppColors.transparentColor,
          activeTrackColor: AppColors.transparentColor,
          disabledActiveTickMarkColor: AppColors.transparentColor,
          disabledThumbColor:
              UI.parseColor(settingmodel.lightTheme!.textColor!),
          inactiveTickMarkColor: AppColors.transparentColor,
          overlappingShapeStrokeColor: AppColors.primaryColor,
          disabledActiveTrackColor: AppColors.transparentColor,
          inactiveTrackColor: AppColors.transparentColor,
          disabledInactiveTickMarkColor: AppColors.transparentColor,
          disabledInactiveTrackColor: AppColors.transparentColor,
          overlayColor: AppColors.transparentColor,
          disabledSecondaryActiveTrackColor: AppColors.transparentColor,
          thumbColor: UI.parseColor(settingmodel.lightTheme!.textColor!),
        ),
        primaryColor: UI.parseColor(lightTheme.primaryColor!),
        primaryColorDark: UI.parseColor(lightTheme.primaryDarkColor!),
        dividerColor: UI.parseColor(
          lightTheme.hintColor!,
        ),
        dividerTheme: DividerThemeData(
          color: UI.parseColor(lightTheme.hintColor!),
        ),
        focusColor: UI.parseColor(lightTheme.accentColor!),
        hintColor: UI.parseColor(lightTheme.hintColor!),
        fontFamily: settingmodel.fontFamily,
        colorScheme: ColorScheme.light(
          primary: UI.parseColor(lightTheme.primaryColor!),
          secondary: UI.parseColor(lightTheme.accentColor!),
        ),
        scaffoldBackgroundColor: UI.parseColor(lightTheme.scaffoldColor!));
  }
}
