import 'package:api_integration/fetching_apis_data/get_random_title.dart';
import 'package:api_integration/fetching_apis_data/get_random_list.dart';
import 'package:api_integration/search_screen/search_item.dart';
import 'package:flutter/material.dart';

class RandomArticlesList extends StatelessWidget {
  final Function reloadRandom;
  RandomArticlesList(this.reloadRandom);
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.only(left: 25, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Random Articles',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.brown[700],
              ),
            ),
            IconButton(
              onPressed: () {
                reloadRandom();
              },
              icon: Icon(
                Icons.refresh,
                size: 30,
                color: Colors.brown,
              ),
            ),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 25, right: 20),
        child: Divider(
          color: Colors.brown,
          height: 10,
        ),
      ),
      Container(
        height: MediaQuery.of(context).size.height * 0.635,
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Scrollbar(
          isAlwaysShown: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                FutureBuilder<List<dynamic>>(
                    future: getRandomTitle(),
                    builder: (context, snapArticle) {
                      if (snapArticle.data == null) {
                        return Container(
                          height: 80,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Colors.brown,
                            ),
                          ),
                        );
                      } else {
                        return Column(
                          children: [
                            ...(snapArticle.data ?? []).map((article) {
                              return FutureBuilder<List<dynamic>>(
                                  future: getRandomList(article.title, 1),
                                  builder: (context, snapshot) {
                                    if (snapshot.data == null) {
                                      return Container(
                                        height: 80,
                                        child: Center(child: Text('')),
                                      );
                                    } else {
                                      return SearchItem(snapshot, 0);
                                    }
                                  });
                            })
                          ],
                        );
                      }
                    })
              ],
            ),
          ),
        ),
      ),
    ]);
  }
}
