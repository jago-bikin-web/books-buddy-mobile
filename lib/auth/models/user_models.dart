// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

User? logInUser;

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    String username;
    String fullName;
    String email;
    String role;
    String profilePicture;
    bool status;
    String message;

    User({
        required this.username,
        required this.fullName,
        required this.email,
        required this.role,
        required this.profilePicture,
        required this.status,
        required this.message,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        username: json["username"],
        fullName: json["fullName"],
        email: json["email"],
        role: json["role"],
        profilePicture: json["profilePicture"],
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "username": username,
        "fullName": fullName,
        "email": email,
        "role": role,
        "profilePicture": profilePicture,
        "status": status,
        "message": message,
    };
}
