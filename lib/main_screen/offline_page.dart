import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfflinePage extends StatefulWidget {
  final List<String> extractListSh, titleListSh;
  OfflinePage(this.titleListSh, this.extractListSh);
  @override
  _OfflinePageState createState() => _OfflinePageState();
}

class _OfflinePageState extends State<OfflinePage> {
  removeDownload() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('extractList', widget.extractListSh);
    prefs.setStringList('titleList', widget.titleListSh);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Offline Pages',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.brown[800],
            ),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
        body: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              child: Scrollbar(
                isAlwaysShown: true,
                child: ListView.builder(
                    itemCount: widget.extractListSh.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Scaffold(
                                          appBar: AppBar(
                                            backgroundColor: Colors.white,
                                            iconTheme: IconThemeData(
                                              color: Colors.black,
                                            ),
                                          ),
                                          body: Column(
                                            children: [
                                              Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.1,
                                                width: double.infinity,
                                                padding: EdgeInsets.only(
                                                    top: 30,
                                                    bottom: 10,
                                                    left: 10),
                                                child: Column(
                                                  // crossAxisAlignment:
                                                  //     CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      widget.titleListSh[i],
                                                      style: TextStyle(
                                                        fontSize: 28,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.red[700],
                                                      ),
                                                    ),
                                                    Divider(
                                                      height: 10,
                                                      color: Colors.brown,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20, right: 20),
                                                  child: Container(
                                                      height: 30,
                                                      width: 30,
                                                      child: Image.asset(
                                                          'images/wikipedia.png')),
                                                ),
                                                Text(
                                                  'Summary:',
                                                  style: TextStyle(
                                                    fontSize: 22,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.brown,
                                                  ),
                                                ),
                                              ]),
                                              Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.only(
                                                    top: 20,
                                                    // bottom: 10,
                                                    left: 10,
                                                    right: 5),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.7,
                                                child: Scrollbar(
                                                  isAlwaysShown: true,
                                                  child: SingleChildScrollView(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Text(
                                                        widget.extractListSh[i],
                                                        style: TextStyle(
                                                          height: 2.0,
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.normal,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )));
                          },
                          title: Column(children: [
                            Container(
                              padding: EdgeInsets.only(top: 10),
                              child: Row(
                                children: [
                                  Container(
                                      height: 50,
                                      width: 50,
                                      child:
                                          Image.asset('images/wikipedia1.png')),
                                  Container(
                                    width: MediaQuery.of(context).size.height *
                                        0.32,
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      widget.titleListSh[i],
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.brown[800]),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        widget.titleListSh.removeAt(i);
                                        widget.extractListSh.removeAt(i);
                                        removeDownload();
                                      });
                                    },
                                    icon: Icon(
                                      Icons.remove_circle,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(
                              height: 10,
                              color: Colors.brown[700],
                            ),
                          ]));
                    }),
              ),
            )
          ],
        ));
  }
}
