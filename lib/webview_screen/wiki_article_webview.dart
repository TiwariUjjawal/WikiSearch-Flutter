import 'package:api_integration/fetching_apis_data/get_summary_data.dart';
import 'package:api_integration/fetching_apis_data/get_tapped_pageId.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../fetching_apis_data/get_tapped_pageId.dart';

class WikiArticleWebView extends StatefulWidget {
  final int pageId;
  WikiArticleWebView(this.pageId);

  @override
  _WikiArticleWebViewState createState() => _WikiArticleWebViewState();
}

List<Map<String, String>> summaries = [];

class _WikiArticleWebViewState extends State<WikiArticleWebView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: Icon(
                  Icons.download,
                  color: Colors.black,
                ),
                onPressed: () {
                  getSummaryData(widget.pageId);
                  final snackBar = SnackBar(
                    content: const Text(
                      'Summary is saved!',
                    ),
                    action: SnackBarAction(
                      label: 'Ok',
                      onPressed: () {},
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              ),
            ),
          ],
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: FutureBuilder<dynamic>(
            future: getTappedPageId(widget.pageId),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: Text('Loading'),
                );
              } else {
                return WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: snapshot.data?.fullURL,
                );
              }
            }));
  }
}
