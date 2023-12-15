// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:convert';

import 'package:books_buddy/auth/models/user_models.dart';
import 'package:books_buddy/auth/screens/login.dart';
import 'package:books_buddy/home/home.dart';
import 'package:flutter/material.dart';
import 'package:books_buddy/shared/shared.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class RegisterModal extends StatefulWidget {
  final BuildContext context;
  const RegisterModal(this.context, {super.key});

  @override
  State<RegisterModal> createState() => _RegisterModalState();
}

class _RegisterModalState extends State<RegisterModal> {
  final _formKey = GlobalKey<FormState>();
  String _fullName = "";
  String _username = "";
  String _email = "";
  String? _status = "R";
  String _password1 = "";
  String _password2 = "";

  bool _isVisible1 = false;
  bool _isVisible2 = false;

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
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
                padding: EdgeInsets.only(
                    top: 25, bottom: MediaQuery.of(context).viewInsets.bottom),
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
                                "Hello...",
                                style: defaultText.copyWith(
                                    fontSize: 20, color: blackColour),
                              ),
                              Text(
                                "Register",
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
                                Navigator.pop(context);
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
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        decoration: inputDecoration(
                          hintText: "Full name",
                          labelText: "Full Name",
                          prefixIcon: Icons.person_rounded,
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _fullName = value!;
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
                        height: 10,
                      ),
                      TextFormField(
                        decoration: inputDecoration(
                          hintText: "Username",
                          labelText: "Username",
                          prefixIcon: Icons.person_outline_rounded,
                        ),
                        onChanged: (String? value) {
                          setState(() {
                            _username = value!;
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
                        height: 10,
                      ),
                      TextFormField(
                        decoration: inputDecoration(
                            hintText: "example@example.com",
                            labelText: "Email",
                            prefixIcon: Icons.email_rounded),
                        onChanged: (String? value) {
                          setState(() {
                            _email = value!;
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
                        height: 10,
                      ),
                      DropdownButtonFormField(
                        value: _status,
                        items: [
                          DropdownMenuItem(
                            value: "R",
                            child: Text("Reguler"),
                          ),
                          DropdownMenuItem(
                            value: "M",
                            child: Text("Member"),
                          )
                        ],
                        onChanged: (String? newValue) {
                          setState(() {
                            _status = newValue;
                          });
                        },
                        icon: Icon(
                          Icons.arrow_drop_down_circle_rounded,
                          color: primaryColour,
                        ),
                        decoration: inputDecoration(
                          labelText: "Join as a ...",
                          prefixIcon: null,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: primaryColour.withOpacity(0.1),
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
                          hintText: "********",
                          labelText: "Password",
                          labelStyle: defaultText.copyWith(
                              fontSize: 14,
                              color: blackColour,
                              fontWeight: FontWeight.w600),
                          floatingLabelStyle: defaultText.copyWith(
                              fontSize: 14,
                              color: primaryColour,
                              fontWeight: FontWeight.bold),
                          focusColor: primaryColour,
                          prefixIcon: Icon(
                            Icons.lock_rounded,
                            color: tertiaryColour,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _isVisible1 = !_isVisible1;
                              });
                            },
                            child: !_isVisible1
                                ? Icon(
                                    Icons.visibility_rounded,
                                    color: blackColour,
                                  )
                                : Icon(
                                    Icons.visibility_off_rounded,
                                    color: blackColour,
                                  ),
                          ),
                        ),
                        obscureText: !_isVisible1,
                        onChanged: (String? value) {
                          setState(() {
                            _password1 = value!;
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
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: primaryColour.withOpacity(0.1),
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
                          hintText: "********",
                          labelText: "Confirm Password",
                          labelStyle: defaultText.copyWith(
                              fontSize: 14,
                              color: blackColour,
                              fontWeight: FontWeight.w600),
                          floatingLabelStyle: defaultText.copyWith(
                              fontSize: 14,
                              color: primaryColour,
                              fontWeight: FontWeight.bold),
                          focusColor: primaryColour,
                          prefixIcon: Icon(
                            Icons.lock_outline_rounded,
                            color: tertiaryColour,
                          ),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _isVisible2 = !_isVisible2;
                              });
                            },
                            child: !_isVisible2
                                ? Icon(
                                    Icons.visibility_rounded,
                                    color: blackColour,
                                  )
                                : Icon(
                                    Icons.visibility_off_rounded,
                                    color: blackColour,
                                  ),
                          ),
                        ),
                        obscureText: !_isVisible2,
                        onChanged: (String? value) {
                          setState(() {
                            _password2 = value!;
                          });
                        },
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Required!";
                          }
                          if (value != _password1) {
                            return "Password doesnt match!";
                          }
                          return null;
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
                              // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
                              final response = await request.postJson(
                                "http://127.0.0.1:8000/auth/register/",
                                jsonEncode(<String, String>{
                                  'full_name': _fullName,
                                  'username': _username,
                                  'email': _email,
                                  'status': _status!,
                                  'password1': _password1,
                                  'password2': _password2,
                                }),
                              );
                              if (response['status']) {
                                logInUser = User.fromJson(response);
                                // TODO: Ganti Ke App langsung
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Home()),
                                );
                                ScaffoldMessenger.of(context)
                                  ..hideCurrentSnackBar()
                                  ..showSnackBar(SnackBar(
                                      content: Text(
                                          "${logInUser!.message} Selamat datang, ${logInUser!.fullName}.")));
                                _formKey.currentState!.reset();
                              } else {
                                // String message = response['message'];
                                // Fluttertoast.showToast(
                                //   msg: message,
                                //   toastLength: Toast.LENGTH_SHORT,
                                //   gravity: ToastGravity.BOTTOM,
                                //   timeInSecForIosWeb: 1,
                                //   backgroundColor: primaryColour,
                                //   textColor: Colors.white,
                                //   webBgColor: "#DF760B",
                                //   webPosition: "center",
                                // );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: Text(
                            "Register",
                            style: defaultText.copyWith(
                                fontSize: 20, color: backgroundColour),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: defaultText.copyWith(
                              fontSize: 18,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return LoginModal(context);
                                },
                              );
                            },
                            child: Text(
                              "Login",
                              style: defaultText.copyWith(
                                fontSize: 18,
                                color: primaryColour,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
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
