import 'dart:convert';
import 'package:http/http.dart' as http;

class Article {
  var id;
  String title;
  Article(this.id, this.title);
}

Future<List<Article>> getRandomTitle() async {
  Uri uri = Uri.parse(
      'https://en.wikipedia.org/w/api.php?action=query&list=random&format=json&rnnamespace=0&rnlimit=20');
  String host = uri.host;
  String path = uri.path;
  Map<String, String> queryParameters = uri.queryParameters;
  // print(host);
  // print(path);
  // print(queryParameters);
  var response = await http.get(Uri.https(host, path, queryParameters));
  var jsonData = jsonDecode(response.body);
  List<Article> articles = [];

  var data = jsonData['query']['random'];
  for (var d in data) {
    Article article = new Article(
      d['id'],
      d['title'],
    );
    articles.add(article);
  }
  return articles;
}
