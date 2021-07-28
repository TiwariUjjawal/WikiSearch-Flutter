import 'dart:convert';
import 'package:http/http.dart' as http;

Future<FinalPage> getTappedPageId(pageId) async {
  Uri uri = Uri.parse(
      'https://en.wikipedia.org/w/api.php?action=query&prop=info&inprop=url&format=json&pageids=$pageId');
  String host = uri.host;
  String path = uri.path;
  Map<String, String> queryParameters = uri.queryParameters;
  var response = await http.get(Uri.https(host, path, queryParameters));
  var jsonData = jsonDecode(response.body);
  var data = jsonData['query']['pages'][pageId.toString()];
  FinalPage finalPage = new FinalPage(data['fullurl']);
  // print(finalPage.fullURL);
  return finalPage;
}

class FinalPage {
  String fullURL;
  FinalPage(this.fullURL);
}
