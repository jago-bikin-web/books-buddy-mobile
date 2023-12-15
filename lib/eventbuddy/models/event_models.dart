// To parse this JSON data, do
//
//     final event = eventFromJson(jsonString);

import 'dart:convert';

List<Event> eventFromJson(String str) => List<Event>.from(json.decode(str).map((x) => Event.fromJson(x)));

String eventToJson(List<Event> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Event {
    String bookThumbnail;
    String eventName;
    String eventDescription;
    DateTime eventDate;
    String eventUserName;
    String eventUserEmail;
    List<EventParticipant> eventParticipants;

    Event({
        required this.bookThumbnail,
        required this.eventName,
        required this.eventDescription,
        required this.eventDate,
        required this.eventUserName,
        required this.eventUserEmail,
        required this.eventParticipants,
    });

    factory Event.fromJson(Map<String, dynamic> json) => Event(
        bookThumbnail: json["book_thumbnail"],
        eventName: json["event_name"],
        eventDescription: json["event_description"],
        eventDate: DateTime.parse(json["event_date"]),
        eventUserName: json["event_user_name"],
        eventUserEmail: json["event_user_email"],
        eventParticipants: List<EventParticipant>.from(json["event_participants"].map((x) => EventParticipant.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "book_thumbnail": bookThumbnail,
        "event_name": eventName,
        "event_description": eventDescription,
        "event_date": eventDate,
        "event_user_name": eventUserName,
        "event_user_email": eventUserEmail,
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
