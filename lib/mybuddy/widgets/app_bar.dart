import 'package:books_buddy/shared/shared.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.elliptical(64, 32),
              bottomRight: Radius.elliptical(64, 32))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: 30,
              width: 30,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              width: 15,
            ),
            Text(
              "Books Buddy",
              style: defaultText.copyWith(
                color: primaryColour,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
