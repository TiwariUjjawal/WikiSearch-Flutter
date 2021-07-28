import 'package:api_integration/fetching_apis_data/get_news_data.dart';
import 'package:api_integration/main_screen/news_card.dart';
import 'package:flutter/material.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6975,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 25, right: 20, top: 10, bottom: 10),
            child: Text(
              'Top News India',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.brown[700],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25, right: 20),
            child: Divider(
              color: Colors.brown,
              height: 10,
            ),
          ),
          FutureBuilder<List<dynamic>>(
              future: getNewsData(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.brown,
                      ),
                    ),
                  );
                } else {
                  return Expanded(
                    child: Scrollbar(
                      isAlwaysShown: true,
                      child: ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, i) {
                            NewsCard item = NewsCard(
                                snapshot.data?[i].title,
                                snapshot.data?[i].imageUrl,
                                snapshot.data?[i].url,
                                snapshot.data?[i].content);
                            return item; //ListTile
                          }),
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }
}
