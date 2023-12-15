// To parse this JSON data, do
//
//     final books = booksFromJson(jsonString);

import 'dart:convert';

List<Books> booksFromJson(String str) => List<Books>.from(json.decode(str).map((x) => Books.fromJson(x)));

String booksToJson(List<Books> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Books {
    String model;
    int pk;
    Fields fields;

    Books({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Books.fromJson(Map<String, dynamic> json) => Books(
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
    String bookId;
    String etag;
    String selfLink;
    String title;
    String authors;
    String publisher;
    DateTime publishedDate;
    String description;
    String isbn13;
    String isbn10;
    int pageCount;
    String categories;
    double averageRating;
    int ratingsCount;
    String smallThumbnail;
    String thumbnail;
    String language;
    String previewLink;
    String infoLink;
    String country;
    String listPrice;
    String retailPrice;
    String buyLink;
    String webReaderLink;
    String accessViewStatus;

    Fields({
        required this.bookId,
        required this.etag,
        required this.selfLink,
        required this.title,
        required this.authors,
        required this.publisher,
        required this.publishedDate,
        required this.description,
        required this.isbn13,
        required this.isbn10,
        required this.pageCount,
        required this.categories,
        required this.averageRating,
        required this.ratingsCount,
        required this.smallThumbnail,
        required this.thumbnail,
        required this.language,
        required this.previewLink,
        required this.infoLink,
        required this.country,
        required this.listPrice,
        required this.retailPrice,
        required this.buyLink,
        required this.webReaderLink,
        required this.accessViewStatus,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        bookId: json["book_id"],
        etag: json["etag"],
        selfLink: json["self_link"],
        title: json["title"],
        authors: json["authors"],
        publisher: json["publisher"],
        publishedDate: DateTime.parse(json["published_date"]),
        description: json["description"],
        isbn13: json["isbn_13"],
        isbn10: json["isbn_10"],
        pageCount: json["page_count"],
        categories: json["categories"],
        averageRating: json["average_rating"],
        ratingsCount: json["ratings_count"],
        smallThumbnail: json["small_thumbnail"],
        thumbnail: json["thumbnail"],
        language: json["language"],
        previewLink: json["preview_link"],
        infoLink: json["infoLink"],
        country: json["country"],
        listPrice: json["list_price"],
        retailPrice: json["retail_price"],
        buyLink: json["buyLink"],
        webReaderLink: json["webReaderLink"],
        accessViewStatus: json["accessViewStatus"],
    );

    Map<String, dynamic> toJson() => {
        "book_id": bookId,
        "etag": etag,
        "self_link": selfLink,
        "title": title,
        "authors": authors,
        "publisher": publisher,
        "published_date": "${publishedDate.year.toString().padLeft(4, '0')}-${publishedDate.month.toString().padLeft(2, '0')}-${publishedDate.day.toString().padLeft(2, '0')}",
        "description": description,
        "isbn_13": isbn13,
        "isbn_10": isbn10,
        "page_count": pageCount,
        "categories": categories,
        "average_rating": averageRating,
        "ratings_count": ratingsCount,
        "small_thumbnail": smallThumbnail,
        "thumbnail": thumbnail,
        "language": language,
        "preview_link": previewLink,
        "infoLink": infoLink,
        "country": country,
        "list_price": listPrice,
        "retail_price": retailPrice,
        "buyLink": buyLink,
        "webReaderLink": webReaderLink,
        "accessViewStatus": accessViewStatus,
    };
}
