import 'package:books_buddy/shared/page.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Moduls extends StatelessWidget {
  final IconData icon;
  final String title;

  const Moduls({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PageProvider>(
      builder: (context, pageProvider, child) => Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 6,
              )
            ]),
        child: InkWell(
          onTap: () {
            if (title == "My Buddy") {
              pageProvider.setPage(1);
            } else if (title == "Find Buddy") {
              pageProvider.setPage(2);
            } else if (title == "Reach Buddy") {
              pageProvider.setPage(3);
            } else {
              pageProvider.setPage(4);
            }
          },
          borderRadius: BorderRadius.circular(13),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              width: 85,
              height: 80,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: defaultText.copyWith(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
