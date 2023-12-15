import 'package:books_buddy/shared/page.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:books_buddy/findbuddy/widgets/allbooks.dart';

class FindBuddy extends StatefulWidget {
  const FindBuddy({Key? key}) : super(key: key);
  @override
  _FindBuddyState createState() => _FindBuddyState();
}

class _FindBuddyState extends State<FindBuddy> {
@override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 75,
              decoration: BoxDecoration(
                  color: backgroundColour,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(64, 32),
                      bottomRight: Radius.elliptical(64, 32))),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
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
                    AllBooks(
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