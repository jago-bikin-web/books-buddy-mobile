import 'package:books_buddy/findbuddy/screens/request_book.dart';
import 'package:flutter/material.dart';

class AnimatedBottomSheet extends StatefulWidget {
  @override
  _AnimatedBottomSheetState createState() => _AnimatedBottomSheetState();
}

class _AnimatedBottomSheetState extends State<AnimatedBottomSheet> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _offsetAnimation = Tween<Offset>(
      begin: Offset(0.0, 1.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return SlideTransition(
            position: _offsetAnimation,
            child: child,
          );
        },
        child: RequestBook(), // Ganti dengan halaman yang ingin dianimasikan
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: AnimatedBottomSheet(),
    ),
  );
}
