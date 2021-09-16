import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeService {
  EmployeeService({this.url});

  String url;
  Future getEmpDetails() async {
    http.Response resp = await http.get(url);
    print(resp.body);
    if (resp.statusCode == 200) {
      print(resp);
      storeEmpData(resp.body);
      var result = jsonDecode(resp.body);
      return result;
    }
  }

  void storeEmpData(jsonString) async {
    if (json.decode(jsonString) != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('emp_data', json.encode(json.decode(jsonString)));
    }
  }

  Future<String> getEmpData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
//  prefs.clear();
    var _user;
    if (prefs.containsKey('emp_data')) {
      _user = prefs.get('emp_data');
    }
    print(_user);
    print("_user");
    return _user;
  }
}
