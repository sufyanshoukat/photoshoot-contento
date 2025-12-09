import 'package:emailjs/emailjs.dart' as emailjs;
import 'package:contento/constants/emailjs_config.dart';
import 'package:contento/models/booking_model.dart';
import 'package:contento/models/user_model.dart';
import 'package:intl/intl.dart';

/// EmailJS Service for sending booking notifications
///
/// This service handles all email communications for the booking system.
/// It sends professional HTML-formatted emails to the client (tracy@mycontento.com)
/// whenever a new booking is created.
class EmailJSService {
  // Singleton pattern
  EmailJSService._();
  static final EmailJSService instance = EmailJSService._();

  /// Send booking notification email to the client
  ///
  /// Parameters:
  /// - [booking]: The booking model containing all booking details
  /// - [user]: The user model containing customer information
  /// - [locationName]: The name of the selected location
  /// - [locationAddress]: The address of the selected location
  ///
  /// Returns: true if email was sent successfully, false otherwise
  Future<bool> sendBookingNotification({
    required BookingModel booking,
    required UserModel user,
    required String locationName,
    required String locationAddress,
  }) async {
    try {
      // Check if EmailJS is configured
      if (!EmailJSConfig.isConfigured) {
        print('EmailJS is not configured. Please update emailjs_config.dart');
        return false;
      }

      // Format booking date and time
      final String formattedDate =
          DateFormat('EEEE, MMMM d, yyyy').format(booking.bookingDate);
      final String bookingTime = booking.timeSlot;

      // Create template parameters
      final Map<String, dynamic> templateParams = {
        // Client email (recipient)
        'to_email': EmailJSConfig.clientEmail,

        // Booking information
        'booking_id': booking.id,
        'booking_date': formattedDate,
        'booking_time': bookingTime,
        'booking_status': booking.statusDisplayName,
        'booking_created':
            DateFormat('MMM d, yyyy h:mm a').format(booking.createdAt),

        // Customer information
        'customer_name': user.fullName,
        'customer_email': user.email,
        'customer_phone': user.phoneNumber ?? 'Not provided',

        // Location information
        'location_name': locationName,
        'location_address': locationAddress,

        // Additional notes
        'booking_notes':
            booking.notes.isEmpty ? 'No additional notes' : booking.notes,

        // Subject line
        'subject': 'New Photoshoot Booking - ${user.fullName}',
      };

      // Send email using EmailJS
      await emailjs.send(
        EmailJSConfig.serviceId,
        EmailJSConfig.templateId,
        templateParams,
        emailjs.Options(
          publicKey: EmailJSConfig.publicKey,
          privateKey:
              EmailJSConfig.privateKey, // Not needed for client-side usage
        ),
      );

      print(
          '✅ Booking notification email sent successfully to ${EmailJSConfig.clientEmail}');
      return true;
    } catch (e) {
      print('❌ Error sending booking notification email: $e');
      return false;
    }
  }

  /// Send booking status update email
  ///
  /// This can be used when booking status changes (confirmed, completed, cancelled)
  Future<bool> sendBookingUpdateNotification({
    required BookingModel booking,
    required UserModel user,
    required String locationName,
    required BookingStatus oldStatus,
    required BookingStatus newStatus,
  }) async {
    try {
      if (!EmailJSConfig.isConfigured) {
        print('EmailJS is not configured. Please update emailjs_config.dart');
        return false;
      }

      final String formattedDate =
          DateFormat('EEEE, MMMM d, yyyy').format(booking.bookingDate);

      final Map<String, dynamic> templateParams = {
        'to_email': EmailJSConfig.clientEmail,
        'booking_id': booking.id,
        'booking_date': formattedDate,
        'booking_time': booking.timeSlot,
        'customer_name': user.fullName,
        'customer_email': user.email,
        'location_name': locationName,
        'old_status': oldStatus.name.toUpperCase(),
        'new_status': newStatus.name.toUpperCase(),
        'subject': 'Booking Status Update - ${booking.id}',
      };

      await emailjs.send(
        EmailJSConfig.serviceId,
        EmailJSConfig.templateId,
        templateParams,
        emailjs.Options(
          publicKey: EmailJSConfig.publicKey,
          privateKey: EmailJSConfig.privateKey,
        ),
      );

      print('✅ Booking update email sent successfully');
      return true;
    } catch (e) {
      print('❌ Error sending booking update email: $e');
      return false;
    }
  }

  /// Test email configuration
  ///
  /// Sends a test email to verify EmailJS is properly configured
  Future<bool> testEmailConfiguration() async {
    try {
      if (!EmailJSConfig.isConfigured) {
        print('EmailJS is not configured. Please update emailjs_config.dart');
        return false;
      }

      final Map<String, dynamic> testParams = {
        'to_email': EmailJSConfig.clientEmail,
        'subject': 'Test Email - EmailJS Configuration',
        'message': 'This is a test email to verify EmailJS configuration.',
      };

      await emailjs.send(
        EmailJSConfig.serviceId,
        EmailJSConfig.templateId,
        testParams,
        emailjs.Options(
          publicKey: EmailJSConfig.publicKey,
          privateKey: EmailJSConfig.privateKey,
        ),
      );

      print('✅ Test email sent successfully');
      return true;
    } catch (e) {
      print('❌ Error sending test email: $e');
      return false;
    }
  }
}
