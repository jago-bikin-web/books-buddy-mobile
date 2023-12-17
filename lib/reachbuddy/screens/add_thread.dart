import 'package:books_buddy/shared/shared.dart';
import 'package:books_buddy/shared/page.dart';
import 'package:books_buddy/findbuddy/screens/findbuddy.dart';
import 'package:books_buddy/home/models/book_models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';

class AddThread extends StatefulWidget {
  final Books? book;
  const AddThread({super.key, required this.book});

  @override
  State<AddThread> createState() => _AddThreadState();
}

class _AddThreadState extends State<AddThread> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _controller = TextEditingController();
  String _review = "";

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: backgroundColour, // Replace with your background color
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
              'New Thread',
              style: defaultText.copyWith(
                fontSize: 24,
              ),
            ),
            actions: [
              ElevatedButton(
                  child: Text(
                    'Post',
                    style: defaultText.copyWith(
                      color: whiteColour,
                      fontSize: 18,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColour,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: (widget.book == null || _review.isEmpty) ? null : () {}
                  ),
              SizedBox(width: 10)
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                          "https://lh3.googleusercontent.com/ogw/ANLem4ZbY8Sgfn4eFNL5PA-7d8A3wXO1DFwh8Q9zaK3u1Q=s32-c-mo"),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        onChanged: (value) {
                          setState(() {
                            _review = value;
                          });
                        },
                        decoration: InputDecoration(
                            hintText: "What is your view?",
                            border: InputBorder.none,
                            hintStyle: defaultText.copyWith(
                                fontSize: 14, color: Colors.grey)),
                        maxLines: null,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Center(
                  child: widget.book == null
                      ? Consumer<PageProvider>(
                          builder: (context, pageProvider, child) => Container(
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: gradient),
                            child: ElevatedButton(
                              onPressed: () {
                                // Use pageProvider to navigate
                                pageProvider.setPage(2);
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                'Choose the Book',
                                style: defaultText.copyWith(
                                    color: backgroundColour, fontSize: 20),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            height: 160,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: primaryColour.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                      color: Colors.black26,
                                      spreadRadius: 2,
                                      blurRadius: 8,
                                      offset: Offset(2, 2),
                                    )
                                  ]),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      widget.book!.fields.thumbnail,
                                      width: 100,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            widget.book!.fields.title.length >
                                                    32
                                                ? "${widget.book!.fields.title.substring(0, 32)}..."
                                                : widget.book!.fields.title,
                                            style: defaultText.copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            widget.book!.fields.authors.length >
                                                    20
                                                ? "By ${widget.book!.fields.authors.substring(0, 20)}..."
                                                : "By ${widget.book!.fields.authors}",
                                            style: defaultText.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          physics: BouncingScrollPhysics(),
                                          child: Text(
                                            widget.book!.fields.description,
                                            style: defaultText.copyWith(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w300,
                                            ),
                                            textAlign: TextAlign.justify,
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star_border_rounded,
                                            color: primaryColour,
                                          ),
                                          Text(
                                            widget.book!.fields.averageRating
                                                .toString(),
                                            style: defaultText.copyWith(
                                              fontSize: 14,
                                            ),
                                          ),
                                          Text(
                                            "• With ${widget.book!.fields.ratingsCount.toString()} Rate Count",
                                            style: defaultText.copyWith(
                                                fontSize: 10,
                                                color: Colors.black54),
                                          ),
                                          Expanded(
                                            child: Text(
                                              widget.book!.fields.publishedDate
                                                  .toString()
                                                  .substring(0, 4),
                                              textAlign: TextAlign.end,
                                              style: defaultText.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                )
              ],
            ),
          ),
        ));
  }
}
