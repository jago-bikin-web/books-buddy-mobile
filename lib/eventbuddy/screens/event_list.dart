import 'package:books_buddy/eventbuddy/models/event_models.dart';
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
        'http://127.0.0.1:8000/eventbuddy/json/');
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
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(
                                    "${snapshot.data![index].fields.name}",
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                    ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                        "${snapshot.data![index].fields.description}")
                                ],
                                ),
                            )
                            );
                    }
                }
            })
            );
    }
}
