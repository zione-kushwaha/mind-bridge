import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:t/profile/view/profile_view.dart';
import 'package:t/task_view/features/home/presentation/screens/home_screen.dart';

import 'widgets/templete_widget.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.green,
          title: Text('Mind Bridge',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.notifications, color: Colors.white),
              onPressed: () {},
            ),
          ],
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              <Widget>[
                Align(alignment: Alignment.center, child: templateWidget()),
                TaskView(),
                ProfileView(),
              ][currentPageIndex],
            ],
          ),
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
