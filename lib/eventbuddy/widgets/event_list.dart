// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:books_buddy/auth/models/user_models.dart';
import 'package:books_buddy/eventbuddy/models/event_models.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class EventSection extends StatefulWidget {
  const EventSection({super.key});

  @override
  State<EventSection> createState() => _EventSectionState();
}

class _EventSectionState extends State<EventSection> {
  late Future<List<Event>> _data;

  Future<List<Event>> fetchEvent(url) async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var response = await http.get(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    List<Event> listBooks = [];

    for (var book in data) {
      if (book != null) {
        listBooks.add(Event.fromJson(book));
      }
    }

    return listBooks;
  }

  @override
  void initState() {
    super.initState();
    // TODO : INTEGRASIKAN LINK
    _data = fetchEvent("http://127.0.0.1:8000/eventbuddy/get-event-flutter/");
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
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
                          "Stay tuned for upcoming events and join the excitement!",
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 24),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: 160,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: primaryColour.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: const BoxDecoration(boxShadow: [
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
                                  snapshot.data![index].bookThumbnail,
                                  width: 100,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const SizedBox(
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
                                        snapshot.data![index].eventName,
                                        style: defaultText.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.calendar_month_rounded,
                                            size: 14,
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            snapshot.data![index].eventDate
                                                .toString()
                                                .substring(0, 10),
                                            style: defaultText.copyWith(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "Description",
                                    style: defaultText.copyWith(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      physics: const BouncingScrollPhysics(),
                                      child: Text(
                                        snapshot.data![index].eventDescription,
                                        style: defaultText.copyWith(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w300,
                                        ),
                                        textAlign: TextAlign.justify,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (logInUser!.username ==
                                                snapshot.data![index]
                                                    .eventUsername) {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  List<dynamic>
                                                      participantNames =
                                                      snapshot.data![index]
                                                          .eventParticipants
                                                          .map((participant) =>
                                                              participant
                                                                  .participantName)
                                                          .toList();

                                                  return AlertDialog(
                                                    title: Text(
                                                      'Attendees for ${snapshot.data![index].eventName}',
                                                      style: const TextStyle(
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                    backgroundColor:
                                                        secondaryColour,
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            32.0),
                                                    content:
                                                        SingleChildScrollView(
                                                      child: Column(
                                                        children: [
                                                          const Text(
                                                            'List of attendees:',
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                          for (int i = 0;
                                                              i <
                                                                  participantNames
                                                                      .length;
                                                              i++)
                                                            Text(
                                                              '${i + 1}. ${participantNames[i]}',
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                        ],
                                                      ),
                                                    ),
                                                    actions: <Widget>[
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child:
                                                            const Text('Close'),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "You are not the organizer of this event."),
                                              ));
                                            }
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 90,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 1.5),
                                            decoration: BoxDecoration(
                                              color: primaryColour,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Attendees",
                                                style: defaultText.copyWith(
                                                  color: backgroundColour,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            // TODO : INTEGRASIKAN LINK
                                            final response =
                                                await request.postJson(
                                              "http://127.0.0.1:8000/eventbuddy/regis-flutter/",
                                              jsonEncode(
                                                <String, String>{
                                                  'username':
                                                      logInUser!.username,
                                                  'id': snapshot
                                                      .data![index].eventPk
                                                      .toString(),
                                                },
                                              ),
                                            );

                                            if (response["status"] == 1) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "You have registered for this event."),
                                              ));
                                            }

                                            if (response["status"] == 2) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "Successfully registered! See you soon!"),
                                              ));
                                            }

                                            if (response["status"] == 3) {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                content: Text(
                                                    "You are the organizer of this event."),
                                              ));
                                            }
                                          },
                                          child: Container(
                                            height: 30,
                                            width: 90,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 1.5),
                                            decoration: BoxDecoration(
                                              color: primaryColour,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Register",
                                                style: defaultText.copyWith(
                                                  color: backgroundColour,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
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
