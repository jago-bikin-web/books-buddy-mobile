import 'package:books_buddy/mybuddy/widgets/app_bar.dart';
import 'package:books_buddy/reachbuddy/screens/add_thread.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:books_buddy/reachbuddy/models/threads.dart';

class ThreadsPage extends StatefulWidget {
  const ThreadsPage({Key? key}) : super(key: key);

  @override
  _ThreadsPageState createState() => _ThreadsPageState();
}

class _ThreadsPageState extends State<ThreadsPage>
    with SingleTickerProviderStateMixin {
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

  void _navigateToAddThread(BuildContext context) {
  Navigator.of(context).push(
    PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => AddThread(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.easeInOut;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
      transitionDuration: Duration(milliseconds: 300),
      reverseTransitionDuration: Duration(milliseconds: 300),
    ),
  );
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

    listThreads.sort((a, b) => b.date.compareTo(a.date));

    return listThreads;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              color: backgroundColour, // Replace with your background color
            ),
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopBar(),
                  // Header container
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    child: Divider(
                      color: primaryColour,
                      thickness: 2,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Text(
                          "Connect with Others",
                          style: defaultText.copyWith(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  _isLoading
                      ? Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: _allThreads.length,
                          itemBuilder: (context, index) {
                            Threads thread = _allThreads[index];
                            String formattedDate = formatMonthDay(thread.date);

                            return Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {
                                    // Define onTap action
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 15),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                              flex: 3,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    thread.bookTitle,
                                                    style: defaultText.copyWith(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  Text(
                                                    'by ${thread.bookAuthor}',
                                                    style: defaultText.copyWith(
                                                      color: Colors.grey,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    thread.profileName,
                                                    style: defaultText.copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14),
                                                  ),
                                                  SizedBox(width: 8),
                                                  CircleAvatar(
                                                    backgroundImage: NetworkImage(
                                                        thread.profileImage),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 100, // Fixed width
                                              height: 150, // Fixed height
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(
                                                    6), // Rounded edges
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      thread.bookImage),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 20),
                                            Expanded(
                                              child: Text(
                                                thread.review,
                                                style: defaultText.copyWith(
                                                  fontSize: 14
                                                ),
                                                ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        Divider(
                                          height: 0,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                          },
                        ),
                  SizedBox(height: 60),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: SlideTransition(
          position: _animation,
          child: Padding(
            padding: EdgeInsets.only(bottom: 60.0),
            child: FloatingActionButton(
              onPressed: () => _navigateToAddThread(context),
              backgroundColor: primaryColour, // Replace with your primary color
              child: Icon(Icons.edit_outlined, color: Colors.white, size: 40),
            ),
          ),
        ),
      ),
    );
  }
}
