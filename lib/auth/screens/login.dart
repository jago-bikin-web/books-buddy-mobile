// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronous, use_build_context_synchronously

import 'package:books_buddy/auth/models/user_models.dart';
import 'package:books_buddy/auth/screens/register.dart';
import 'package:books_buddy/home/home.dart';
import 'package:flutter/material.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
// import 'package:fluttertoast/fluttertoast.dart';

class LoginModal extends StatefulWidget {
  final BuildContext context;
  const LoginModal(this.context, {super.key});

  @override
  State<LoginModal> createState() => _LoginModalState();
}

class _LoginModalState extends State<LoginModal> {
  final _formKey = GlobalKey<FormState>();
  String _username = "";
  String _password = "";

  bool _isVisible = false;

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
                                "Welcome Back!",
                                style: defaultText.copyWith(
                                    fontSize: 20, color: blackColour),
                              ),
                              Text(
                                "Login",
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
                                      color: primaryColour)),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: primaryColour, width: 2)),
                          focusColor: primaryColour,
                          labelText: "Username",
                          hintText: "Username",
                          floatingLabelStyle: TextStyle(color: primaryColour),
                          prefixIcon: Icon(Icons.person_rounded),
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
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: primaryColour, width: 2)),
                          focusColor: primaryColour,
                          hintText: "********",
                          labelText: "Password",
                          floatingLabelStyle: TextStyle(color: primaryColour),
                          prefixIcon: Icon(Icons.lock_rounded),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _isVisible = !_isVisible;
                              });
                            },
                            child: !_isVisible
                                ? Icon(Icons.visibility_rounded)
                                : Icon(Icons.visibility_off_rounded),
                          ),
                        ),
                        obscureText: !_isVisible,
                        onChanged: (String? value) {
                          setState(() {
                            _password = value!;
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
                              final response = await request.login(
                                "https://books-buddy-e06-tk.pbp.cs.ui.ac.id/auth/login/",
                                {
                                  'username': _username,
                                  'password': _password,
                                },
                              );

                              if (request.loggedIn) {
                                logInUser = User.fromJson(response);
                                // TODO: Navigasi ke main App
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

                              _formKey.currentState!.reset();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: Text(
                            "Login",
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
                            "Don't have an account? ",
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
                                  return RegisterModal(context);
                                },
                              );
                            },
                            child: Text(
                              "Register",
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
