import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

getSummaryData(pageId) async {
  Uri uri = Uri.parse(
      'https://en.wikipedia.org/w/api.php?format=json&action=query&prop=extracts&exintro&explaintext&redirects=1&pageids=$pageId');
  String host = uri.host;
  String path = uri.path;
  Map<String, String> queryParameters = uri.queryParameters;
  var response = await http.get(Uri.https(host, path, queryParameters));
  var jsonData = jsonDecode(response.body);
  var data = jsonData['query']['pages'][pageId.toString()];
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> extractList = prefs.getStringList('extractList') ?? [];
  List<String> titleList = prefs.getStringList('titleList') ?? [];
  if (!titleList.contains(data['title'])) {
    extractList.insert(0, data['extract']);
    titleList.insert(0, data['title']);
    prefs.setStringList('extractList', extractList);
    prefs.setStringList('titleList', titleList);
  }
}
