import 'package:flutter/material.dart';
import 'package:contento/services/emailjs_service.dart';
import 'package:contento/models/booking_model.dart';
import 'package:contento/models/user_model.dart';

/// Example usage of EmailJS service
///
/// This file demonstrates how to use the EmailJS service to send booking notifications.
/// You can use this as a reference for implementing email functionality in other parts of the app.

class EmailJSExample {
  /// Example 1: Send a booking notification
  /// This is automatically called in BookingController.createBooking()
  static Future<void> sendBookingNotificationExample() async {
    // Sample booking data
    final booking = BookingModel(
      id: 'BOOK_123456',
      userId: 'user_001',
      locationId: '1',
      photographerId: 'photographer_001',
      bookingDate: DateTime(2024, 12, 25, 14, 0),
      timeSlot: '2:00 PM - 3:00 PM',
      status: BookingStatus.pending,
      notes: 'Please bring props for a holiday-themed photoshoot',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // Sample user data
    final user = UserModel(
      uid: 'user_001',
      firstName: 'John',
      lastName: 'Doe',
      email: 'john.doe@example.com',
      phoneNumber: '+1234567890',
      authType: 'EMAIL',
      createdAt: DateTime.now(),
    );

    // Send the email
    bool success = await EmailJSService.instance.sendBookingNotification(
      booking: booking,
      user: user,
      locationName: 'Central Park Studio',
      locationAddress: '123 Park Ave, New York, NY',
    );

    if (success) {
      print('✅ Email sent successfully!');
    } else {
      print('❌ Failed to send email');
    }
  }

  /// Example 2: Send a booking status update notification
  static Future<void> sendStatusUpdateExample() async {
    final booking = BookingModel(
      id: 'BOOK_123456',
      userId: 'user_001',
      locationId: '1',
      photographerId: 'photographer_001',
      bookingDate: DateTime(2024, 12, 25, 14, 0),
      timeSlot: '2:00 PM - 3:00 PM',
      status: BookingStatus.confirmed,
      notes: 'Booking confirmed by photographer',
      createdAt: DateTime.now().subtract(Duration(hours: 2)),
      updatedAt: DateTime.now(),
    );

    final user = UserModel(
      uid: 'user_001',
      firstName: 'John',
      lastName: 'Doe',
      email: 'john.doe@example.com',
      authType: 'EMAIL',
      createdAt: DateTime.now(),
    );

    bool success = await EmailJSService.instance.sendBookingUpdateNotification(
      booking: booking,
      user: user,
      locationName: 'Central Park Studio',
      oldStatus: BookingStatus.pending,
      newStatus: BookingStatus.confirmed,
    );

    if (success) {
      print('✅ Status update email sent!');
    } else {
      print('❌ Failed to send status update');
    }
  }

  /// Example 3: Test email configuration
  /// Use this to verify your EmailJS setup is working correctly
  static Future<void> testEmailSetup() async {
    bool success = await EmailJSService.instance.testEmailConfiguration();

    if (success) {
      print('✅ EmailJS is configured correctly!');
    } else {
      print('❌ EmailJS configuration failed. Please check:');
      print('   1. Service ID in emailjs_config.dart');
      print('   2. Template ID in emailjs_config.dart');
      print('   3. Public Key in emailjs_config.dart');
      print('   4. EmailJS service is active in dashboard');
    }
  }

  /// Example 4: Create a test button in your UI
  /// Add this button to your debug screen to test email functionality
  static Widget buildTestEmailButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        // Show loading indicator
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        );

        // Send test email
        bool success = await EmailJSService.instance.testEmailConfiguration();

        // Close loading
        Navigator.pop(context);

        // Show result
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(success
                ? '✅ Test email sent to tracy@mycontento.com'
                : '❌ Failed to send test email'),
            backgroundColor: success ? Colors.green : Colors.red,
          ),
        );
      },
      child: Text('Test Email Configuration'),
    );
  }
}

// Usage in your app:
//
// 1. To test the email setup during development:
//    await EmailJSExample.testEmailSetup();
//
// 2. To manually send a booking notification:
//    await EmailJSExample.sendBookingNotificationExample();
//
// 3. To add a test button in your debug UI:
//    EmailJSExample.buildTestEmailButton(context)
