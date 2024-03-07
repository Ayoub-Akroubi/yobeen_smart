// ignore_for_file: file_names

import 'package:get_storage/get_storage.dart';

class LocalStorage {
  /// use this to [saveToken] to local storage
  static saveToken(String tokenValue) {
    return GetStorage().write("token", tokenValue);
  }

  /// use this to [deleteToken] from local storage
  static deleteToken() {
    return GetStorage().remove("token");
  }

  /// use this to [getToken] from local storage
  static getToken() {
    return GetStorage().read("token");
  }

  /// use this to [saveSerial] to local storage
  static saveSerial(String serialValue) {
    return GetStorage().write("serial", serialValue);
  }

  /// use this to [getSerial] from local storage
  static getSerial() {
    return GetStorage().read("serial");
  }

  /// use this to [deleteSerial] from local storage
  static deleteSerial() {
    return GetStorage().remove("serial");
  }

  /// use this to [saveTele] to local storage
  static saveTele(String teleValue) {
    return GetStorage().write("tele", teleValue);
  }

  /// use this to [deleteTele] from local storage
  static deleteTele() {
    return GetStorage().remove("tele");
  }

  /// use this to [getTele] from local storage
  static getTele() {
    return GetStorage().read("tele");
  }

  /// use this to [savePassword] to local storage
  static savePassword(String passwordValue) {
    return GetStorage().write("password", passwordValue);
  }

  /// use this to [deletePassword] from local storage
  static deletePassword() {
    return GetStorage().remove("password");
  }

  /// use this to [getPassword] from local storage
  static getPassword() {
    return GetStorage().read("password");
  }

  /// use this to [saveRemember] to local storage
  static saveRemember(bool rememberValue) {
    return GetStorage().write("remember", rememberValue);
  }

  /// use this to [deleteRemember] from local storage
  static deleteRemember() {
    return GetStorage().remove("remember");
  }

  /// use this to [getRemember] from local storage
  static getRemember() {
    return GetStorage().read("remember");
  }
}
