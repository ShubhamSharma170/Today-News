import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class StorageHelper {
  StorageHelper._();
  static final StorageHelper instance = StorageHelper._();
  factory StorageHelper() => instance;

  late SharedPreferences sp;

  init() async {
    sp = await SharedPreferences.getInstance();
  }

  void clean() async {
    await sp.clear();
    log("Storage Cleaned");
  }

  void setString(String userId){
    sp.setString("userId", userId);
  }

  String getString(){
    return sp.getString("userId") ?? "";
  }
}
