import 'package:flutter/material.dart';
import 'package:books_buddy/reachbuddy/widgets/book_section_find.dart';
import 'package:books_buddy/shared/shared.dart';

class FindBuddy extends StatefulWidget {
  const FindBuddy({super.key});

  @override
  State<FindBuddy> createState() => _FindBuddyState();
}

class _FindBuddyState extends State<FindBuddy> {
  static int bookpk = 0;
  static String bookTitle = "";

  void _handleIdSelected(int pk) {
    setState(() {
      bookpk = pk;
    });
  }
  void _handleBookSelected(String title) {
    setState(() {
      bookTitle = title;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColour, // Set the background color
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
              icon: Icon(Icons.close),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Text(
                "Choose the Book",
                style: defaultText.copyWith(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            BookSection(onIdSelected: _handleIdSelected, onTitleSelected: _handleBookSelected,),
            SizedBox(height: 60), // Additional spacing at the bottom
          ],
        ),
      ),
      floatingActionButton: bookpk != 0
          ? Padding(
              padding: EdgeInsets.only(bottom: 40), // Positioning the FAB
              child: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.pop(context);
                  bookpk = 0;
                },
                extendedPadding: EdgeInsets.only(left: 70, right: 70),
                backgroundColor: primaryColour,
                label: bookTitle.length > 30
                ? Text(
                  'You chose ${bookTitle.substring(0, 30)}..',
                  style: defaultText.copyWith(
                      color: whiteColour,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ) // Label for the FAB
                : Text(
                  'You chose ${bookTitle}',
                  style: defaultText.copyWith(
                      color: whiteColour,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ), // Label for the FAB
                icon: Icon(
                  Icons.book_outlined,
                  color: whiteColour,
                ), // Icon for the FAB
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(30)), // Rounded Rectangle shape
                ),
              ),
            )
          : null,
      floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat, // FAB at the bottom center
    );
  }
}
