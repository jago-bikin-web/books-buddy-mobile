import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:books_buddy/reachbuddy/models/threads.dart';

import 'package:books_buddy/auth/models/user_models.dart';
import 'package:books_buddy/home/widgets/moduls.dart';
import 'package:books_buddy/shared/shared.dart';

class ThreadsPage extends StatefulWidget {
  const ThreadsPage({Key? key}) : super(key: key);

  @override
  _ThreadsPageState createState() => _ThreadsPageState();
}

class _ThreadsPageState extends State<ThreadsPage> with SingleTickerProviderStateMixin{
  List<Threads> _allThreads = [];
  bool _isLoading = true;
  late AnimationController _controller;
  late Animation<Offset> _animation;

  String formatMonthDay(DateTime dateTime) {
    const monthNames = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    String month = monthNames[dateTime.month - 1];
    return "$month ${dateTime.day}";
  }

  @override
  void initState() {
    super.initState();
    fetchThreads().then((threads) {
      setState(() {
        _allThreads = threads;
        _isLoading = false;
      });
    });
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..forward();
    _animation = Tween<Offset>(
      begin: const Offset(0.0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  

  Future<List<Threads>> fetchThreads() async {
    var url =
        Uri.parse('http://127.0.0.1:8000/reachbuddy/get-threads-flutter/');
    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Threads> listThreads = [];
    for (var d in data) {
      listThreads.add(Threads.fromJson(d));
    }

    // Sorting the threads based on dateAdded from oldest to newest
    listThreads.sort((a, b) => b.date.compareTo(a.date));

    return listThreads;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom header
          Container(
            height: 40,
            decoration: BoxDecoration(
                gradient: gradient,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(64, 32),
                    bottomRight: Radius.elliptical(64, 32))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/logo.png",
                    height: 30,
                    width: 30,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Books Buddy",
                    style: defaultText.copyWith(
                      color: primaryColour,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 24,
            ),
            child: Divider(
              color: primaryColour,
              thickness: 2,
            ),
          ),
          // Threads list
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.separated(
                    itemCount: _allThreads.length,
                    itemBuilder: (context, index) {
                      Threads thread = _allThreads[index];
                      String formattedDate = formatMonthDay(thread.date);

                      return Card(
                        color: secondaryColour,
                        elevation: 4,
                        margin: EdgeInsets.all(8),
                        child: Padding(
                          padding: EdgeInsets.all(8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(thread.bookImage,
                                  fit: BoxFit.cover),
                              SizedBox(height: 10),
                              Text(
                                thread.bookTitle,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                'by ${thread.bookAuthor}',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                              Divider(),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(thread.profileImage),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          thread.profileName,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          formattedDate,
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        SizedBox(height: 10),
                                        Text(thread.review),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Icon(Icons.thumb_up, size: 20),
                                  Text(' ${thread.likes}'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 0),
                  ),
          ),
        ],
      ),
      floatingActionButton: SlideTransition(
        position: _animation,
        child: Padding(
          padding: EdgeInsets.only(bottom: 60.0),
          child: FloatingActionButton(
            onPressed: () {},
            backgroundColor: primaryColour,
            child: Icon(
              Icons.edit_outlined,
              color: Colors.white,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}
