// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:books_buddy/shared/page.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60,
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    height: 30,
                    width: 30,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Books Buddy",
                    style: defaultText.copyWith(
                      color: primaryColour,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "Hi, FULL NAME USER!",
                style: defaultText.copyWith(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 20,
              ),
              child: Divider(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Moduls(
                      title: "My Buddy", icon: Icons.bookmark_outline_rounded),
                  Moduls(title: "Find Buddy", icon: Icons.search_rounded),
                  Moduls(title: "Reach Buddy", icon: Icons.groups_2_outlined),
                  Moduls(
                      title: "Event Buddy", icon: Icons.calendar_today_rounded),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Moduls extends StatelessWidget {
  final IconData icon;
  final String title;

  const Moduls({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PageProvider>(
      builder: (context, pageProvider, child) => Card(
        color: Colors.white,
        elevation: 2,
        child: InkWell(
          onTap: () {
            pageProvider.setPage(3);
          },
          borderRadius: BorderRadius.circular(13),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: SizedBox(
              width: 85,
              height: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: defaultText.copyWith(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
