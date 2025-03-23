import 'package:get_storage/get_storage.dart';

const String _admin = 'admin';

class AppPrefernces {
  static setAdmin(value) => GetStorage().write(_admin, value);
  static get getAdmin => GetStorage().read(_admin);
  static removeAdmin() => GetStorage().remove(_admin);
}
