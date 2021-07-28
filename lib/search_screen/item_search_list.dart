import 'package:api_integration/search_screen/recent_items.dart';
import 'package:api_integration/search_screen/search_item.dart';
import 'package:flutter/material.dart';
import '../fetching_apis_data/get_search_data.dart';

class ItemSearchScreen extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return query.isEmpty
        ? Column(
            children: [
              RecentItems(recent),
            ],
          )
        : FutureBuilder<List<dynamic>>(
            future: getSearchData(query, 10),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Center(
                    child: CircularProgressIndicator(
                  color: Colors.brown,
                ));
              } else {
                return Scrollbar(
                  isAlwaysShown: true,
                  child: ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, i) {
                        SearchItem item = SearchItem(snapshot, i);
                        return item; //ListTile
                      }),
                );
              }
            });
  }
}
