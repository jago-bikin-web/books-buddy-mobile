// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:books_buddy/findbuddy/screens/request_list.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';

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
        title: Text(
          'Book Request',
          style: defaultText.copyWith(
              color: whiteColour, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: primaryColour,
        foregroundColor: whiteColour,
      ),
      backgroundColor: backgroundColour,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: inputDecoration(
                      hintText: "Title", labelText: "Title", prefixIcon: null),
                  onChanged: (String? value) {
                    setState(() {
                      _title = value!;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return "Required!";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: inputDecoration(
                    hintText: "Author",
                    labelText: "Author",
                    prefixIcon: null,
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
                    style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColour),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // TODO: INTEGRASI LINK
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
                              content: Text("Request berhasil disimpan!"),
                            ),
                          );
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: whiteColour,
                                title: Text('Request berhasil tersimpan',
                                    style: defaultText.copyWith(
                                        color: primaryColour, fontSize: 18)),
                                content: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Nama: $_title',
                                        style: defaultText.copyWith(
                                            color: primaryColour,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14),
                                      ),
                                      Text(
                                        'Deskripsi: $_author',
                                        style: defaultText.copyWith(
                                            color: primaryColour,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 14),
                                      ),
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
                                  "Terdapat kesalahan, silakan coba lagi."),
                            ),
                          );
                        }
                      }
                    },
                    child: Text(
                      "Save",
                      style: defaultText.copyWith(
                          color: whiteColour,
                          fontWeight: FontWeight.w300,
                          fontSize: 14),
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
              style: ElevatedButton.styleFrom(backgroundColor: primaryColour),
              onPressed: () {
                // Tombol ke ListPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ListPage()),
                );
              },
              child: Text(
                "Books Request List",
                style: defaultText.copyWith(
                    color: whiteColour,
                    fontWeight: FontWeight.w300,
                    fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
