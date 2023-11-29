import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
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
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(fontSize: 36),
                color: const Color(0xFFDF760B),
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "Books Buddy is your literary companion and ultimate online destination for all things related to books and literature.",
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(fontSize: 20),
                color: Colors.black54,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 60,
            ),
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width - 2 * 24,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFDF760B),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )),
                child: Text(
                  "Create Account",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(fontSize: 20),
                    color: const Color(0xFFFAFAFA),
                    fontWeight: FontWeight.w500,
                  ),
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFAFAFA),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Color(0xFFDF760B),
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(15),
                    )),
                child: Text(
                  "Login",
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(fontSize: 20),
                    color: const Color(0xFFDF760B),
                    fontWeight: FontWeight.w500,
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
