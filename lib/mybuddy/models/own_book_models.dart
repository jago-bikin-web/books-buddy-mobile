import 'dart:convert';

List<OwnBooks> ownBooksFromJson(String str) =>
    List<OwnBooks>.from(json.decode(str).map((x) => OwnBooks.fromJson(x)));

String ownBooksToJson(List<OwnBooks> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OwnBooks {
  int pk;
  String thumbnail;
  String title;
  String authors;
  String description;
  int pageCount;
  int pageTrack;
  String ulasan;
  String status;
  String publishedDate;

  OwnBooks({
    required this.pk,
    required this.thumbnail,
    required this.title,
    required this.authors,
    required this.description,
    required this.pageCount,
    required this.pageTrack,
    required this.ulasan,
    required this.status,
    required this.publishedDate,
  });

  factory OwnBooks.fromJson(Map<String, dynamic> json) => OwnBooks(
      pk: json["pk"],
      thumbnail: json["thumbnail"],
      title: json["title"],
      authors: json["authors"],
      description: json["description"],
      pageCount: json["page_count"],
      pageTrack: json["page_track"],
      ulasan: json["ulasan"],
      status: json["status"],
      publishedDate: json["publish_date"]);

  Map<String, dynamic> toJson() => {
        "pk": pk,
        "thumbnail": thumbnail,
        "title": title,
        "authors": authors,
        "description": description,
        "page_count": pageCount,
        "page_track": pageTrack,
        "ulasan": ulasan,
        "status": status,
      };
}
