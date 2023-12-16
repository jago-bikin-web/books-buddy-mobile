// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:books_buddy/eventbuddy/screens/book_for_event.dart';
import 'package:books_buddy/eventbuddy/screens/event_form.dart';
import 'package:books_buddy/eventbuddy/widgets/event_list.dart';
import 'package:books_buddy/mybuddy/widgets/app_bar.dart';
import 'package:books_buddy/mybuddy/widgets/own_book_section.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:flutter/material.dart';

class EventBuddy extends StatefulWidget {
  const EventBuddy({super.key});

  @override
  State<EventBuddy> createState() => _EventBuddyState();
}

class _EventBuddyState extends State<EventBuddy>
    with SingleTickerProviderStateMixin {
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
                          "Join Our Exciting Events!",
                          style: defaultText.copyWith(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      EventSection()
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
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 60),
          child: FloatingActionButton(
            hoverColor: primaryColour.withOpacity(0.2),
            hoverElevation: 5,
            elevation: 3,
            shape: const CircleBorder(),
            onPressed: () {
            // Navigasi ke halaman penambahan event
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventBook(), // Ganti dengan halaman penambahan event yang sesuai
              ),
            );
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
