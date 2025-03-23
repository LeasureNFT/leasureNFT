// ignore_for_file: camel_case_types

class Initail_Setting_Model {
  String? appName;
  String? defaultTheme;
  LightTheme? lightTheme;
  LightTheme? darkTheme;
  String? googleMapKey;
  String? appLanguage;
  String? appVersion;
  String? enableVersion;
  String? fontFamily;

  Initail_Setting_Model(
      {this.appName,
      this.defaultTheme,
      this.lightTheme,
      this.darkTheme,
      this.googleMapKey,
      this.appLanguage,
      this.appVersion,
      this.enableVersion,
      this.fontFamily});

  Initail_Setting_Model.fromJson(Map<String, dynamic> json) {
    appName = json['app_name'];
    defaultTheme = json['default_theme'];
    lightTheme = json['light_theme'] != null
        ? LightTheme.fromJson(json['light_theme'])
        : null;
    darkTheme = json['dark_theme'] != null
        ? LightTheme.fromJson(json['dark_theme'])
        : null;
    googleMapKey = json['google_map_key'];
    appLanguage = json['app_language'];
    appVersion = json['app_version'];
    enableVersion = json['enable_version'];
    fontFamily = json['font_family'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['app_name'] = appName;
    data['default_theme'] = defaultTheme;
    if (lightTheme != null) {
      data['light_theme'] = lightTheme!.toJson();
    }
    if (darkTheme != null) {
      data['dark_theme'] = darkTheme!.toJson();
    }
    data['google_map_key'] = googleMapKey;
    data['app_language'] = appLanguage;
    data['app_version'] = appVersion;
    data['enable_version'] = enableVersion;
    data['font_family'] = fontFamily;
    return data;
  }
}

class LightTheme {
  String? primaryColor;
  String? primaryDarkColor;
  String? accentColor;
  String? accentDarkColor;
  String? scaffoldColor;
  String? textColor;
  String? hintColor;

  LightTheme(
      {this.primaryColor,
      this.primaryDarkColor,
      this.accentColor,
      this.accentDarkColor,
      this.scaffoldColor,
      this.textColor,
      this.hintColor});

  LightTheme.fromJson(Map<String, dynamic> json) {
    primaryColor = json['primary_color'];
    primaryDarkColor = json['primary_dark_color'];
    accentColor = json['accent_color'];
    accentDarkColor = json['accent_dark_color'];
    scaffoldColor = json['scaffold_color'];
    textColor = json['text_color'];
    hintColor = json['hint_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['primary_color'] = primaryColor;
    data['primary_dark_color'] = primaryDarkColor;
    data['accent_color'] = accentColor;
    data['accent_dark_color'] = accentDarkColor;
    data['scaffold_color'] = scaffoldColor;
    data['text_color'] = textColor;
    data['hint_color'] = hintColor;
    return data;
  }
}
