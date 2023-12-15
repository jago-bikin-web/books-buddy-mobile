import 'package:books_buddy/shared/page.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FloatingButtonAdd extends StatelessWidget {
  final int toPage;
  const FloatingButtonAdd({
    super.key,
    required this.toPage,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PageProvider>(
      builder: (context, pageProvider, child) => Positioned(
        bottom: 80,
        right: 24,
        child: Material(
          borderRadius: BorderRadius.circular(100),
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              pageProvider.setPage(toPage);
            },
            splashColor: Colors.white,
            borderRadius: BorderRadius.circular(100),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: primaryColour,
              ),
              child: const Center(
                child: Icon(
                  Icons.add_rounded,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
