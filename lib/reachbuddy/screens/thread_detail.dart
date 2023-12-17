import 'package:books_buddy/findbuddy/screens/displaybook.dart';
import 'package:books_buddy/mybuddy/widgets/app_bar.dart';
import 'package:books_buddy/reachbuddy/screens/add_thread.dart';
import 'package:books_buddy/home/models/book_models.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:books_buddy/reachbuddy/models/threads.dart';

class ThreadDetail extends StatefulWidget {
  final Threads thread;
  const ThreadDetail({super.key, required this.thread});

  @override
  State<ThreadDetail> createState() => _ThreadDetailState();
}

class _ThreadDetailState extends State<ThreadDetail> {
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
    return "Posted $month ${dateTime.day}, ${dateTime.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.thread.profileName + "'s Review",
          style: defaultText.copyWith(
            color:
                blackColour, // Make sure blackColour is defined in shared.dart
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor:
            primaryColour, // Make sure primaryColour is defined in shared.dart
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: gradient, // Make sure gradient is defined in shared.dart
        ),
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              Image.asset(
                "assets/images/welcome.png",
                height: 300,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
              Expanded(
                // Use Expanded to fill the remaining space
                child: Container(
                  decoration: BoxDecoration(
                    color: backgroundColour,
                    borderRadius: BorderRadius.only(
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
                        SizedBox(height: 5),
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: blackColour,
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
                                    formatMonthDay(widget.thread.date),
                                    style: defaultText.copyWith(
                                      color: Colors.grey,
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                
                              },
                              child: Container(
                                width: 150,
                                height: 200,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  image: DecorationImage(
                                    image:
                                        NetworkImage(widget.thread.bookImage),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            )
                          ],
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
                              icon: Icon(Icons.favorite_border),
                              onPressed: () {
                                // Implement like functionality
                              },
                            ),
                            Text(
                              'LIKE? ',
                              style: defaultText.copyWith(
                                fontSize: 14,
                                color: blackColour,
                              ),
                            ),
                            Text(
                              '${widget.thread.likes} likes',
                              style: defaultText.copyWith(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                        Divider(color: blackColour),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
