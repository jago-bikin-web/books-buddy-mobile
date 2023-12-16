import 'package:books_buddy/shared/shared.dart';
import 'package:books_buddy/reachbuddy/screens/choose_book.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddThread extends StatefulWidget {
  const AddThread({super.key});

  @override
  State<AddThread> createState() => _AddThreadState();
}

class _AddThreadState extends State<AddThread> {
  final _formKey = GlobalKey<FormState>();
  String _review = "";
  int _bookpk = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColour, // Replace with your background color
      child : Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            'New Thread',
            style: defaultText.copyWith(
              fontSize: 24,
            ),
          ),
          actions: [
            ElevatedButton(
              child: Text(
                'Post',
                style: defaultText.copyWith(
                  color: whiteColour,
                  fontSize: 18,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColour,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onPressed: () {
                // Post action
              },
            ),
            SizedBox(width: 10)
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(
                        "https://lh3.googleusercontent.com/ogw/ANLem4ZbY8Sgfn4eFNL5PA-7d8A3wXO1DFwh8Q9zaK3u1Q=s32-c-mo"),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "What is your view?",
                          border: InputBorder.none,
                          hintStyle: defaultText.copyWith(
                              fontSize: 14, color: Colors.grey)),
                      maxLines: null,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Center(
                child: _bookpk == 0
                ? Container(
                  height: 35,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: gradient),
                  child: ElevatedButton(
                    onPressed: () {
                      // Choose book action
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const FindBuddy()));
                    },
                    child: Text(
                      'Choose the Book',
                      style: defaultText.copyWith(
                          color: backgroundColour, fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                )
                : Container()
              )
            ],
          ),
        ),
      )
    );
  }
}
