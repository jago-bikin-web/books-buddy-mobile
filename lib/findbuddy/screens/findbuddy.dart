// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:books_buddy/mybuddy/widgets/app_bar.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:flutter/material.dart';

class FindBuddy extends StatefulWidget {
  const FindBuddy({super.key});

  @override
  State<FindBuddy> createState() => _FindBuddyState();
}

class _FindBuddyState extends State<FindBuddy> {
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: TextField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: primaryColour.withOpacity(0.2),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "eg: Tanah Para Bedebah",
                          prefixIcon: Icon(Icons.search_rounded)
                        ),
                      ),
                    ),
                  ],
                ),
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
