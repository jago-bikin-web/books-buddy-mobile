// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:ui';

import 'package:books_buddy/auth/models/user_models.dart';
import 'package:books_buddy/auth/widgets/simplealertdialog.dart';
import 'package:books_buddy/eventbuddy/screens/create_event.dart';
import 'package:books_buddy/home/models/book_models.dart';
import 'package:books_buddy/reachbuddy/screens/add_thread.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class BookDisplay extends StatefulWidget {
  final Books book;
  const BookDisplay({super.key, required this.book});

  @override
  State<BookDisplay> createState() => _BookDisplayState();
}

class _BookDisplayState extends State<BookDisplay> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    Books book = widget.book;
    String subTitle = book.fields.title.length > 56
        ? "${book.fields.title.substring(0, 56)}..."
        : book.fields.title;
    String subAuthors = book.fields.authors.length > 55
        ? "${book.fields.authors.substring(0, 55)}..."
        : book.fields.authors;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(gradient: gradient),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    color: backgroundColour,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_back_rounded,
                                    size: 30,
                                    color: primaryColour,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 230,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                book.fields.thumbnail,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            subTitle,
                            style: defaultText.copyWith(
                              fontSize: 23,
                              color: blackColour,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          "by $subAuthors",
                          style: defaultText.copyWith(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 10,
                                sigmaY: 10,
                              ),
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: backgroundColour.withOpacity(0.3),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "Rating",
                                          style: defaultText.copyWith(
                                            fontSize: 15,
                                            color: blackColour,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          book.fields.averageRating.toString(),
                                          style: defaultText.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: whiteColour,
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Pages",
                                          style: defaultText.copyWith(
                                            fontSize: 15,
                                            color: blackColour,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          book.fields.pageCount.toString(),
                                          style: defaultText.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: whiteColour,
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Language",
                                          style: defaultText.copyWith(
                                            fontSize: 15,
                                            color: blackColour,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          book.fields.language != ""
                                              ? book.fields.language
                                                  .toUpperCase()
                                              : "Not Available",
                                          style: defaultText.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: whiteColour,
                                          ),
                                        )
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Publish date",
                                          style: defaultText.copyWith(
                                            fontSize: 15,
                                            color: blackColour,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          book.fields.publishedDate
                                              .toString()
                                              .substring(0, 10),
                                          style: defaultText.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: whiteColour,
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                )),
            Expanded(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: backgroundColour,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 24, right: 24),
                      child: Container(
                        height: 30,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 1.5),
                        decoration: BoxDecoration(
                          color: primaryColour,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                            book.fields.categories,
                            style: defaultText.copyWith(
                              color: backgroundColour,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28.0, vertical: 10),
                        child: ListView(
                          children: [
                            Text(
                              "What's it about?",
                              style: defaultText.copyWith(
                                color: primaryColour,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              book.fields.description,
                              style: defaultText.copyWith(
                                color: blackColour,
                                fontSize: 15,
                              ),
                              textAlign: TextAlign.justify,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (logInUser!.role == "M")
                            Container(
                              height: 40,
                              width: 120,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: primaryColour),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CreateEvent(
                                        book: book,
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                                child: Text(
                                  "Add Event",
                                  style: defaultText.copyWith(
                                      fontSize: 13,
                                      color: backgroundColour,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          if (logInUser!.role == "M")
                            Container(
                              height: 40,
                              width: 135,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: primaryColour),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddThread(
                                        book: book,
                                      ),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    shadowColor: Colors.transparent,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                                child: Text(
                                  "Add Thread",
                                  style: defaultText.copyWith(
                                      fontSize: 13,
                                      color: backgroundColour,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          Container(
                            height: 40,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: primaryColour),
                            child: ElevatedButton(
                              onPressed: () async {
                                // TODO : INTEGRASIKAN LINK
                                final response = await request.postJson(
                                  "http://127.0.0.1:8000/mybuddy/add-book-flutter/",
                                  jsonEncode(
                                    <String, String>{
                                      'pk': '${book.pk}',
                                      'username': logInUser!.username
                                    },
                                  ),
                                );

                                if (response["status"]) {
                                  await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return const SimpleAlertDialog(
                                        imageAsset: "assets/images/save.png",
                                        title: "Success",
                                        message:
                                            "The book has been added to My Buddy",
                                      );
                                    },
                                  );

                                  Navigator.pop(context);
                                } else {
                                  String message = response["message"];
                                  await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SimpleAlertDialog(
                                        imageAsset: "assets/images/denied.png",
                                        title: "Failed",
                                        message: message,
                                      );
                                    },
                                  );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              child: Text(
                                "Add Collection",
                                style: defaultText.copyWith(
                                    fontSize: 13,
                                    color: backgroundColour,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
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
