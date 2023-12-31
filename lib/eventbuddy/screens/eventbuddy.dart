import 'package:books_buddy/eventbuddy/widgets/event_list.dart';
import 'package:books_buddy/mybuddy/widgets/app_bar.dart';
import 'package:books_buddy/shared/page.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                          "Join Our Exciting Events!",
                          style: defaultText.copyWith(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const EventSection()
                    ],
                  ),
                  const SizedBox(
                    height: 60,
                  )
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: Consumer<PageProvider>(
          builder: (context, pageProvider, child) => Padding(
            padding: const EdgeInsets.only(bottom: 60),
            child: FloatingActionButton(
              hoverColor: primaryColour.withOpacity(0.2),
              hoverElevation: 5,
              elevation: 3,
              shape: const CircleBorder(),
              onPressed: () {
                pageProvider.setPage(2);
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
      ),
    );
  }
}
