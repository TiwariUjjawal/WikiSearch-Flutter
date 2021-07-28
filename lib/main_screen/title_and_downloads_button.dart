import 'package:api_integration/main_screen/offline_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TitleOffline extends StatefulWidget {
  @override
  _TitleOfflineState createState() => _TitleOfflineState();
}

class _TitleOfflineState extends State<TitleOffline> {
  List<String> titleListSh = [], extractListSh = [];

  getListSF() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    extractListSh = prefs.getStringList('extractList') ?? [];
    titleListSh = prefs.getStringList('titleList') ?? [];
  }

  @override
  Widget build(BuildContext context) {
    getListSF();
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        'WIKIMobile',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
              icon: Icon(
                Icons.download,
                color: Colors.black,
              ),
              onPressed: () {
                getListSF();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            OfflinePage(titleListSh, extractListSh)));
              })),
    ]);
  }
}
