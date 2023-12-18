import 'package:books_buddy/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:books_buddy/home/models/book_models.dart';
import 'package:google_fonts/google_fonts.dart';

class BooksDetailPage extends StatelessWidget {
  final Books books;
  const BooksDetailPage({Key? key, required this.books}) : super(key: key);

  // @override
  // Widget build(BuildContext context) {
  //   List<String> categories = books.fields.categories.split(',');

  //   String getLanguageDisplayName(String languageCode) {
  //     if (languageCode.toLowerCase() == 'en') {
  //       return 'English';
  //     } else if (languageCode.toLowerCase() == 'id') {
  //       return 'Bahasa Indonesia';
  //     } else {
  //       return languageCode; // Jika bukan 'en' atau 'id', kembalikan nilainya tanpa perubahan
  //     }
  //   }

  //   return Scaffold(
  //     body: SingleChildScrollView(
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           SizedBox(height: 16),
  //           Padding(
  //             padding: EdgeInsets.only(
  //                 left: 16.0), // Ubah nilai sesuai dengan kebutuhan jarak
  //             child: Align(
  //               alignment: Alignment.topLeft,
  //               child: ElevatedButton.icon(
  //                 onPressed: () => Navigator.pop(context),
  //                 icon: Icon(
  //                   Icons.arrow_back,
  //                   color: Colors.black, // Warna ikon
  //                 ),
  //                 label: Text(''), // Tidak perlu label karena tombol tanpa teks
  //                 style: ElevatedButton.styleFrom(
  //                   primary: Colors.orange, // Warna latar belakang
  //                 ),
  //               ),
  //             ),
  //           ),
  //           SizedBox(height: 16),
  //           Center(
  //             child: Image.network(
  //               '${books.fields.thumbnail}',
  //               height: 150,
  //             ),
  //           ),
  //           Padding(
  //             padding: EdgeInsets.all(16),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.center,
  //               children: [
  //                 Text(
  //                   '${books.fields.title}',
  //                   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
  //                   textAlign: TextAlign.center,
  //                 ),
  //                 SizedBox(height: 8),
  //                 Text(
  //                   '${books.fields.authors}',
  //                   style: TextStyle(fontSize: 18),
  //                   textAlign: TextAlign.center,
  //                 ),
  //                 SizedBox(height: 8),
  //                 Wrap(
  //                   spacing: 8.0, // Adjust the spacing between chips
  //                   children: categories.map((category) {
  //                     return Container(
  //                       decoration: BoxDecoration(
  //                         color: Color.fromARGB(255, 255, 164, 36),
  //                         borderRadius: BorderRadius.circular(20),
  //                       ),
  //                       padding: EdgeInsets.symmetric(
  //                         horizontal: 12,
  //                         vertical: 4,
  //                       ),
  //                       child: Text(
  //                         category.trim(),
  //                         style: TextStyle(fontSize: 16),
  //                       ),
  //                     );
  //                   }).toList(),
  //                 ),
  //                 SizedBox(height: 8),
  //                 Text(
  //                   'Publisher: ${books.fields.publisher}',
  //                   style: TextStyle(fontSize: 16),
  //                 ),
  //                 Text(
  //                   'Published Date: ${books.fields.publishedDate.toLocal().toString().substring(0, 10)}',
  //                   style: TextStyle(fontSize: 16),
  //                 ),
  //                 Text(
  //                   'Page Count: ${books.fields.pageCount}',
  //                   style: TextStyle(fontSize: 16),
  //                 ),
  //                 Text(
  //                   'Categories: ${books.fields.categories}',
  //                   style: TextStyle(fontSize: 16),
  //                 ),
  //                 Text(
  //                   'Ratings: ${books.fields.averageRating}',
  //                   style: TextStyle(fontSize: 16),
  //                 ),
  //                 Text(
  //                   'Language: ${getLanguageDisplayName(books.fields.language)}',
  //                   style: TextStyle(fontSize: 16),
  //                 ),
  //                 SizedBox(height: 20),
  //                 Container(
  //                   padding: EdgeInsets.all(16),
  //                   decoration: BoxDecoration(
  //                     color: Color.fromARGB(255, 255, 164, 36),
  //                     borderRadius: BorderRadius.circular(10),
  //                   ),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       SizedBox(height: 8),
  //                       Text(
  //                         '${books.fields.description}',
  //                         style: TextStyle(fontSize: 16),
  //                         textAlign: TextAlign.justify,
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    List<String> categories = books.fields.categories.split(',');

    String getLanguageDisplayName(String languageCode) {
      if (languageCode.toLowerCase() == 'en') {
        return 'English';
      } else if (languageCode.toLowerCase() == 'id') {
        return 'Bahasa Indonesia';
      } else {
        return languageCode; // Jika bukan 'en' atau 'id', kembalikan nilainya tanpa perubahan
      }
    }

    return (Scaffold(
      backgroundColor: primaryColour,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        opacity: 0.4,
                        image: AssetImage("assets/overlay.png"),
                        fit: BoxFit.cover)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 30,
                      ),
                    ),
                    Text(
                      "DETAILS",
                      style: GoogleFonts.lato(
                          textStyle:
                              TextStyle(color: Colors.black, fontSize: 16)),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          opacity: 0.4,
                          image: AssetImage("assets/overlay.png"),
                          fit: BoxFit.cover)),
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
                                  '${books.fields.thumbnail}',
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          '${books.fields.title}',
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 23,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                        ),
                        Text(
                          "by " + '${books.fields.authors}',
                          style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                  fontSize: 15, color: const Color.fromARGB(255, 72, 72, 72))),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text(
                                  "Rating",
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontSize: 15,
                                          color: const Color.fromARGB(255, 72, 72, 72))),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${books.fields.averageRating}',
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.black)),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Pages",
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontSize: 15,
                                          color: const Color.fromARGB(255, 72, 72, 72))),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${books.fields.pageCount}',
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.black)),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Language",
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontSize: 15,
                                          color: const Color.fromARGB(255, 72, 72, 72))),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${getLanguageDisplayName(books.fields.language)}',
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Colors.black)),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Publish date",
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontSize: 15,
                                          color: const Color.fromARGB(255, 72, 72, 72))),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${books.fields.publishedDate.toLocal().toString().substring(0, 10)}',
                                  style: GoogleFonts.lato(
                                      textStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.black)),
                                )
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )),
            Expanded(
                flex: 2,
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 28.0, vertical: 25),
                        child: ListView(
                          children: [
                            Text(
                              "What's it about?",
                              style: GoogleFonts.lato(
                                  textStyle: TextStyle(
                                color: Colors.grey[900],
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              )),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${books.fields.description}',
                              style: GoogleFonts.lato(
                                  color: const Color.fromARGB(255, 72, 72, 72), fontSize: 15),
                            )
                          ],
                        ),
                      ))
                    ],
                  ),
                )),
          ],
        ),
      ),
    ));
  }
}
