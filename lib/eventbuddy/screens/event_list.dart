// ignore_for_file: prefer_const_constructors

import 'package:books_buddy/eventbuddy/models/event_models.dart';
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
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.all(20),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: secondaryColour,  // Warna latar belakang kuning
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Image.network(
                          "${snapshot.data![index].bookThumbnail}",
                          width: 100,  // Sesuaikan lebar gambar sesuai kebutuhan Anda
                          height: 100,  // Sesuaikan tinggi gambar sesuai kebutuhan Anda
                          fit: BoxFit.cover,  // Sesuaikan mode penyesuaian gambar
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "${snapshot.data![index].eventName}",
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text("Date: ${snapshot.data![index].eventDate.toString().substring(0,10)}"),
                        const SizedBox(height: 10),
                        Text("${snapshot.data![index].eventDescription}"),
                      ],
                    ),
                  ),
                ),
              );
            }
                }
            })
            );
    }
}