// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:books_buddy/shared/shared.dart';
import 'package:books_buddy/shared/page.dart';
import 'package:books_buddy/auth/models/user_models.dart';
import 'package:books_buddy/home/models/book_models.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class AddThread extends StatefulWidget {
  final Books? book;
  const AddThread({super.key, required this.book});

  @override
  State<AddThread> createState() => _AddThreadState();
}

class _AddThreadState extends State<AddThread> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController();
  String _review = "";

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      backgroundColor: backgroundColour,
      body: Container(
          color: backgroundColour,
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SafeArea(
                    child: Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        Expanded(
                          child: Text(
                            'New Thread',
                            style: defaultText.copyWith(
                              fontSize: 24,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Consumer<PageProvider>(
                          builder: (context, pageProvider, child) =>
                              ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColour,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            onPressed: (widget.book == null || _review.isEmpty)
                                ? null
                                : () async {
                                    if (_formKey.currentState!.validate()) {
                                      final response = await request.postJson(
                                        "https://books-buddy-e06-tk.pbp.cs.ui.ac.id/reachbuddy/create-thread-flutter/",
                                        jsonEncode(
                                          <String, String>{
                                            'username': logInUser!.username,
                                            'pkBook':
                                                widget.book!.pk.toString(),
                                            'review': _review,
                                          },
                                        ),
                                      );

                                      if (response["status"]) {
                                        Navigator.pop(context);
                                      }

                                      _formKey.currentState!.reset();
                                    }
                                  },
                            child: Text(
                              'Post',
                              style: defaultText.copyWith(
                                color: whiteColour,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            NetworkImage(logInUser!.profilePicture),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextFormField(
                          controller: _controller,
                          onChanged: (String? value) {
                            setState(() {
                              _review = value!;
                            });
                          },
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Required!";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: "What is your view?",
                            border: InputBorder.none,
                            hintStyle: defaultText.copyWith(
                              fontSize: 17,
                              color: Colors.grey,
                            ),
                          ),
                          maxLines: null,
                        ),
                      ),
                    ],
                  ),
                  // ... Rest of your widgets
                  const SizedBox(height: 20),
                  Center(
                    child: widget.book == null
                        ? Consumer<PageProvider>(
                            builder: (context, pageProvider, child) =>
                                Container(
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
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                child: Text(
                                  'Choose the Book',
                                  style: defaultText.copyWith(
                                      color: backgroundColour, fontSize: 20),
                                ),
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Container(
                              height: 160,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: primaryColour.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: const BoxDecoration(boxShadow: [
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
                                  const SizedBox(
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
                                              widget.book!.fields.authors
                                                          .length >
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
                                            physics:
                                                const BouncingScrollPhysics(),
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
                                                widget
                                                    .book!.fields.publishedDate
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
          )),
    );
  }
}
