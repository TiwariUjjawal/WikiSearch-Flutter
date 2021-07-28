import 'package:flutter/material.dart';

import '../search_screen/item_search_list.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.075,
      padding: EdgeInsets.only(
        top: 20,
        left: 15,
        right: 15,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.black, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              color: Colors.black,
              alignment: Alignment.centerLeft,
              onPressed: () {
                showSearch(context: context, delegate: ItemSearchScreen());
              },
              icon: Icon(Icons.search),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                'Search WIKIMobile',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
        onPressed: () {
          showSearch(context: context, delegate: ItemSearchScreen());
        },
      ),
    );
  }
}
