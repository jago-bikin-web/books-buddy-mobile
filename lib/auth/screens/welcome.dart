// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:books_buddy/auth/screens/login.dart';
import 'package:books_buddy/auth/screens/register.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColour,
      body: SafeArea(
        bottom: false,
        child: ListView(
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
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width - 2 * 24,
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
                    backgroundColor: const Color(0xFFDF760B),
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
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: primaryColour,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    )),
                child: Text(
                  "Login",
                  style:
                      defaultText.copyWith(fontSize: 20, color: primaryColour),
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
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(fontSize: 16),
                    color: const Color(0xFFDF760B),
                    fontWeight: FontWeight.w500,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
