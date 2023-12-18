// ignore_for_file: use_build_context_synchronously

import 'package:books_buddy/auth/models/user_models.dart';
import 'package:books_buddy/auth/screens/welcome.dart';
import 'package:books_buddy/home/widgets/profile_section.dart';
import 'package:books_buddy/shared/page.dart';
import 'package:books_buddy/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Consumer<PageProvider>(
      builder: (context, pageProvider, child) => SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              height: 75,
              decoration: BoxDecoration(
                  color: backgroundColour,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.elliptical(64, 32),
                      bottomRight: Radius.elliptical(64, 32))),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 50),
              child: SizedBox(
                width: double.infinity,
                child: Hero(
                  tag: "profile",
                  child: Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(
                        fit: BoxFit.fill,
                        height: 120,
                        width: 120,
                        image: NetworkImage(
                          logInUser!.profilePicture,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.elliptical(64, 32),
                        topRight: Radius.elliptical(64, 32)),
                    color: backgroundColour),
                child: Padding(
                  padding: const EdgeInsets.only(top: 48, left: 24, right: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Profile Information",
                        style: defaultText.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      ProfileItem(
                          title: "Full Name", value: logInUser!.fullName),
                      ProfileItem(
                          title: "Username", value: logInUser!.username),
                      const SizedBox(
                        height: 16,
                      ),
                      Divider(
                        color: primaryColour,
                        thickness: 3,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Personal Information",
                        style: defaultText.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      ProfileItem(
                          title: "ID User",
                          value: logInUser!.userId.toString()),
                      ProfileItem(title: "Email", value: logInUser!.email),
                      ProfileItem(
                          title: "Role",
                          value:
                              (logInUser!.role == "M" ? "Member" : "Reguler")),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width - 2 * 24,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: gradient),
                          child: ElevatedButton(
                            onPressed: () async {
                              // TODO : INTEGRASIKAN LINK
                              final response = await request.logout(
                                "http://127.0.0.1:8000/auth/logout/",
                              );
                              String message = response["message"];
                              if (response['status']) {
                                logInUser = null;
                                pageProvider.page = 0;
                                String fullName = response["fullName"];
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content:
                                      Text("$message Sampai jumpa, $fullName."),
                                ));
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const WelcomePage()),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(message),
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            child: Text(
                              "Log Out",
                              style: defaultText.copyWith(
                                  fontSize: 20, color: backgroundColour),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
