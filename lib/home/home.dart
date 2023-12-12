// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_final_fields

import 'package:books_buddy/eventbuddy/models/event_models.dart';
import 'package:books_buddy/eventbuddy/screens/event_list.dart';
import 'package:books_buddy/reachbuddy/screens/reachbuddy.dart';
import 'package:books_buddy/home/screens/home_screen.dart';
import 'package:books_buddy/home/screens/profile.dart';
import 'package:books_buddy/mybuddy/screens/mybuddy.dart';
import 'package:books_buddy/shared/page.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home> {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey =
      GlobalKey<CurvedNavigationBarState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<PageProvider>(
      builder: (context, pageProvider, child) => Scaffold(
        backgroundColor: backgroundColour,
        extendBody: true,
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: pageProvider.page,
          height: 55,
          items: [
            Icon(
              Icons.home_rounded,
              size: 30,
              color: tertiaryColour,
            ),
            Icon(
              Icons.bookmark_outline_rounded,
              size: 30,
              color: tertiaryColour,
            ),
            Icon(
              Icons.search_rounded,
              size: 30,
              color: tertiaryColour,
            ),
            Icon(
              Icons.groups_2_outlined,
              size: 30,
              color: tertiaryColour,
            ),
            Icon(
              Icons.calendar_today_rounded,
              size: 30,
              color: tertiaryColour,
            ),
            Icon(
              Icons.perm_identity_rounded,
              size: 30,
              color: tertiaryColour,
            ),
          ],
          color: secondaryColour,
          buttonBackgroundColor: secondaryColour,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 300),
          onTap: (index) {
            setState(() {
              pageProvider.setPage(index);
            });
          },
          letIndexChange: (index) => true,
        ),
        body: Stack(children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: gradient,
            ),
          ),
          routing(pageProvider.page),
        ]),
      ),
    );
  }
}

Widget routing(int index) {
  if (index == 0) return HomePage();
  if (index == 1) return MyBuddy();
  if (index == 2) return Placeholder();
  if (index == 3) return ThreadsPage();
  if (index == 4) return EventPage();
  return ProfileScreen();
}
