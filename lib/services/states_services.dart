import 'dart:convert';

import 'package:covid_19_app/model/WorldStateModel.dart';
import 'package:covid_19_app/services/utilities/app_urls.dart';
import 'package:http/http.dart' as http;

class StateServices {
  Future<WorldStateModel> fetchWorldStates() async {
    final response = await http.get(Uri.parse(AppUrl.world));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStateModel.fromJson(data);
    } else {
      throw Exception('Error fetching data');
    }
  }

  Future<List<dynamic>> countriesList() async {
    var data;
    final response = await http.get(Uri.parse(AppUrl.countries));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception('Error fetching data');
    }
  }
}