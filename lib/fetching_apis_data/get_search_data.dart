import 'dart:convert';
import 'package:api_integration/models/page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Page>> getSearchData(query, limit) async {
  var jsonData;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // prefs.setString(key, value)

  if (prefs.containsKey(query)) {
    String responseBody = prefs.getString(query) ?? '';
    jsonData = jsonDecode(responseBody);
    print('fetching from Cache');
  } else {
    String space = ' ';
    if (query.length >= 3) {
      for (int i = 1; i < query.length; i++) {
        if (query[i] == space &&
            query[i - 1] != space &&
            query[i + 1] != space) {
          query = query.substring(0, i) +
              '_' +
              query.substring(i + 1, query.length);
        }
      }
    }

    Uri uri = Uri.parse(
        'https://en.wikipedia.org/w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpslimit=$limit&gpssearch=$query&gpsoffset=0');
    String host = uri.host;
    String path = uri.path;
    Map<String, String> queryParameters = uri.queryParameters;
    var response = await http.get(Uri.https(host, path, queryParameters));
    prefs.setString(query, response.body);
    jsonData = jsonDecode(response.body);
    print('Loading from API');
  }

  var data = jsonData['query']['pages'];
  List<Page> pages = [];
  for (var d in data) {
    var title = d['title'];
    var imageURL;
    var description;
    d.containsKey('thumbnail')
        ? imageURL = d['thumbnail']['source']
        : imageURL = '';
    d.containsKey('terms')
        ? description = d['terms']['description'][0]
        : description = '';
    if (title.length > 20) {
      title = title.substring(0, 20) + '..';
    }
    if (description.length > 35) {
      description = description.substring(0, 35) + '..';
    }
    var pageId = d['pageid'];
    Page page = new Page(
      title: title,
      imageURL: imageURL,
      description: description,
      pageId: pageId,
    );
    pages.add(page);
  }
  return pages;
}
