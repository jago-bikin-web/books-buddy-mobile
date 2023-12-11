// To parse this JSON data, do
//
//     final event = eventFromJson(jsonString);

import 'dart:convert';

List<Event> eventFromJson(String str) => List<Event>.from(json.decode(str).map((x) => Event.fromJson(x)));

String eventToJson(List<Event> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Event {
    String model;
    int pk;
    Fields fields;

    Event({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Event.fromJson(Map<String, dynamic> json) => Event(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    int book;
    int user;
    String name;
    DateTime date;
    String description;
    List<int> participant;

    Fields({
        required this.book,
        required this.user,
        required this.name,
        required this.date,
        required this.description,
        required this.participant,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        book: json["book"],
        user: json["user"],
        name: json["name"],
        date: DateTime.parse(json["date"]),
        description: json["description"],
        participant: List<int>.from(json["participant"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "book": book,
        "user": user,
        "name": name,
        "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "description": description,
        "participant": List<dynamic>.from(participant.map((x) => x)),
    };
}
