// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:books_buddy/findbuddy/screens/displaybook.dart';
import 'package:books_buddy/home/models/book_models.dart';
import 'package:books_buddy/mybuddy/widgets/chip_filter.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookSection extends StatefulWidget {
  const BookSection({super.key});

  @override
  State<BookSection> createState() => _BookSectionState();
}

class _BookSectionState extends State<BookSection> {
  String query = "";
  String filter = " All ";

  final List<String> _dataCategory = [
    " All ",
    "Action",
    "Adventure",
    "Biography & Autobiography",
    "Business & Economics",
    "Comics & Graphic Novels",
    "Education",
    "Family & Relationships",
    "Fiction",
    "History",
    "Language Arts & Disciplines",
    "Philosophy",
    "Science",
    "Social Science",
    "Music",
    "Juvenile Fiction",
    "Technology & Engineering",
    "Children's stories",
    "Computers",
    "Cooking",
    "Medical",
    "Psychology",
    "Juvenile Nonfiction",
    "Health & Fitness",
  ];

  late Future<List<Books>> _data;

  Future<List<Books>> fetchBooks(url) async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var response = await http.get(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Books> listBooks = [];

    for (var book in data) {
      if (book != null) {
        listBooks.add(Books.fromJson(book));
      }
    }

    return listBooks;
  }

  @override
  void initState() {
    super.initState();
    _dataCategory.sort();
    _data = fetchBooks(
        "http://127.0.0.1:8000/findbuddy/get-search-books/?query=$query&filter=$filter");
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: primaryColour.withOpacity(0.2),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: primaryColour, width: 2),
              ),
              hintText: "eg: Tanah Para Bedebah",
              prefixIcon: Icon(
                Icons.search_rounded,
                color: blackColour,
              ),
            ),
            onChanged: (value) {
              setState(() {
                query = value;
                _data = fetchBooks(
                    "http://127.0.0.1:8000/findbuddy/get-search-books/?query=$query&filter=$filter");
              });
            },
          ),
          SizedBox(
            height: 8,
          ),
          SizedBox(
            height: 30,
            child: ListView.builder(
              itemCount: _dataCategory.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        filter = _dataCategory[index];
                        _data = fetchBooks(
                            "http://127.0.0.1:8000/findbuddy/get-search-books/?query=$query&filter=$filter");
                      });
                    },
                    child: ChipFilter(
                      filter: filter,
                      text: _dataCategory[index],
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 8,
          ),
          FutureBuilder(
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
                              SizedBox(
                                height: 8,
                              ),
                              Text(
                                "Books are currently unavailable. Please try another option.",
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
                    height: 200 * snapshot.data!.length / 1 -
                        (19 * snapshot.data!.length) +
                        50,
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BookDisplay(
                                  book: snapshot.data![index],
                                ),
                              ),
                            );
                          },
                          child: Padding(
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
                                        snapshot.data![index].fields.thumbnail,
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
                                              snapshot.data![index].fields
                                                  .description,
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
                                              snapshot.data![index].fields
                                                  .averageRating
                                                  .toString(),
                                              style: defaultText.copyWith(
                                                fontSize: 14,
                                              ),
                                            ),
                                            Text(
                                              "• With ${snapshot.data![index].fields.ratingsCount.toString()} Rate Count",
                                              style: defaultText.copyWith(
                                                  fontSize: 10,
                                                  color: Colors.black54),
                                            ),
                                            Expanded(
                                              child: Text(
                                                snapshot.data![index].fields
                                                    .publishedDate
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
          ),
        ],
      ),
    );
  }
}
