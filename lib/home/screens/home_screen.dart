import 'package:books_buddy/auth/models/user_models.dart';
import 'package:books_buddy/home/widgets/book_section_collection.dart';
import 'package:books_buddy/home/widgets/book_section_down.dart';
import 'package:books_buddy/home/widgets/eventbuddy_right.dart';
import 'package:books_buddy/home/widgets/moduls.dart';
import 'package:books_buddy/home/widgets/photo_profile.dart';
import 'package:books_buddy/home/widgets/reachbuddy_right.dart';
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
      top: false,
      bottom: false,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 75,
              decoration: BoxDecoration(
                  color: backgroundColour,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.elliptical(64, 32),
                      bottomRight: Radius.elliptical(64, 32))),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/logo.png",
                        height: 30,
                        width: 30,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(
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
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi, ${logInUser!.fullName}",
                        style: defaultText.copyWith(
                            color: backgroundColour,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        logInUser!.username,
                        style: defaultText.copyWith(
                            fontSize: 16, color: Colors.black87),
                      )
                    ],
                  ),
                  PhotoProfile(image: logInUser!.profilePicture),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: Divider(
                color: primaryColour,
                thickness: 2,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(24),
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
                  borderRadius: const BorderRadius.only(
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
                      url:
                          "http://127.0.0.1:8000/mybuddy/get-own-book/?username=${logInUser!.username}",
                    ),
                    const SizedBox(
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
                    const BookSectionDown(
                      url: "http://127.0.0.1:8000/api/get-random/",
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        "Reach Others!",
                        style: defaultText.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const ThreadsHome(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        "What's new Books Buddy",
                        style: defaultText.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const EventHome(),
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
