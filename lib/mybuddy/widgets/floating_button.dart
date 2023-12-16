import 'package:books_buddy/shared/page.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FloatingButtonAdd extends StatelessWidget {
  final int toPage;
  final Animation<Offset> animation;
  const FloatingButtonAdd({
    super.key,
    required this.toPage,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<PageProvider>(
      builder: (context, pageProvider, child) => SlideTransition(
        position: animation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 60.0),
          child: FloatingActionButton(
            hoverColor: primaryColour.withOpacity(0.2),
            hoverElevation: 5,
            elevation: 3,
            shape: const CircleBorder(),
            onPressed: () {
              pageProvider.setPage(toPage);
            },
            backgroundColor: primaryColour, // Replace with your primary color
            child: const Icon(Icons.add_rounded, color: Colors.white, size: 40,),
          ),
        ),
      ),
    );
  }
}
