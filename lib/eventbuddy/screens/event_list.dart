// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:books_buddy/eventbuddy/models/event_models.dart';
import 'package:books_buddy/eventbuddy/screens/event_form.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EventPage extends StatefulWidget {
    const EventPage({Key? key}) : super(key: key);

    @override
    // ignore: library_private_types_in_public_api
    _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  Future<List<Event>> fetchProduct() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse(
        'http://127.0.0.1:8000/eventbuddy/get-event-flutter/');
    var response = await http.get(
        url,
        headers: {"Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Event> list_event = [];
    for (var d in data) {
        if (d != null) {
            list_event.add(Event.fromJson(d));
        }
    }
    return list_event;
}

@override
Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Event in Books Buddy'),
        ),
        //drawer: const LeftDrawer(),
        backgroundColor: primaryColour,
        body: FutureBuilder(
            future: fetchProduct(),
            builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                } else {
                    if (!snapshot.hasData) {
                    return const Column(
                        children: [
                        Text(
                            "No events added.",
                            style:
                                TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        ],
                    );
                  } else {
              return SizedBox(
                height: 200 * snapshot.data.length / 1 - (19 * snapshot.data.length) + 50,
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
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
                                    "${snapshot.data[index].bookThumbnail}",
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${snapshot.data[index].eventName}",
                                          style: defaultText.copyWith(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Date: ${snapshot.data[index].eventDate.toString().substring(0, 10)}",
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
                                          "${snapshot.data[index].eventDescription}",
                                          style: defaultText.copyWith(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300,
                                          ),
                                          textAlign: TextAlign.justify,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {},
                                            child: Text('Edit'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            child: Text('Attendees'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            child: Text('Reg'),
                                          ),
                                        ],
                                      ),
                                    ),
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
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: 60.0),
        child: FloatingActionButton(
          onPressed: () {
            // Navigasi ke halaman penambahan event
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventForm(), // Ganti dengan halaman penambahan event yang sesuai
              ),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}