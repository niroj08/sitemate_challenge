// Obtain shared preferences.

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  storeHistory(items) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('items', items);
  }

  readHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('items');
  }
}
