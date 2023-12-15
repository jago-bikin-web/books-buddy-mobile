// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, deprecated_member_use, use_full_hex_values_for_flutter_colors

import 'dart:ui';

import 'package:books_buddy/home/models/book_models.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:flutter/material.dart';

class BookDisplay extends StatefulWidget {
  final Books book;
  const BookDisplay({super.key, required this.book});

  @override
  State<BookDisplay> createState() => _BookDisplayState();
}

class _BookDisplayState extends State<BookDisplay> {
  @override
  Widget build(BuildContext context) {
    Books book = widget.book;
    String subTitle = book.fields.title.length > 56
        ? book.fields.title.substring(0, 56) + "..."
        : book.fields.title;
    String subAuthors = book.fields.authors.length > 55
        ? book.fields.authors.substring(0, 55) + "..."
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
                        SizedBox(
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
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 10,
                                sigmaY: 10,
                              ),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10),
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
                                        SizedBox(
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
                                        SizedBox(
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
                                        SizedBox(
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
                                        SizedBox(
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
                            SizedBox(
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
                          Container(
                            height: 40,
                            width: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: primaryColour),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              child: Text(
                                "Back",
                                style: defaultText.copyWith(
                                    fontSize: 16, color: backgroundColour),
                              ),
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 180,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: primaryColour),
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              child: Text(
                                "Add Collection",
                                style: defaultText.copyWith(
                                    fontSize: 16, color: backgroundColour),
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
