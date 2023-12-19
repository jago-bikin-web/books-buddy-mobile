import 'package:books_buddy/findbuddy/screens/request_book.dart';
import 'package:books_buddy/findbuddy/widgets/book_section.dart';
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
      child: Scaffold(
        body: Stack(
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
                  const TopBar(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
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
                  const BookSection(),
                  const SizedBox(
                    height: 60,
                  )
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: FloatingActionButton(
            hoverColor: primaryColour.withOpacity(0.2),
            hoverElevation: 5,
            elevation: 3,
            shape: const CircleBorder(),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const RequestBook(),
              ));
            },
            backgroundColor: primaryColour, // Replace with your primary color
            child: const Icon(
              Icons.add_rounded,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}
