import 'package:books_buddy/shared/shared.dart';
import 'package:flutter/material.dart';

class ChipFilter extends StatelessWidget {
  const ChipFilter({super.key, required this.filter, required this.text});

  final String filter;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1.5),
      decoration: BoxDecoration(
        color: (filter == text) ? whiteColour : primaryColour,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Text(
          text,
          style: defaultText.copyWith(
            color: (filter == text) ? primaryColour : whiteColour,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}