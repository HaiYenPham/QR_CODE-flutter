import 'dart:convert';
import 'package:qr_code/modal/historyQr.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {
  static setData(key, data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(data));
  }

  static setListData(key, List<HistoryQr> data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        key, data.map((o) => jsonEncode(o).toString()).toList());
  }

  static getData(key, callBack) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getString(key);
    callBack(json.decode(value));
  }

  static getListData(key, callBack) async {
    final prefs = await SharedPreferences.getInstance();
    final value = prefs.getStringList(key);
    if (value != null) {
      callBack(value.map((o) => HistoryQr.fromJson(jsonDecode(o))).toList());
    } else {
      callBack(new List<HistoryQr>());
    }
  }
}
