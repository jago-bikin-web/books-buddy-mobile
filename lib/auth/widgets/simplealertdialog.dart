import 'package:flutter/material.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

class SimpleAlertDialog extends StatelessWidget {
  const SimpleAlertDialog({
    super.key,
    required this.title,
    required this.message,
    required this.imageAsset,
  });

  final String title;
  final String message;
  final String imageAsset;

  @override
  Widget build(BuildContext context) {
    return GiffyDialog(
      giffy: Container(
        padding: const EdgeInsets.all(8.0),
        child: Image.network(imageAsset, height: 200, fit: BoxFit.contain),
      ),
      backgroundColor: whiteColour,
      elevation: 0,
      shadowColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      title: Text(
        title,
        style: defaultText.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: primaryColour,
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        message,
        style: defaultText.copyWith(
          fontSize: 14,
          color: blackColour,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: Text(
            'OK',
            style: defaultText.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: primaryColour,
            ),
          ),
        ),
      ],
    );
  }
}
