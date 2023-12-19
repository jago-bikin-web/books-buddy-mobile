import 'package:books_buddy/findbuddy/screens/request_book.dart';
import 'package:books_buddy/findbuddy/widgets/animated_sheet.dart';
import 'package:books_buddy/findbuddy/widgets/book_section.dart';
import 'package:books_buddy/mybuddy/widgets/app_bar.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:flutter/material.dart';

class FindBuddy extends StatefulWidget {
  const FindBuddy({super.key});

  @override
  State<FindBuddy> createState() => _FindBuddyState();
}

class AddButton extends StatelessWidget {
  const AddButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: primaryColour, // Ganti dengan warna primer Anda
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0), // Sesuaikan dengan kebutuhan
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          ),
          onPressed: () {
            _navigateToRequestBook(context);
          },
          child: Text(
            'Request Book',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _navigateToRequestBook(BuildContext context) {
    Navigator.push(
  context,
  PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => AnimatedBottomSheet(),
  ),
);
  }
}

class _FindBuddyState extends State<FindBuddy> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: backgroundColour,
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TopBar(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 8,
                  ),
                  child: Divider(
                    color: primaryColour,
                    thickness: 2,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Text(
                        "Discover Your Book",
                        style: defaultText.copyWith(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  const BookSection(),
                  const SizedBox(
                    height: 60,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
                bottom: 60,
                left: 0,
                right: 0,
                child: Center(
                  child: const AddButton(),
                  ),
                ),
        ],
      ),
    );
  }
}