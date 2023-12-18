import 'package:books_buddy/auth/models/user_models.dart';
import 'package:books_buddy/mybuddy/widgets/app_bar.dart';
import 'package:books_buddy/mybuddy/widgets/floating_button.dart';
import 'package:books_buddy/mybuddy/widgets/own_book_section.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:flutter/material.dart';

class MyBuddy extends StatefulWidget {
  const MyBuddy({super.key});

  @override
  State<MyBuddy> createState() => _MyBuddyState();
}

class _MyBuddyState extends State<MyBuddy> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 500),
  )..forward();
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0.0, 0.5),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

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
                          "Your Collection",
                          style: defaultText.copyWith(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      OwnBookSection(
                          // TODO : INTEGRASIKAN LINK
                          url:
                              "http://127.0.0.1:8000/mybuddy/get-own-book/?username=${logInUser!.username}")
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
        floatingActionButton: FloatingButtonAdd(
          animation: _offsetAnimation,
          toPage: 2,
        ),
      ),
    );
  }
}
