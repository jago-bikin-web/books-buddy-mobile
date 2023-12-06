// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:books_buddy/home/widgets/book_section.dart';
import 'package:books_buddy/home/widgets/moduls.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:flutter/material.dart';

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
            ),
            SizedBox(
              height: 24,
            ),
            BookSection(heading: "Discover More"),
            BookSection(heading: "Your Collection"),
            SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
