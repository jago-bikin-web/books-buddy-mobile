// import 'package:books_buddy/auth/screens/welcome.dart';

// ignore_for_file: prefer_const_constructors

import 'package:books_buddy/auth/screens/welcome.dart';
import 'package:books_buddy/home/home.dart';
import 'package:books_buddy/shared/page.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) {
            CookieRequest request = CookieRequest();
            return request;
          },
        ),
        ChangeNotifierProvider(
          create: (context) => PageProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
