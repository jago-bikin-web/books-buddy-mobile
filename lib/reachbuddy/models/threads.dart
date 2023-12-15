// To parse this JSON data, do
//
//     final threads = threadsFromJson(jsonString);

import 'dart:convert';

List<Threads> threadsFromJson(String str) => List<Threads>.from(json.decode(str).map((x) => Threads.fromJson(x)));

String threadsToJson(List<Threads> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Threads {
    String bookTitle;
    String bookImage;
    String bookAuthor;
    DateTime bookPublished;
    int bookPage;
    String profileImage;
    String profileName;
    DateTime date;
    String review;
    int likes;

    Threads({
        required this.bookTitle,
        required this.bookImage,
        required this.bookAuthor,
        required this.bookPublished,
        required this.bookPage,
        required this.profileImage,
        required this.profileName,
        required this.date,
        required this.review,
        required this.likes,
    });

    factory Threads.fromJson(Map<String, dynamic> json) => Threads(
        bookTitle: json["book_title"],
        bookImage: json["book_image"],
        bookAuthor: json["book_author"],
        bookPublished: DateTime.parse(json["book_published"]),
        bookPage: json["book_page"],
        profileImage: json["profile_image"],
        profileName: json["profile_name"],
        date: DateTime.parse(json["date"]),
        review: json["review"],
        likes: json["likes"],
    );

    Map<String, dynamic> toJson() => {
        "book_title": bookTitle,
        "book_image": bookImage,
        "book_author": bookAuthor,
        "book_published": "${bookPublished.year.toString().padLeft(4, '0')}-${bookPublished.month.toString().padLeft(2, '0')}-${bookPublished.day.toString().padLeft(2, '0')}",
        "book_page": bookPage,
        "profile_image": profileImage,
        "profile_name": profileName,
        "date": date.toIso8601String(),
        "review": review,
        "likes": likes,
    };
}
