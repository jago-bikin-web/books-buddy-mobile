// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, library_private_types_in_public_api, use_key_in_widget_constructors, prefer_final_fields

import 'package:books_buddy/home/screens/home_screen.dart';
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
                height: 60.0,
                items: <Widget>[
                  Icon(Icons.list, size: 30),
                  Icon(Icons.compare_arrows, size: 30),
                  Icon(Icons.call_split, size: 30),
                  Icon(Icons.perm_identity, size: 30),
                ],
                color: Colors.white,
                buttonBackgroundColor: primaryColour,
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
              body: SafeArea(
                bottom: false,
                child: routing(pageProvider.page),
              ),
            ));
  }
}

Widget routing(int index) {
  if (index == 0) return HomePage();
  if (index == 1) return Placeholder();
  if (index == 2) return Placeholder();
  return Placeholder();
}
