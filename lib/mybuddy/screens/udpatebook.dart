// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronous, use_build_context_synchronously

import 'dart:convert';

import 'package:books_buddy/mybuddy/models/own_book_models.dart';
import 'package:books_buddy/mybuddy/screens/mybuddy.dart';
import 'package:flutter/material.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:http/http.dart' as http;
// import 'package:fluttertoast/fluttertoast.dart';

class UpdateModal extends StatefulWidget {
  final BuildContext context;
  final OwnBooks book;
  const UpdateModal(this.context, {super.key, required this.book});

  @override
  State<UpdateModal> createState() => _UpdateModalState();
}

class _UpdateModalState extends State<UpdateModal> {
  final _formKey = GlobalKey<FormState>();
  late int _page;
  late String _status;
  late String _ulasan;

  String statusConvert(String input) {
    String status = "U";
    if (input == "Reading") {
      status = "R";
    } else if (input == "Wishlist") {
      status = "W";
    } else {
      status = "F";
    }
    return status;
  }

  @override
  void initState() {
    super.initState();
    _page = widget.book.pageTrack;
    _status = statusConvert(widget.book.status);
    _ulasan = widget.book.ulasan;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                color: backgroundColour,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30))),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "How was your experience?",
                                style: defaultText.copyWith(
                                    fontSize: 20, color: blackColour),
                              ),
                              Text(
                                "Update",
                                style: defaultText.copyWith(
                                    fontSize: 32,
                                    color: primaryColour,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Center(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context, false);
                              },
                              child: SizedBox(
                                height: 30,
                                width: 30,
                                child: Icon(Icons.cancel_outlined,
                                    color: primaryColour),
                              ),
                            ),
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  spreadRadius: 2,
                                  blurRadius: 8,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                widget.book.thumbnail,
                                width: 110,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          SizedBox(
                            height: 70,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              physics: BouncingScrollPhysics(),
                              child: Text(
                                widget.book.description,
                                style: defaultText.copyWith(
                                    fontSize: 12, fontWeight: FontWeight.w300),
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                      TextFormField(
                        decoration: inputDecoration(
                          hintText: widget.book.pageTrack.toString(),
                          labelText: "Page",
                          prefixIcon: Icons.book_rounded,
                        ),
                        onChanged: (String? value) {
                          if (value != null && value.isNotEmpty) {
                            setState(() {
                              _page = int.tryParse(value) ?? _page;
                            });
                          }
                        },
                        validator: (String? value) {
                          if (value == null ||
                              value.isEmpty ||
                              int.tryParse(value) == null) {
                            return "Please ensure the input consists of whole numbers only.";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      DropdownButtonFormField(
                        value: statusConvert(widget.book.status),
                        items: [
                          DropdownMenuItem(
                            value: "W",
                            child: Text("Wishlist"),
                          ),
                          DropdownMenuItem(
                            value: "R",
                            child: Text("Reading"),
                          ),
                          DropdownMenuItem(
                            value: "F",
                            child: Text("Finish"),
                          )
                        ],
                        onChanged: (String? newValue) {
                          setState(() {
                            _status = newValue!;
                          });
                        },
                        icon: Icon(
                          Icons.arrow_drop_down_circle_rounded,
                          color: primaryColour,
                        ),
                        decoration: inputDecoration(
                            labelText: "Status", prefixIcon: null),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        minLines: 4,
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: inputDecoration(
                          hintText: widget.book.ulasan,
                          labelText: "Review",
                          prefixIcon: null,
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _ulasan = value!;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Container(
                        height: 60,
                        width: MediaQuery.of(context).size.width - 2 * 24,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: gradient),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await http.put(
                                Uri.parse(
                                    "http://127.0.0.1:8000/mybuddy/update-book-flutter/"),
                                headers: {"Content-Type": "application/json"},
                                body: jsonEncode(
                                  <String, String>{
                                    'pk': widget.book.pk.toString(),
                                    'page': _page.toString(),
                                    'status': _status,
                                    'ulasan': _ulasan,
                                  },
                                ),
                              );

                              Navigator.pop(context, true);

                              _formKey.currentState!.reset();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: Text(
                            "Update",
                            style: defaultText.copyWith(
                                fontSize: 20, color: backgroundColour),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
