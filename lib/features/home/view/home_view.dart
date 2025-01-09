import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'widgets/templete_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: Text('Mind Bridge'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.location_pin),
              onPressed: () {},
            ),
          ],
          leading: IconButton(
            icon: Icon(Icons.search_outlined),
            onPressed: () {},
          ),
        ),
        body: Column(
          children: [
            <Widget>[
              templateWidget(),
              Container(),
              Container(),
            ][currentPageIndex],
          ],
        ),
        bottomNavigationBar: buildBottomNavigation(),
      );

  Widget buildBottomNavigation() => ConvexAppBar(
        style: TabStyle.react,
        shadowColor: Colors.black,
        backgroundColor: Colors.green,
        items: [
          TabItem(icon: FontAwesomeIcons.home, title: ''),
          TabItem(icon: FontAwesomeIcons.gamepad, title: ''),
          TabItem(icon: FontAwesomeIcons.user, title: ''),
        ],
        initialActiveIndex: currentPageIndex,
        onTap: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
      );
}
