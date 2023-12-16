// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:books_buddy/findbuddy/widgets/book_section.dart';
import 'package:books_buddy/mybuddy/widgets/app_bar.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:flutter/material.dart';

class EventBook extends StatefulWidget {
  const EventBook ({super.key});

  @override
  State<EventBook> createState() => _EventBookState ();
}

class _EventBookState extends State<EventBook > {

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
                TopBar(),
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
                        "Discover Your Book",
                        style: defaultText.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                BookSection(),
                SizedBox(
                  height: 60,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
