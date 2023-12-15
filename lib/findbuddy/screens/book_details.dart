import 'package:flutter/material.dart';
import 'package:books_buddy/home/models/book_models.dart';

class BooksDetailPage extends StatelessWidget {
  final Books books;
  const BooksDetailPage({Key? key, required this.books}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
                "assets/images/not-found.png",
                height: 150,
              ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${books.fields.title}',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${books.fields.authors}',
                    style: TextStyle(fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Publisher: ${books.fields.publisher}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Published Date: ${books.fields.publishedDate.toLocal().toString().substring(0, 10)}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Page Count: ${books.fields.pageCount}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Categories: ${books.fields.categories}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Ratings: ${books.fields.averageRating}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Language: ${books.fields.language}',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Buy Link: ${books.fields.buyLink}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 164, 36),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        Text(
                          '${books.fields.description}',
                          style: TextStyle(fontSize: 16),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Back to Findbuddy'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
