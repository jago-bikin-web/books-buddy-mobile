// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:books_buddy/auth/screens/login.dart';
import 'package:books_buddy/auth/screens/register.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width * 2 / 3;
    double sizeBig = MediaQuery.of(context).size.width * 7 / 8;

    return Scaffold(
      backgroundColor: backgroundColour,
      body: SafeArea(
        bottom: false,
        child: Stack(children: [
          Positioned(
            bottom: -size / 2,
            right: -size / 2,
            child: Image.asset(
              "assets/images/blob.png",
              height: size,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            top: -sizeBig / 2,
            left: -sizeBig / 2,
            child: Image.asset(
              "assets/images/blob-1.png",
              height: sizeBig,
              fit: BoxFit.fill,
            ),
          ),
          ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              Image.asset(
                "assets/images/welcome.png",
                height: 333,
                fit: BoxFit.fill,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Welcome",
                style: defaultText.copyWith(
                    color: primaryColour, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              Text(
                "Books Buddy is your literary companion and ultimate online destination for all things related to books and literature.",
                style: defaultText.copyWith(
                    fontSize: 20, fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 60,
              ),
              Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width - 2 * 24,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: gradient),
                child: ElevatedButton(
                  onPressed: () {
                    // NOTE: MENAMPILKAN MODAL REGISTER
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return RegisterModal(context);
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      )),
                  child: Text(
                    "Create Account",
                    style: defaultText.copyWith(
                        fontSize: 20, color: backgroundColour),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width - 2 * 24,
                child: ElevatedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (context) {
                        return LoginModal(context);
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: backgroundColour,
                      surfaceTintColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: primaryColour,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      )),
                  child: Text(
                    "Login",
                    style: defaultText.copyWith(
                      fontSize: 20,
                      color: primaryColour,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  "© 2023 Books Buddy",
                  style:
                      defaultText.copyWith(fontSize: 16, color: primaryColour),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
