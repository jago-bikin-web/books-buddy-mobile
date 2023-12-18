// ignore_for_file: library_private_types_in_public_api

import 'package:books_buddy/findbuddy/models/request_books_models.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future<List<RequestBooks>> fetchProduct() async {
    var url = Uri.parse(
        'https://books-buddy-e06-tk.pbp.cs.ui.ac.id/findbuddy/get-request/');
    var response = await http.get(
      url,
      headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<RequestBooks> listProduct = [];
    for (var d in data) {
      if (d != null) {
        listProduct.add(RequestBooks.fromJson(d));
      }
    }
    return listProduct;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColour,
        appBar: AppBar(
          title: Text(
            'Request List',
            style: defaultText.copyWith(
                color: whiteColour, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          centerTitle: true,
          backgroundColor: primaryColour,
          foregroundColor: whiteColour,
        ),
        body: FutureBuilder(
            future: fetchProduct(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return Column(
                    children: [
                      Text(
                        "Tidak ada data.",
                        style: defaultText.copyWith(
                            fontSize: 20, color: primaryColour),
                      ),
                      const SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) {
                      return Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              color: primaryColour.withOpacity(0.2),
                              child: Text(
                                "${index + 1}. ${snapshot.data![index].fields.title} - ${snapshot.data![index].fields.author}",
                                style: defaultText.copyWith(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }
              }
            }));
  }
}
