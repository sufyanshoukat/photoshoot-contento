# 📸 Contento - Photography Booking App

A professional Flutter application for managing photography bookings with automated email notifications.

## ✨ Features

- 📅 **Booking Management** - Create and manage photoshoot bookings
- 📧 **Email Notifications** - Automatic email alerts to client (tracy@mycontento.com)
- 🔐 **Authentication** - Email and Google Sign-In
- 🏢 **Multiple Locations** - Support for various photoshoot locations
- 🔥 **Firebase Integration** - Cloud Firestore, Auth, and Storage
- 📱 **Responsive Design** - Beautiful UI with professional styling

## 🚀 Quick Start

### Prerequisites
- Flutter SDK (^3.6.0)
- Firebase project configured
- EmailJS account (for email notifications)

### Installation

1. **Clone the repository**
   ```bash
   git clone [repository-url]
   cd photoshoot-contento
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure EmailJS** (⚡ Takes 5 minutes)
   - Follow the guide in `EMAILJS_QUICKSTART.md`
   - Update credentials in `lib/constants/emailjs_config.dart`

4. **Run the app**
   ```bash
   flutter run
   ```

## 📧 Email Notification Setup

The app automatically sends professional email notifications to **tracy@mycontento.com** whenever a customer creates a booking.

### Quick Setup:
1. Create EmailJS account at https://www.emailjs.com/
2. Configure email service (Gmail recommended)
3. Create template using `email_template.html`
4. Update `lib/constants/emailjs_config.dart` with your credentials

**Detailed guides:**
- 📖 **Quick Start:** `EMAILJS_QUICKSTART.md` (5-minute setup)
- 📚 **Full Setup:** `EMAILJS_SETUP.md` (comprehensive guide)
- 💻 **Implementation:** `EMAILJS_IMPLEMENTATION.md` (technical details)

### Email Features:
- ✅ Professional HTML template with responsive design
- ✅ Booking details (date, time, location)
- ✅ Customer information (name, email, phone)
- ✅ Status badges and color-coded sections
- ✅ Automatic sending on booking creation
- ✅ Non-blocking (doesn't affect app performance)

## 🏗️ Project Structure

```
lib/
├── constants/
│   ├── emailjs_config.dart      # EmailJS configuration
│   └── firebase_collections.dart
├── controller/
│   ├── booking_controller.dart   # Booking logic with email integration
│   └── auth_controller.dart
├── models/
│   ├── booking_model.dart       # Booking data structure
│   └── user_model.dart
├── services/
│   ├── emailjs_service.dart     # Email notification service
│   ├── emailjs_example.dart     # Usage examples
│   ├── firebase_auth.dart
│   └── firebase_crud.dart
└── view/
    └── [UI screens]
```

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  get: ^4.7.2                      # State management
  firebase_core: ^4.2.1            # Firebase core
  cloud_firestore: ^6.1.0          # Database
  firebase_auth: ^6.1.2            # Authentication
  firebase_storage: ^13.0.4        # File storage
  emailjs: ^4.0.0                  # Email notifications ⭐
  intl: ^0.19.0                    # Date formatting
  cached_network_image: ^3.4.1
  google_sign_in: ^7.1.1
  shared_preferences: ^2.5.3
```

## 🔧 Configuration Files

- `lib/constants/emailjs_config.dart` - EmailJS credentials
- `lib/firebase_options.dart` - Firebase configuration
- `email_template.html` - Professional email template
- `android/app/google-services.json` - Android Firebase config

## 📱 How It Works

### Booking Flow:
1. User selects location, date, and time
2. User fills in additional notes (optional)
3. User submits booking
4. **Booking saved to Firebase** ✓
5. **Email sent to tracy@mycontento.com** 📧
6. User sees success confirmation

### Email Content:
- Booking ID and status
- Date and time of photoshoot
- Customer details (name, email, phone)
- Location information
- Additional notes
- Professional branding and styling

## 🎨 Email Template Preview

The email template features:
- **Purple gradient header** with app branding
- **Status badge** showing booking status
- **Color-coded info cards** for date (blue) and time (green)
- **Customer details table** with icons
- **Location highlight section** with yellow accent
- **Notes section** with gray background
- **Professional footer** with contact information

## 🧪 Testing

### Test Email Configuration:
```dart
import 'package:contento/services/emailjs_service.dart';

await EmailJSService.instance.testEmailConfiguration();
```

### Test with Example Code:
```dart
import 'package:contento/services/emailjs_example.dart';

await EmailJSExample.testEmailSetup();
await EmailJSExample.sendBookingNotificationExample();
```

### Create Real Booking:
1. Run the app
2. Navigate to booking screen
3. Complete booking form
4. Submit and check tracy@mycontento.com

## 📚 Documentation

- `EMAILJS_QUICKSTART.md` - 5-minute setup guide
- `EMAILJS_SETUP.md` - Comprehensive setup instructions
- `EMAILJS_IMPLEMENTATION.md` - Technical implementation details
- `FIREBASE_SETUP.md` - Firebase configuration guide
- `PROJECT_SUMMARY.md` - Project overview

## 🐛 Troubleshooting

### Email Not Sending?
1. Check credentials in `emailjs_config.dart`
2. Verify EmailJS service is active
3. Check console logs for error messages
4. Test with `testEmailConfiguration()`

### Common Issues:
- **"EmailJS is not configured"** → Update `emailjs_config.dart`
- **401 Error** → Wrong Service ID, Template ID, or Public Key
- **Template broken** → Verify all variables in EmailJS dashboard
- **Email in spam** → Whitelist sender email

See `EMAILJS_SETUP.md` for detailed troubleshooting.

## 🔐 Security

- EmailJS credentials should be secured in production
- Consider using environment variables for sensitive data
- Add `emailjs_config.dart` to `.gitignore` for production builds
- Monitor EmailJS quota usage (200 emails/month on free tier)

## 📊 Features Roadmap

- ✅ Email notifications to client
- ⬜ Customer confirmation emails
- ⬜ Booking reminder emails
- ⬜ Photo ready notifications
- ⬜ SMS notifications
- ⬜ Calendar integration

## 🤝 Contributing

This is a private project for Contento Photography Services.

## 📄 License

All rights reserved.

## 📞 Support

For issues or questions:
- Check documentation files
- Review code examples in `lib/services/emailjs_example.dart`
- Contact the development team

---

**Built with ❤️ using Flutter & Firebase**

**Email Integration:** EmailJS (https://www.emailjs.com/)  
**Client Email:** tracy@mycontento.com
