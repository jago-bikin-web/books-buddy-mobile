import 'package:books_buddy/mybuddy/models/own_book_models.dart';
import 'package:flutter/material.dart';
import 'package:books_buddy/shared/shared.dart';

class ReviewModal extends StatefulWidget {
  final BuildContext context;
  final OwnBooks book;
  const ReviewModal(this.context, {super.key, required this.book});

  @override
  State<ReviewModal> createState() => _ReviewModalState();
}

class _ReviewModalState extends State<ReviewModal> {
  String convertUlasan(ulasan) {
    return ulasan.isEmpty
        ? "Looks like you haven't reviewed this book yet."
        : ulasan;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                color: backgroundColour,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 25,
                    ),
                    Text(
                      "Review",
                      style: defaultText.copyWith(
                          fontSize: 32,
                          color: primaryColour,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          decoration: const BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 2,
                                blurRadius: 8,
                                offset: Offset(2, 2),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              widget.book.thumbnail,
                              width: 110,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          height: 70,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            child: Text(
                              widget.book.description,
                              style: defaultText.copyWith(
                                  fontSize: 12, fontWeight: FontWeight.w300),
                              textAlign: TextAlign.justify,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(14),
                      width: MediaQuery.of(context).size.width - 24 * 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: primaryColour.withOpacity(0.2),
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          convertUlasan(widget.book.ulasan),
                          style: defaultText.copyWith(fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 40,
                      width: 120,
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
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
