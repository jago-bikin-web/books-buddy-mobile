// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:books_buddy/auth/models/user_models.dart';
import 'package:books_buddy/home/models/book_models.dart';
import 'package:books_buddy/mybuddy/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:intl/intl.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class CreateEvent extends StatefulWidget {
  final Books book;
  const CreateEvent({super.key, required this.book});

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  TextEditingController dateInput = TextEditingController();
  String _description = "";

  @override
  Widget build(BuildContext context) {
    Books book = widget.book;
    final request = context.watch<CookieRequest>();
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColour,
            ),
            child: Column(
              children: [
                const TopBar(),
                Padding(
                  padding: const EdgeInsets.only(left: 24, top: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                            color: primaryColour,
                            borderRadius: BorderRadius.circular(100)),
                        child: Center(
                          child: Icon(
                            Icons.arrow_back_rounded,
                            size: 30,
                            color: backgroundColour,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                        top: 15,
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Get involved together!",
                                    style: defaultText.copyWith(
                                        fontSize: 18, color: blackColour),
                                  ),
                                  Text(
                                    "Create",
                                    style: defaultText.copyWith(
                                      fontSize: 32,
                                      color: primaryColour,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          Center(
                            child: Container(
                              decoration: const BoxDecoration(
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
                                  book.fields.thumbnail,
                                  width: 110,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          TextFormField(
                            decoration: inputDecoration(
                              hintText: "Meet & Greet",
                              labelText: "Name",
                              prefixIcon: Icons.event,
                            ),
                            onChanged: (String? value) {
                              _name = value!;
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Required!";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            controller: dateInput,
                            decoration: inputDecoration(
                              labelText: "Enter Date",
                              prefixIcon: Icons.calendar_today_rounded,
                            ),
                            readOnly: true,
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                                builder: (BuildContext context, child) {
                                  return Theme(
                                    data: Theme.of(context).copyWith(
                                      colorScheme: ColorScheme.light(
                                        primary: backgroundColour,
                                        onPrimary: primaryColour,
                                        onSurface: blackColour,
                                      ),
                                      textButtonTheme: TextButtonThemeData(
                                        style: TextButton.styleFrom(
                                          foregroundColor:
                                              primaryColour, // button text color
                                        ),
                                      ),
                                    ),
                                    child: child!,
                                  );
                                },
                              );

                              if (pickedDate != null) {
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(pickedDate);
                                setState(() {
                                  dateInput.text = formattedDate;
                                });
                              }
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            minLines: 4,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: inputDecoration(
                              hintText: "This event will be...",
                              labelText: "Description",
                              prefixIcon: null,
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                _description = value!;
                              });
                            },
                            validator: (String? value) {
                              if (value == null || value.isEmpty) {
                                return "Required!";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(
                            height: 50,
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
                                  final response = await request.postJson(
                                    "https://books-buddy-e06-tk.pbp.cs.ui.ac.id/eventbuddy/create-event-flutter/",
                                    jsonEncode(
                                      <String, String>{
                                        'username': logInUser!.username,
                                        'pkBook': book.pk.toString(),
                                        'name': _name,
                                        'date': dateInput.text,
                                        'description': _description,
                                      },
                                    ),
                                  );

                                  if (response["status"]) {
                                    Navigator.pop(context);
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content:
                                          Text("Event with book selected alreadt made"),
                                    ));
                                  }

                                  _formKey.currentState!.reset();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15))),
                              child: Text(
                                "Create Event",
                                style: defaultText.copyWith(
                                  fontSize: 20,
                                  color: backgroundColour,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
