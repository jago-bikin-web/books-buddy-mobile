import 'dart:convert';

import 'package:books_buddy/mybuddy/models/own_book_models.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookSection extends StatelessWidget {
  final String heading;
  final String url;
  const BookSection({super.key, required this.heading, required this.url});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            heading,
            style: defaultText.copyWith(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        BookSectionBuilder(
          url: url,
        ),
      ],
    );
  }
}

class BookSectionBuilder extends StatefulWidget {
  final String url;
  const BookSectionBuilder({super.key, required this.url});

  @override
  State<BookSectionBuilder> createState() => _BookSectionBuilderState();
}

class _BookSectionBuilderState extends State<BookSectionBuilder> {
  Future<List<OwnBooks>> fetchBooks() async {
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

  late Future<List<OwnBooks>> _data;

  @override
  void initState() {
    super.initState();
    _data = fetchBooks();
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
            ),
          );
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
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
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
                          height: 8,
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
              );
            }
            return SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  String title = snapshot.data![index].title;
                  String subTitle = (title.length <= 12)
                      ? title
                      : "${title.substring(0, 12)}...";
                  String authors = snapshot.data![index].authors;
                  String subAuthors = (authors.length <= 12)
                      ? authors
                      : "${authors.substring(0, 12)}...";
                  return Row(
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(
                              top: 10,
                              left: 5,
                            ),
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.3,
                            child: Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    boxShadow: <BoxShadow>[
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.4),
                                        blurRadius: 5,
                                        offset: const Offset(8, 8),
                                        spreadRadius: 1,
                                      )
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      "${snapshot.data![index].thumbnail}",
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      0.27,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.black.withOpacity(0.4),
                                        Colors.transparent,
                                        Colors.black.withOpacity(0.4),
                                      ],
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(
                            subTitle,
                            style: defaultText.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            subAuthors,
                            style: defaultText.copyWith(
                              fontSize: 12,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                    ],
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
