import 'package:books_buddy/shared/shared.dart';
import 'package:flutter/material.dart';

class ProfileItem extends StatelessWidget {
  final String title;
  final String value;

  const ProfileItem({
    required this.title,
    required this.value,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: defaultText.copyWith(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                value,
                style: defaultText.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Expanded(
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 12,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
      ],
    );
  }
}
