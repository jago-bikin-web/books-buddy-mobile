import 'dart:convert';

import 'package:books_buddy/mybuddy/models/own_book_models.dart';
import 'package:books_buddy/mybuddy/screens/reviewbook.dart';
import 'package:books_buddy/mybuddy/screens/udpatebook.dart';
import 'package:books_buddy/mybuddy/widgets/chip_filter.dart';
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

  String filter = "All";
  final List<String> _filterCategory = [
    "All",
    "Wishlist",
    "Reading",
    "Finished",
  ];

  @override
  void initState() {
    super.initState();
    _data = fetchBooks(filter);
  }

  Future<List<OwnBooks>> fetchBooks(filter) async {
    var response = await http.get(
      Uri.parse(widget.url),
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<OwnBooks> books = [];

    if (filter == "All") {
      for (var book in data) {
        if (book != null) {
          books.add(OwnBooks.fromJson(book));
        }
      }
    } else {
      for (var book in data) {
        if (book != null && book["status"] == filter) {
          books.add(OwnBooks.fromJson(book));
        }
      }
    }
    books.sort((a, b) => a.pk.compareTo(b.pk));
    return books;
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
                const SizedBox(height: 8),
              ],
            );
          } else {
            if (snapshot.data!.length == 0) {
              return Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 3),
                    child: SizedBox(
                      height: 30,
                      child: ListView.builder(
                        itemCount: _filterCategory.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  filter = _filterCategory[index];
                                  _data = fetchBooks(filter);
                                });
                              },
                              child: ChipFilter(
                                filter: filter,
                                text: _filterCategory[index],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
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
                          const SizedBox(
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
                  ),
                ],
              );
            }
            return Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 3),
                  child: SizedBox(
                    height: 30,
                    child: ListView.builder(
                      itemCount: _filterCategory.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                filter = _filterCategory[index];
                                _data = fetchBooks(filter);
                              });
                            },
                            child: ChipFilter(
                              filter: filter,
                              text: _filterCategory[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  height: 210 * snapshot.data!.length / 1 -
                      (10 * snapshot.data!.length) +
                      80,
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

                          if (result == null) return;

                          if (result) {
                            setState(() {
                              _data = fetchBooks(filter);
                            });
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Container(
                            height: 180,
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 10),
                            decoration: BoxDecoration(
                              color: primaryColour.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
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
                                      snapshot.data![index].thumbnail,
                                      width: 110,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  flex: 7,
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
                                          physics:
                                              const BouncingScrollPhysics(),
                                          child: Text(
                                            snapshot.data![index].description,
                                            style: defaultText.copyWith(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w300),
                                            textAlign: TextAlign.justify,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 90,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 1.5),
                                                decoration: BoxDecoration(
                                                  color: whiteColour,
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    snapshot
                                                        .data![index].status,
                                                    style: defaultText.copyWith(
                                                      color: primaryColour,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 6,
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  showModalBottomSheet(
                                                    context: context,
                                                    isScrollControlled: true,
                                                    builder: (context) {
                                                      return ReviewModal(
                                                        context,
                                                        book: snapshot
                                                            .data![index],
                                                      );
                                                    },
                                                  );
                                                },
                                                child: Container(
                                                  height: 30,
                                                  width: 90,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10,
                                                      vertical: 1.5),
                                                  decoration: BoxDecoration(
                                                    color: primaryColour
                                                        .withOpacity(0.9),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      "Review",
                                                      style:
                                                          defaultText.copyWith(
                                                        color: backgroundColour,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 160,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2),
                                        decoration: BoxDecoration(
                                          color: primaryColour.withOpacity(0.9),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                await http.patch(
                                                    Uri.parse(
                                                        "https://books-buddy-e06-tk.pbp.cs.ui.ac.id/mybuddy/add-page-track/"),
                                                    headers: {
                                                      "Content-Type":
                                                          "application/json"
                                                    },
                                                    body: jsonEncode(<String,
                                                        String>{
                                                      'pk': snapshot
                                                          .data![index].pk
                                                          .toString(),
                                                    }));
                                                setState(() {
                                                  _data = fetchBooks(filter);
                                                });
                                              },
                                              child: Container(
                                                width: 35,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                child: Image.asset(
                                                    "assets/images/panah_atas.png"),
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              "PAGE",
                                              style: defaultText.copyWith(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold,
                                                color: whiteColour,
                                              ),
                                            ),
                                            Text(
                                              snapshot.data![index].pageTrack
                                                  .toString(),
                                              style: defaultText.copyWith(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: whiteColour,
                                              ),
                                            ),
                                            Text(
                                              "/ ${snapshot.data![index].pageCount}"
                                                  .toString(),
                                              style: defaultText.copyWith(
                                                fontSize: 9.5,
                                                fontWeight: FontWeight.bold,
                                                color: whiteColour,
                                              ),
                                            ),
                                            const Spacer(),
                                            GestureDetector(
                                              onTap: () async {
                                                await http.patch(
                                                    Uri.parse(
                                                        "https://books-buddy-e06-tk.pbp.cs.ui.ac.id/mybuddy/sub-page-track/"),
                                                    headers: {
                                                      "Content-Type":
                                                          "application/json"
                                                    },
                                                    body: jsonEncode(<String,
                                                        String>{
                                                      'pk': snapshot
                                                          .data![index].pk
                                                          .toString(),
                                                    }));
                                                setState(() {
                                                  _data = fetchBooks(filter);
                                                });
                                              },
                                              child: Container(
                                                width: 35,
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                child: Image.asset(
                                                    "assets/images/panah_bawah.png"),
                                              ),
                                            ),
                                          ],
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
                ),
              ],
            );
          }
        }
      },
    );
  }
}
