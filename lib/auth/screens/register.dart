// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:books_buddy/shared/shared.dart';

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
                                      color: Colors.red)),
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
                          labelText: "Full name",
                          hintText: "Full Name",
                          floatingLabelStyle: TextStyle(color: primaryColour),
                          prefixIcon: Icon(Icons.person_rounded),
                        ),
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
                          hintText: "Username",
                          labelText: "Username",
                          floatingLabelStyle: TextStyle(color: primaryColour),
                          prefixIcon: Icon(Icons.person_outline_rounded),
                        ),
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
                            hintText: "example@example.com",
                            labelText: "Email",
                            floatingLabelStyle: TextStyle(color: primaryColour),
                            prefixIcon: Icon(Icons.email_rounded)),
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
                        decoration: InputDecoration(
                          focusColor: primaryColour,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  BorderSide(color: primaryColour, width: 2)),
                          labelText: "Join as a ...",
                          floatingLabelStyle: TextStyle(color: primaryColour),
                        ),
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
                                  _isVisible1 = !_isVisible1;
                                });
                              },
                              child: !_isVisible1
                                  ? Icon(Icons.visibility_rounded)
                                  : Icon(Icons.visibility_off_rounded),
                            )),
                        obscureText: !_isVisible1,
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
                            labelText: "Confirm password",
                            floatingLabelStyle: TextStyle(color: primaryColour),
                            prefixIcon: Icon(Icons.lock_outline_rounded),
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  _isVisible2 = !_isVisible2;
                                });
                              },
                              child: !_isVisible2
                                  ? Icon(Icons.visibility_rounded)
                                  : Icon(Icons.visibility_off_rounded),
                            )),
                        obscureText: !_isVisible2,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SizedBox(
                        height: 60,
                        width: MediaQuery.of(context).size.width - 2 * 24,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColour,
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
                            onTap: (){},
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
