// To parse this JSON data, do
//
//     final event = eventFromJson(jsonString);

import 'dart:convert';

List<Event> eventFromJson(String str) => List<Event>.from(json.decode(str).map((x) => Event.fromJson(x)));

String eventToJson(List<Event> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Event {
    int eventPk;
    String bookThumbnail;
    String eventName;
    String eventDescription;
    DateTime eventDate;
    String eventUserFullname;
    String eventUsername;
    List<EventParticipant> eventParticipants;

    Event({
        required this.eventPk,
        required this.bookThumbnail,
        required this.eventName,
        required this.eventDescription,
        required this.eventDate,
        required this.eventUserFullname,
        required this.eventUsername,
        required this.eventParticipants,
    });

    factory Event.fromJson(Map<String, dynamic> json) => Event(
        eventPk: json["event_pk"],
        bookThumbnail: json["book_thumbnail"],
        eventName: json["event_name"],
        eventDescription: json["event_description"],
        eventDate: DateTime.parse(json["event_date"]),
        eventUserFullname: json["event_user_fullname"],
        eventUsername: json["event_username"],
        eventParticipants: List<EventParticipant>.from(json["event_participants"].map((x) => EventParticipant.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "event_pk": eventPk,
        "book_thumbnail": bookThumbnail,
        "event_name": eventName,
        "event_description": eventDescription,
        "event_date": "${eventDate.year.toString().padLeft(4, '0')}-${eventDate.month.toString().padLeft(2, '0')}-${eventDate.day.toString().padLeft(2, '0')}",
        "event_user_fullname": eventUserFullname,
        "event_username": eventUsername,
        "event_participants": List<dynamic>.from(eventParticipants.map((x) => x.toJson())),
    };
}

class EventParticipant {
    String participantName;

    EventParticipant({
        required this.participantName,
    });

    factory EventParticipant.fromJson(Map<String, dynamic> json) => EventParticipant(
        participantName: json["participant_name"],
    );

    Map<String, dynamic> toJson() => {
        "participant_name": participantName,
    };
}
