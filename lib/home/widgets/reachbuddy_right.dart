import 'dart:convert';

import 'package:books_buddy/reachbuddy/screens/thread_detail.dart';
import 'package:books_buddy/reachbuddy/models/threads.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:books_buddy/shared/page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ThreadsHome extends StatefulWidget {
  const ThreadsHome({super.key});

  @override
  State<ThreadsHome> createState() => _ThreadsHomeState();
}

class _ThreadsHomeState extends State<ThreadsHome> {
  late Future<List<Threads>> _data;

  Future<List<Threads>> fetchThreads(url) async {
    // ... existing code ...

    var response = await http.get(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));
    List<Threads> listThreads = [];

    for (var threadData in data) {
      listThreads.add(Threads.fromJson(threadData));
    }

    // Sort the threads by date in descending order (newest first)
    listThreads.sort((a, b) => b.date.compareTo(a.date));

    // Take the top three latest threads
    return listThreads.take(3).toList();
  }

  @override
  void initState() {
    super.initState();
    _data = fetchThreads(
        "https://books-buddy-e06-tk.pbp.cs.ui.ac.id/reachbuddy/get-threads-flutter/");
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
          ));
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
                          "See what's other buddies are talking about!",
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
              height: 200, // Set a fixed height for the container
              child: ListView.builder(
                scrollDirection: Axis
                    .horizontal, // Make the list view scrollable horizontally
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Material(
                      color: Colors.transparent,
                      child: Consumer<PageProvider>(
                          builder: (context, pageProvider, child) => InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ThreadDetail(
                                        thread: snapshot.data![
                                            index]), // Replace with your target page
                                  ),
                                );
                                pageProvider.setPage(3);
                              },
                              child: Container(
                                width: 120, // Set a fixed width for each item
                                margin: const EdgeInsets.symmetric(
                                    horizontal:
                                        8), // Add some horizontal margin
                                child: Column(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          8), // Rounded corners for the image
                                      child: Image.network(
                                        snapshot.data![index].bookImage,
                                        width: 100, // Width for the book image
                                        height:
                                            150, // Height for the book image
                                        fit: BoxFit
                                            .cover, // Cover the entire space of the box
                                      ),
                                    ),
                                    const SizedBox(
                                        height:
                                            10), // Space between image and profile info
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment
                                          .start, // Center row content
                                      children: [
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            snapshot.data![index].profileImage,
                                          ),
                                          radius:
                                              16, // Adjust the radius to make the avatar smaller
                                        ),
                                        const SizedBox(
                                            width:
                                                8), // Space between avatar and name
                                        Flexible(
                                          child: Text(
                                            snapshot.data![index].profileName,
                                            overflow: TextOverflow
                                                .ellipsis, // Prevent long names from breaking layout
                                            style: defaultText.copyWith(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ))));
                },
              ),
            );
          }
        }
      },
    );
  }
}
