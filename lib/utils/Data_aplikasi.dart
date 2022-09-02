import 'package:suryabaru/utils/Local_storage.dart';

class AppData {
  // data user login

  static set setNameUserLogin(String value) {
    LocalStorage().saveToDisk(key: 'setNameUserLogin', value: value);
  }

  static String get setNameUserLogin =>
      LocalStorage().getFromDisk(key: 'setNameUserLogin');

  static set setRole(String value) {
    LocalStorage().saveToDisk(key: 'setRole', value: value);
  }

  static String get setRole => LocalStorage().getFromDisk(key: 'setRole');

  // static set setStatusUserLogin(dynamic value) {
  //   LocalStorage().saveToDisk(key: 'setStatusUserLogin', value: value);
  // }

  // static dynamic get setStatusUserLogin =>
  //     LocalStorage().getFromDisk(key: 'setStatusUserLogin');
}
