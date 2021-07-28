import 'dart:io';
import 'package:api_integration/main_screen/news_list.dart';
import 'package:api_integration/main_screen/random_articles_list.dart';
import 'package:api_integration/main_screen/search_bar.dart';
import 'package:api_integration/main_screen/title_and_downloads_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isConnected = false;

  Future<void> _checkInternetConnection() async {
    try {
      final response = await InternetAddress.lookup('www.kindacode.com');
      if (response.isNotEmpty) {
        setState(() {
          isConnected = true;
          print('conn');
        });
      }
    } on SocketException catch (err) {
      setState(() {
        isConnected = false;
      });
      print(err);
    }
  }

  void initState() {
    _checkInternetConnection();
    super.initState();
  }

  bool reload = false;
  reloadRandom() {
    setState(() {
      reload = true;
    });
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      NewsList(),
      reload
          ? RandomArticlesList(reloadRandom)
          : RandomArticlesList(reloadRandom),
    ];

    return Scaffold(
      body: isConnected == false
          ? Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.03,
                  margin: EdgeInsets.only(top: 80, left: 15),
                  width: double.infinity,
                  child: TitleOffline(),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          _checkInternetConnection();
                        },
                        icon: Icon(
                          Icons.refresh,
                          size: 50,
                        ),
                      ),
                      Text(
                        'No Internet Connection',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              ],
            )
          : Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.03,
                  margin: EdgeInsets.only(top: 80, left: 15),
                  width: double.infinity,
                  child: TitleOffline(),
                ),
                SearchBar(), // 0.075
                Divider(
                  height: 10,
                  color: Colors.brown[50],
                ),
                _widgetOptions.elementAt(_selectedIndex),
              ],
            ),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.1,
        child: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'News',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.article),
              label: 'Articles',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
