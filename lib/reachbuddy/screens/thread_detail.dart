// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:books_buddy/auth/models/user_models.dart';
import 'package:books_buddy/findbuddy/screens/displaybook.dart';
import 'package:books_buddy/home/models/book_models.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:books_buddy/shared/page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:books_buddy/reachbuddy/models/threads.dart';
import 'package:provider/provider.dart';

class ThreadDetail extends StatefulWidget {
  final Threads thread;
  const ThreadDetail({super.key, required this.thread});

  @override
  State<ThreadDetail> createState() => _ThreadDetailState();
}

class _ThreadDetailState extends State<ThreadDetail> {
  bool isLiked = false;
  Books? book;
  String randomImageAsset = "images/community1.png";

  Future<Books> fetchBook() async {
    var url = Uri.parse(
        'https://books-buddy-e06-tk.pbp.cs.ui.ac.id/reachbuddy/get-book-json-id-flutter/${widget.thread.bookId}/');
    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    return Books.fromJson(data[0]);
  }

  @override
  void initState() {
    super.initState();
    randomImageAsset = getRandomImage();
    fetchBook().then((fetchedBook) {
      setState(() {
        book = fetchedBook;
      });
    });
  }

  String getRandomImage() {
    final List<String> images = [
      "assets/images/community1.png",
      "assets/images/community2.png",
      "assets/images/community3.png"
    ];
    return images[Random().nextInt(images.length)]; // Return a random image
  }

  String formatMonthDay(DateTime dateTime) {
    const monthNames = [
      "January",
      "February",
      "March",
      "April",
      "May",
      "June",
      "July",
      "August",
      "September",
      "October",
      "November",
      "December"
    ];
    String month = monthNames[dateTime.month - 1];
    return "$month ${dateTime.day}, ${dateTime.year}";
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked; // Toggle the state
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        backgroundColor: backgroundColour,
        body: Container(
          color: primaryColour,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 20),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Consumer<PageProvider>(
                      builder: (context, pageProvider, child) => GestureDetector(
                        onTap: () {
                          Navigator.pop(context, true);
                        },
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              color: backgroundColour,
                              borderRadius: BorderRadius.circular(100)),
                          child: Center(
                            child: Icon(
                              Icons.arrow_back_rounded,
                              size: 30,
                              color: primaryColour,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Image.asset(
                  randomImageAsset,
                  height: MediaQuery.of(context).size.height *
                      0.4, // 40% of the screen height
                  width: double.infinity,
                  fit: BoxFit
                      .fitWidth, // This will fit the content within the width
                ),
                Container(
                  decoration: BoxDecoration(
                    color: backgroundColour,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.elliptical(64, 20),
                        topRight: Radius.elliptical(64, 20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(
                        16.0), // Padding inside the container
                    child: Column(
                      // Column for the content
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              // Use Expanded to take up all space except for the image
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            widget.thread.profileImage),
                                      ),
                                      const SizedBox(width: 8.0),
                                      Text(
                                        widget.thread.profileName,
                                        style: defaultText.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: blackColour,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16.0),
                                  Text(
                                    widget.thread.bookTitle,
                                    style: defaultText.copyWith(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: primaryColour,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    'by ${widget.thread.bookAuthor}',
                                    style: defaultText.copyWith(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 12.0),
                                  Text(
                                    'Published ${formatMonthDay(widget.thread.bookPublished)}',
                                    style: defaultText.copyWith(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 12.0),
                                  Text(
                                    '${widget.thread.bookPage} pages',
                                    style: defaultText.copyWith(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(height: 12.0),
                                ],
                              ),
                            ),
                            Material(
                                child: Consumer<PageProvider>(
                              builder: (context, pageProvider, child) => InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookDisplay(
                                        book: book as Books,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 150,
                                  height: 225,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    image: DecorationImage(
                                      image:
                                          NetworkImage(widget.thread.bookImage),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ))
                          ],
                        ),
                        const SizedBox(height: 12.0),
                        Text(
                          'Posted ${formatMonthDay(widget.thread.date)}',
                          style: defaultText.copyWith(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 12.0),
                        Text(
                          widget.thread.review,
                          style: defaultText.copyWith(
                            fontSize: 14,
                            color: blackColour,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Row(
                          children: <Widget>[
                            IconButton(
                              icon: Icon(isLiked
                                  ? Icons.favorite
                                  : Icons
                                      .favorite_border), // Toggles icon based on isLiked
                              color: primaryColour,
                              onPressed: () {
                                toggleLike(); // Call this method when the button is pressed
                              },
                            ),
                            Text(
                              isLiked
                                  ? 'LIKED!  '
                                  : 'LIKE?  ', // Toggles text based on isLiked
                              style: defaultText.copyWith(
                                fontSize: 14,
                                color: primaryColour,
                              ),
                            ),
                            Text(
                              '${widget.thread.likes + (isLiked ? 1 : 0)} likes', // Increment likes if isLiked is true
                              style: defaultText.copyWith(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        const Divider(color: Colors.grey),
                        widget.thread.profileName == logInUser!.username
                            ? Consumer<PageProvider>(
                                builder: (context, pageProvider, child) =>
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      child: ElevatedButton.icon(
                                        onPressed: () async {
                                          // Ensure necessary conditions are met (if any) before proceeding
                                          var url = Uri.parse(
                                              'https://books-buddy-e06-tk.pbp.cs.ui.ac.id/reachbuddy/delete_thread_ajax/${widget.thread.threadId}/');
                                          var response = await http.delete(url);
      
                                          if (response.statusCode == 200) {
                                            // Successfully deleted
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                    "Berhasil menghapus thread!"),
                                                duration: Duration(seconds: 1),
                                              ),
                                            );
                                            Navigator.pop(context, true);
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.delete, // Trash icon
                                          color: Colors.white,
                                        ),
                                        label: Text(
                                          "Delete",
                                          style: defaultText.copyWith(
                                              color: Colors.white, fontSize: 16),
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              Colors.red, // Red background color
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                18.0), // Rounded rectangle shape
                                          ),
                                        ),
                                      ),
                                    ))
                            : const Padding(padding: EdgeInsets.all(0)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
