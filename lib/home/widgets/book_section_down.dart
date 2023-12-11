// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:books_buddy/home/models/book_models.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookSectionDown extends StatelessWidget {
  final String url;
  const BookSectionDown({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
  Future<List<Books>> fetchBooks() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var response = await http.get(
      Uri.parse(widget.url),
      headers: {"Content-Type": "application/json"},
    ); 

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Books> listRandomBooks = [];
    for (var book in data) {
      if (book != null) {
        listRandomBooks.add(Books.fromJson(book));
      }
    }
    return listRandomBooks;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: fetchBooks(),
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
            return SizedBox(
              height: 200 * snapshot.data!.length / 1,
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  String title = snapshot.data![index].fields.title;
                  String subTitle = (title.length <= 32)
                      ? title
                      : "${title.substring(0, 32)}...";
                  String authors = snapshot.data![index].fields.authors;
                  String subAuthors = (authors.length <= 20)
                      ? authors
                      : "${authors.substring(0, 20)}...";
                  return GestureDetector(
                    onTap: () {},
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 10),
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
                                  "${snapshot.data![index].fields.thumbnail}",
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
                                            fontWeight: FontWeight.bold),
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
                                        snapshot
                                            .data![index].fields.description,
                                        style: defaultText.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300),
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
                                        snapshot
                                            .data![index].fields.averageRating.toString(),
                                        style: defaultText.copyWith(
                                          fontSize: 14,
                                        ),
                                      ),
                                      Text("• With ${snapshot
                                            .data![index].fields.ratingsCount.toString()} Rate Count", style: defaultText.copyWith(fontSize: 10, color: Colors.black54),),
                                      Expanded(
                                        child: Text(
                                          snapshot
                                              .data![index].fields.publishedDate
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
