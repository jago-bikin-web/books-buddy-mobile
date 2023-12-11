// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:books_buddy/auth/models/user_models.dart';
import 'package:books_buddy/home/widgets/book_section.dart';
import 'package:books_buddy/home/widgets/book_section_down.dart';
import 'package:books_buddy/home/widgets/moduls.dart';
import 'package:books_buddy/home/widgets/photo_profile.dart';
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
          children: [
            Container(
              height: 40,
              decoration: BoxDecoration(
                  color: backgroundColour,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(64, 32),
                      bottomRight: Radius.elliptical(64, 32))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, FULL NAME!",
                        style: defaultText.copyWith(
                            color: backgroundColour,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "username",
                        style: defaultText.copyWith(
                            fontSize: 16, color: Colors.black87),
                      )
                    ],
                  ),
                  // TODO: Integrasiin sama yang udah login
                  PhotoProfile(image: "https://i.pravatar.cc/48?img=20"),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Divider(
                color: primaryColour,
                thickness: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
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
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.elliptical(64, 32),
                      topRight: Radius.elliptical(64, 32)),
                  color: backgroundColour),
              child: Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BookSection(
                      heading: "Your Collection",
                      url: "http://127.0.0.1:8000/mybuddy/get-own-book/?username=${logInUser?.username}",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        "Discover More",
                        style: defaultText.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    BookSectionDown(
                      url: "http://127.0.0.1:8000/api/get-random/",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
