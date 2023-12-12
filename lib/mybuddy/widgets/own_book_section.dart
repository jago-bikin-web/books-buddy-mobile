// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:books_buddy/mybuddy/models/own_book_models.dart';
import 'package:books_buddy/mybuddy/screens/udpatebook.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class OwnBookSection extends StatelessWidget {
  final String url;
  const OwnBookSection({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        OwnBookBuilder(
          url: url,
        ),
      ],
    );
  }
}

class OwnBookBuilder extends StatefulWidget {
  final String url;
  const OwnBookBuilder({super.key, required this.url});

  @override
  State<OwnBookBuilder> createState() => _OwnBookBuilderState();
}

class _OwnBookBuilderState extends State<OwnBookBuilder> {
  late Future<List<OwnBooks>> _data;

  @override
  void initState() {
    super.initState();
    _data = fetchBooks();
  }

  Future<List<OwnBooks>> fetchBooks() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var response = await http.get(
      Uri.parse(widget.url),
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<OwnBooks> listRandomBooks = [];

    for (var book in data) {
      if (book != null) {
        listRandomBooks.add(OwnBooks.fromJson(book));
      }
    }

    return listRandomBooks;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _data,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return Center(
              child: CircularProgressIndicator(
            color: primaryColour,
          ));
        } else {
          if (!snapshot.hasData) {
            return Column(
              children: [
                Text(
                  "Tidak ada data produk.",
                  style: TextStyle(color: primaryColour, fontSize: 20),
                ),
                SizedBox(height: 8),
              ],
            );
          } else {
            if (snapshot.data!.length == 0) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2 + 160,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/not-found.png",
                        height: 150,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Let's enrich My Buddy together by adding your favorite books!",
                        style: defaultText.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              );
            }
            return SizedBox(
              height: 228 * snapshot.data!.length / 1,
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  String title = snapshot.data![index].title;
                  String subTitle = (title.length <= 32)
                      ? title
                      : "${title.substring(0, 32)}...";
                  String authors = snapshot.data![index].authors;
                  String subAuthors = (authors.length <= 24)
                      ? authors
                      : "${authors.substring(0, 24)}...";

                  String ulasan = snapshot.data![index].ulasan;
                  String subUlasan = ulasan.isEmpty
                      ? "Looks like you haven't reviewed this book yet."
                      : ulasan;
                  return GestureDetector(
                    onTap: () async {
                      final result = await showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (context) {
                          return UpdateModal(
                            context,
                            book: snapshot.data![index],
                          );
                        },
                      );

                      if (result) {
                        setState(() {
                          _data = fetchBooks();
                        });
                      }
                    },
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                      child: Container(
                        height: 180,
                        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
                        decoration: BoxDecoration(
                          color: primaryColour.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
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
                                  snapshot.data![index].thumbnail,
                                  width: 110,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              flex: 5,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        subTitle,
                                        style: defaultText.copyWith(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "By $subAuthors",
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
                                        snapshot.data![index].description,
                                        style: defaultText.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Review",
                                        style: defaultText.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 33,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          physics: BouncingScrollPhysics(),
                                          child: Text(
                                            subUlasan,
                                            style: defaultText.copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300),
                                            textAlign: TextAlign.justify,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 20,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 1.5),
                                          decoration: BoxDecoration(
                                            color: primaryColour,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Text(
                                            snapshot.data![index].status,
                                            style: defaultText.copyWith(
                                              color: backgroundColour,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Spacer(),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: primaryColour.withOpacity(0.65),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () async {
                                            await http.patch(
                                                Uri.parse(
                                                    "http://127.0.0.1:8000/mybuddy/add-page-track/"),
                                                headers: {
                                                  "Content-Type":
                                                      "application/json"
                                                },
                                                body:
                                                    jsonEncode(<String, String>{
                                                  'pk': snapshot.data![index].pk
                                                      .toString(),
                                                }));
                                            setState(() {
                                              _data = fetchBooks();
                                            });
                                          },
                                          child: Container(
                                            width: 35,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Icon(
                                              Icons.arrow_drop_up_rounded,
                                            ),
                                          ),
                                        ),
                                        Text(
                                          snapshot.data![index].pageTrack
                                              .toString(),
                                          style: defaultText.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            await http.patch(
                                                Uri.parse(
                                                    "http://127.0.0.1:8000/mybuddy/sub-page-track/"),
                                                headers: {
                                                  "Content-Type":
                                                      "application/json"
                                                },
                                                body:
                                                    jsonEncode(<String, String>{
                                                  'pk': snapshot.data![index].pk
                                                      .toString(),
                                                }));
                                            setState(() {
                                              _data = fetchBooks();
                                            });
                                          },
                                          child: Container(
                                            width: 35,
                                            height: 35,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            child: Icon(
                                                Icons.arrow_drop_down_rounded),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Text(
                                    snapshot.data![index].publishedDate
                                        .toString()
                                        .substring(0, 4),
                                    textAlign: TextAlign.end,
                                    style: defaultText.copyWith(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        }
      },
    );
  }
}
