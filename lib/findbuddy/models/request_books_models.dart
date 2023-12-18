// To parse this JSON data, do
//
//     final requestBooks = requestBooksFromJson(jsonString);

import 'dart:convert';

List<RequestBooks> requestBooksFromJson(String str) => List<RequestBooks>.from(json.decode(str).map((x) => RequestBooks.fromJson(x)));

String requestBooksToJson(List<RequestBooks> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RequestBooks {
    String model;
    int pk;
    Fields fields;

    RequestBooks({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory RequestBooks.fromJson(Map<String, dynamic> json) => RequestBooks(
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
    String title;
    String author;

    Fields({
        required this.title,
        required this.author,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        title: json["title"],
        author: json["author"],
    );

    Map<String, dynamic> toJson() => {
        "title": title,
        "author": author,
    };
}
