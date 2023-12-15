// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:books_buddy/mybuddy/widgets/floating_button.dart';
import 'package:books_buddy/mybuddy/widgets/own_book_section.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:flutter/material.dart';

class MyBuddy extends StatefulWidget {
  const MyBuddy({super.key});

  @override
  State<MyBuddy> createState() => _MyBuddyState();
}

class _MyBuddyState extends State<MyBuddy> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: backgroundColour,
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 40,
                  decoration: BoxDecoration(
                      gradient: gradient,
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
                  padding: EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                  child: Divider(
                    color: primaryColour,
                    thickness: 2,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        "Your Collection",
                        style: defaultText.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    OwnBookSection(
                        url:
                            "http://127.0.0.1:8000/mybuddy/get-own-book/?username=restu")
                  ],
                ),
                SizedBox(
                  height: 60,
                )
              ],
            ),
          ),
          FloatingButtonAdd(
            toPage: 2,
          )
        ],
      ),
    );
  }
}
