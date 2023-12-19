import 'package:books_buddy/shared/page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhotoProfile extends StatelessWidget {
  final String image;

  const PhotoProfile({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PageProvider>(
      builder: (context, pageProvider, child) => GestureDetector(
        onTap: () {
          pageProvider.setPage(5);
        },
        child: Hero(
          tag: "profile",
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: GestureDetector(
              child: Image.network(image),
            ),
          ),
        ),
      ),
    );
  }
}
