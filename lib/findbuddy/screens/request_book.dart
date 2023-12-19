import 'dart:convert';

import 'package:books_buddy/findbuddy/models/request_books_models.dart';
import 'package:books_buddy/findbuddy/screens/findbuddy.dart';
import 'package:books_buddy/findbuddy/screens/request_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:http/http.dart' as http;
import 'package:books_buddy/shared/shared.dart';

class RequestBook extends StatefulWidget {
  const RequestBook({Key? key}) : super(key: key);

  @override
  State<RequestBook> createState() => _RequestBookState();
}

class _RequestBookState extends State<RequestBook> {
  final _formKey = GlobalKey<FormState>();
  String _title = "";
  String _author = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Request Book',
          ),
        ),
        backgroundColor: Color(0xFFF8D038),
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: primaryColour.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: primaryColour, width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.red, width: 2),
                    ),
                    hintText: "Title",
                    labelText: "Title",
                    labelStyle: defaultText.copyWith(
                        fontSize: 14,
                        color: blackColour,
                        fontWeight: FontWeight.w500),
                    floatingLabelStyle: defaultText.copyWith(
                        fontSize: 14,
                        color: primaryColour,
                        fontWeight: FontWeight.bold),
                    focusColor: primaryColour,
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _title = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Judul tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                 decoration: InputDecoration(
                    filled: true,
                    fillColor: primaryColour.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: primaryColour, width: 2),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          const BorderSide(color: Colors.red, width: 2),
                    ),
                    hintText: "Author",
                    labelText: "Author",
                    labelStyle: defaultText.copyWith(
                        fontSize: 14,
                        color: blackColour,
                        fontWeight: FontWeight.w500),
                    floatingLabelStyle: defaultText.copyWith(
                        fontSize: 14,
                        color: primaryColour,
                        fontWeight: FontWeight.bold),
                    focusColor: primaryColour,
                  ),
                  onChanged: (String? value) {
                    setState(() {
                      _author = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Author tidak boleh kosong!";
                    }
                    return null;
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                   style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFFF8D038)),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 24, horizontal: 64),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final response = await request.postJson(
                          "http://127.0.0.1:8000/findbuddy/create-flutter/",
                          jsonEncode(<String, String>{
                            'title': _title,
                            'author': _author,
                          }),
                        );
                        if (response['status'] == 'success') {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Request Saved!"),
                            ),
                          );
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Request Saved!'),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Nama: $_title'),
                                      Text('Deskripsi: $_author'),
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: const Text('OK'),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Request Failed, Please Try Again"),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Color(0xFFF8D038)),
                      padding: MaterialStateProperty.all(
                        EdgeInsets.symmetric(vertical: 24, horizontal: 64),
                      ),
                    ),
              onPressed: () {
                // Tombol ke ListPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListPage()),
                );
              },
              child: const Text(
                "Books Request List",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
