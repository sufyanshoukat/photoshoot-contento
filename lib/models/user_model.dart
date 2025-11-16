import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String firstName;
  final String lastName;
  final String email;
  final String? phoneNumber;
  final String? countryCode;
  final String? dateOfBirth;
  final String authType; // EMAIL or GOOGLE
  final DateTime createdAt;
  final String? profileImageUrl;

  UserModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.email,
    this.phoneNumber,
    this.countryCode,
    this.dateOfBirth,
    required this.authType,
    required this.createdAt,
    this.profileImageUrl,
  });

  // Convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phoneNumber': phoneNumber,
      'countryCode': countryCode,
      'dateOfBirth': dateOfBirth,
      'authType': authType,
      'createdAt': Timestamp.fromDate(createdAt),
      'profileImageUrl': profileImageUrl,
    };
  }

  // Create UserModel from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'] ?? '',
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'],
      countryCode: json['countryCode'],
      dateOfBirth: json['dateOfBirth'],
      authType: json['authType'] ?? 'EMAIL',
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      profileImageUrl: json['profileImageUrl'],
    );
  }

  // Get full name
  String get fullName => '$firstName $lastName';
}
