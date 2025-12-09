# 📊 EmailJS System Architecture

## System Overview

```
┌────────────────────────────────────────────────────────────────────┐
│                     FLUTTER APP (Client Side)                      │
│                                                                     │
│  ┌──────────────────────────────────────────────────────────────┐ │
│  │                      USER INTERFACE                          │ │
│  │                                                               │ │
│  │  ┌─────────────────┐                                         │ │
│  │  │ Book Photoshoot │  User fills form                       │ │
│  │  │     Screen      │  (Location, Date, Time, Notes)         │ │
│  │  └────────┬────────┘                                         │ │
│  │           │                                                   │ │
│  └───────────┼───────────────────────────────────────────────────┘ │
│              │                                                     │
│              ↓                                                     │
│  ┌───────────────────────────────────────────────────────────────┐ │
│  │               BOOKING CONTROLLER                              │ │
│  │                                                                │ │
│  │  createBooking() {                                            │ │
│  │    1. Validate data                                           │ │
│  │    2. Save to Firebase         ✅                            │ │
│  │    3. Trigger email (async)    📧                            │ │
│  │    4. Show success message                                    │ │
│  │  }                                                             │ │
│  └────────┬───────────────────────────────────┬──────────────────┘ │
│           │                                   │                    │
│           ↓                                   ↓                    │
│  ┌────────────────────┐           ┌──────────────────────┐       │
│  │   Firebase CRUD    │           │  EmailJS Service     │       │
│  │   Service          │           │                       │       │
│  │                    │           │  - sendBooking        │       │
│  │  - createDocument  │           │    Notification()     │       │
│  │  - updateDocument  │           │  - Format data        │       │
│  │  - deleteDocument  │           │  - Call EmailJS API   │       │
│  └────────┬───────────┘           └──────────┬────────────┘       │
│           │                                   │                    │
└───────────┼───────────────────────────────────┼────────────────────┘
            │                                   │
            ↓                                   ↓
┌───────────────────────┐           ┌──────────────────────┐
│   FIREBASE FIRESTORE  │           │   EmailJS Service    │
│                       │           │   (External API)     │
│  - Bookings Collection│           │                       │
│  - Users Collection   │           │  - Sends email       │
│  - Locations          │           │  - Uses template     │
│                       │           │  - Delivers to       │
│  ✅ Data Persisted    │           │    tracy@mycontento  │
└───────────────────────┘           └──────────┬───────────┘
                                                │
                                                ↓
                                    ┌──────────────────────┐
                                    │   EMAIL RECIPIENT    │
                                    │                       │
                                    │  tracy@mycontento.com│
                                    │                       │
                                    │  📧 Receives         │
                                    │     professional     │
                                    │     HTML email       │
                                    └──────────────────────┘
```

---

## Data Flow Diagram

```
┌─────────────────────────────────────────────────────────────────┐
│                         DATA FLOW                               │
└─────────────────────────────────────────────────────────────────┘

1. USER INPUT
   ┌──────────────────────┐
   │ Location: Central Park│
   │ Date: Dec 25, 2024   │
   │ Time: 2:00-3:00 PM   │
   │ Notes: Holiday shoot │
   └──────────┬───────────┘
              │
              ↓
2. VALIDATION
   ┌──────────────────────┐
   │ ✓ Location selected  │
   │ ✓ Date is future     │
   │ ✓ Time slot available│
   │ ✓ User authenticated │
   └──────────┬───────────┘
              │
              ↓
3. BOOKING MODEL
   ┌──────────────────────────────────┐
   │ BookingModel {                   │
   │   id: "BOOK_ABC123"              │
   │   userId: "user_001"             │
   │   locationId: "1"                │
   │   bookingDate: DateTime          │
   │   timeSlot: "2:00 PM - 3:00 PM"  │
   │   status: BookingStatus.pending  │
   │   notes: "Holiday shoot"         │
   │   createdAt: DateTime.now()      │
   │ }                                 │
   └──────────┬───────────────────────┘
              │
              ├──────────────┬──────────────────┐
              ↓              ↓                  ↓
   ┌──────────────┐  ┌─────────────┐  ┌────────────────┐
   │   FIREBASE   │  │  EMAIL JS   │  │   USER UI      │
   │              │  │             │  │                │
   │ Save booking │  │ Send email  │  │ Show success   │
   │ ✅ Done      │  │ 📧 Sending  │  │ ✅ Confirmed   │
   └──────────────┘  └─────────────┘  └────────────────┘
```

---

## Email Template Structure

```
┌────────────────────────────────────────────────────────┐
│                    EMAIL LAYOUT                        │
└────────────────────────────────────────────────────────┘

╔══════════════════════════════════════════════════════╗
║                    HEADER SECTION                    ║
║  Background: Purple Gradient (#667eea → #764ba2)    ║
║                                                       ║
║        📸 New Photoshoot Booking                     ║
║        Contento Photography Services                 ║
╠══════════════════════════════════════════════════════╣
║                                                       ║
║                   STATUS BADGE                       ║
║              [ PENDING ] ← Yellow badge              ║
║                                                       ║
╠══════════════════════════════════════════════════════╣
║                  BOOKING DETAILS                     ║
║  ┌────────────────────────────────────────┐         ║
║  │ Booking ID: BOOK_ABC123                │         ║
║  │ (Purple left border, gray background)  │         ║
║  └────────────────────────────────────────┘         ║
║                                                       ║
║  ┌─────────────────┐  ┌─────────────────┐          ║
║  │ 📅 DATE         │  │ 🕐 TIME         │          ║
║  │ (Blue BG)       │  │ (Green BG)      │          ║
║  │ Dec 25, 2024    │  │ 2:00-3:00 PM    │          ║
║  └─────────────────┘  └─────────────────┘          ║
╠══════════════════════════════════════════════════════╣
║               CUSTOMER INFORMATION                   ║
║  👤 Name:  John Doe                                 ║
║  📧 Email: john@example.com (clickable)             ║
║  📱 Phone: +1234567890                              ║
╠══════════════════════════════════════════════════════╣
║               LOCATION DETAILS                       ║
║  ┌────────────────────────────────────────┐         ║
║  │ 📍 Central Park Studio                 │         ║
║  │    123 Park Ave, New York, NY          │         ║
║  │ (Yellow background, orange border)     │         ║
║  └────────────────────────────────────────┘         ║
╠══════════════════════════════════════════════════════╣
║               ADDITIONAL NOTES                       ║
║  ┌────────────────────────────────────────┐         ║
║  │ 📝 Please bring props for              │         ║
║  │    holiday-themed photoshoot            │         ║
║  │ (Gray background)                       │         ║
║  └────────────────────────────────────────┘         ║
║                                                       ║
║  Booking created on Dec 9, 2025 3:30 PM             ║
╠══════════════════════════════════════════════════════╣
║                    FOOTER                            ║
║  Contento Photography Services                      ║
║  Creating memorable moments, one click at a time    ║
║  📧 tracy@mycontento.com                            ║
╚══════════════════════════════════════════════════════╝
```

---

## Configuration Flow

```
┌──────────────────────────────────────────────────────────┐
│            EMAILJS SETUP & CONFIGURATION                 │
└──────────────────────────────────────────────────────────┘

1. EmailJS Dashboard Setup
   ┌────────────────────────────────────┐
   │ https://www.emailjs.com/           │
   │                                    │
   │ → Create Account                   │
   │ → Add Email Service (Gmail)        │
   │ → Create Email Template            │
   │ → Copy Credentials                 │
   └─────────────┬──────────────────────┘
                 │
                 │ Service ID: service_xyz123
                 │ Template ID: template_abc456
                 │ Public Key: user_def789
                 ↓
2. Flutter App Configuration
   ┌────────────────────────────────────┐
   │ lib/constants/emailjs_config.dart  │
   │                                    │
   │ class EmailJSConfig {              │
   │   static const serviceId = '...';  │
   │   static const templateId = '...'; │
   │   static const publicKey = '...';  │
   │   static const clientEmail =       │
   │     'tracy@mycontento.com';        │
   │ }                                   │
   └─────────────┬──────────────────────┘
                 │
                 ↓
3. Service Initialization
   ┌────────────────────────────────────┐
   │ EmailJSService.instance            │
   │                                    │
   │ → Validates configuration          │
   │ → Ready to send emails             │
   │ → Non-blocking operations          │
   └────────────────────────────────────┘
```

---

## Error Handling Flow

```
┌──────────────────────────────────────────────────────────┐
│                   ERROR HANDLING                         │
└──────────────────────────────────────────────────────────┘

Booking Creation
       ↓
   Try Block
       ↓
   ┌───────────────────────┐
   │ Save to Firebase?     │
   └───────┬───────────────┘
           │
    ┌──────┴──────┐
    ↓             ↓
   YES           NO
    │             │
    │             └──→ Return false
    │                  Show error message
    ↓                  Booking NOT created
Email Trigger
    │
    ↓
Try Block (Non-blocking)
    │
    ┌─────────────────────┐
    │ EmailJS configured? │
    └──────┬──────────────┘
           │
    ┌──────┴──────┐
    ↓             ↓
   YES           NO
    │             │
    │             └──→ Log: "Not configured"
    │                  Continue (no throw)
    ↓
Send Email
    │
    ┌──────────────────┐
    │ Email sent?      │
    └──────┬───────────┘
           │
    ┌──────┴──────┐
    ↓             ↓
 SUCCESS       FAILURE
    │             │
    │             └──→ Log: "❌ Failed"
    │                  Continue (no throw)
    ↓
Log: "✅ Success"
    │
    ↓
Catch Block
    │
    └──→ Log error
         Continue (no throw)

RESULT: Booking ALWAYS created even if email fails
```

---

## File Structure Tree

```
photoshoot-contento/
│
├── lib/
│   ├── constants/
│   │   ├── emailjs_config.dart          ⭐ Configure credentials
│   │   ├── firebase_collections.dart
│   │   └── app_*.dart
│   │
│   ├── controller/
│   │   ├── booking_controller.dart      ⭐ Email trigger here
│   │   ├── auth_controller.dart
│   │   └── subscription_controller.dart
│   │
│   ├── models/
│   │   ├── booking_model.dart           📦 Booking data
│   │   ├── user_model.dart              📦 User data
│   │   └── ...
│   │
│   ├── services/
│   │   ├── emailjs_service.dart         ⭐ Main email service
│   │   ├── emailjs_example.dart         📖 Examples & tests
│   │   ├── firebase_crud.dart
│   │   ├── firebase_auth.dart
│   │   └── ...
│   │
│   └── view/
│       └── screens/
│           └── booking/
│               └── book_photoshoot_screen.dart
│
├── email_template.html                   📧 HTML email template
│
├── EMAILJS_QUICKSTART.md                 📖 5-min setup guide
├── EMAILJS_SETUP.md                      📖 Full setup guide
├── EMAILJS_IMPLEMENTATION.md             📖 Technical docs
├── EMAILJS_COMPLETE.md                   📖 Completion summary
├── EMAILJS_ARCHITECTURE.md               📖 This file
│
├── pubspec.yaml                          ✅ emailjs: ^4.0.0 added
│
└── README.md                             ✅ Updated with features
```

---

## Package Dependencies

```
emailjs: ^4.0.0
    │
    ├── Depends on: http (for API calls)
    ├── Platform: Web, iOS, Android, Desktop
    └── Purpose: Send emails via EmailJS API

Integration Points:
    │
    ├── BookingController → EmailJSService
    ├── EmailJSService → EmailJS Package
    ├── EmailJSConfig → Static configuration
    └── BookingModel & UserModel → Email data
```

---

## Security Architecture

```
┌────────────────────────────────────────────────────────┐
│                  SECURITY LAYERS                       │
└────────────────────────────────────────────────────────┘

1. Client Side (Flutter App)
   ┌──────────────────────────────────┐
   │ emailjs_config.dart              │
   │ ├── Service ID (public)          │
   │ ├── Template ID (public)         │
   │ ├── Public Key (public)          │
   │ └── Client Email (public)        │
   └──────────────┬───────────────────┘
                  │
                  ├─→ Use in development
                  └─→ Environment vars in production
                  
2. EmailJS Service (External)
   ┌──────────────────────────────────┐
   │ EmailJS Dashboard                │
   │ ├── Service authentication       │
   │ ├── Template access control      │
   │ ├── Rate limiting (200/month)    │
   │ └── Usage monitoring             │
   └──────────────┬───────────────────┘
                  │
                  └─→ Protected by EmailJS

3. Email Delivery
   ┌──────────────────────────────────┐
   │ Email Provider (Gmail/SMTP)      │
   │ ├── OAuth authentication         │
   │ ├── SPF/DKIM verification        │
   │ ├── Spam filtering               │
   │ └── Delivery tracking            │
   └──────────────────────────────────┘

Best Practices:
✅ No sensitive data in emails
✅ Rate limiting enforced
✅ Non-blocking implementation
✅ Error logging only (no sensitive info)
```

---

## Testing Strategy

```
┌────────────────────────────────────────────────────────┐
│                    TESTING FLOW                        │
└────────────────────────────────────────────────────────┘

Level 1: Configuration Test
   ┌──────────────────────────────────┐
   │ testEmailConfiguration()         │
   │                                  │
   │ ✓ Validates credentials          │
   │ ✓ Sends test email               │
   │ ✓ Confirms EmailJS connection   │
   └──────────────┬───────────────────┘
                  │
                  ↓
Level 2: Example Data Test
   ┌──────────────────────────────────┐
   │ sendBookingNotificationExample() │
   │                                  │
   │ ✓ Uses sample booking data       │
   │ ✓ Tests template variables       │
   │ ✓ Checks email formatting        │
   └──────────────┬───────────────────┘
                  │
                  ↓
Level 3: Integration Test
   ┌──────────────────────────────────┐
   │ Create real booking in app       │
   │                                  │
   │ ✓ Tests full flow                │
   │ ✓ Verifies Firebase integration  │
   │ ✓ Confirms email delivery        │
   └──────────────┬───────────────────┘
                  │
                  ↓
Level 4: Production Validation
   ┌──────────────────────────────────┐
   │ Monitor EmailJS dashboard        │
   │                                  │
   │ ✓ Check success rate             │
   │ ✓ Monitor quota usage            │
   │ ✓ Review delivery logs           │
   └──────────────────────────────────┘
```

---

## Scalability Considerations

```
Current Setup (Free Tier):
┌──────────────────────────┐
│ 200 emails/month         │
│ ≈ 6-7 bookings/day       │
│ Sufficient for startup   │
└──────────────────────────┘

Growth Path:
┌──────────────────────────────────────────────┐
│                                              │
│  200/month → 1,000/month → 5,000/month      │
│    Free    →  $9/month   →  $35/month       │
│                                              │
│  If exceeding 5,000/month:                  │
│  → Consider AWS SES                         │
│  → Implement own SMTP                       │
│  → Use SendGrid/Mailgun                     │
│                                              │
└──────────────────────────────────────────────┘

Future Enhancements:
├── Customer confirmation emails
├── Booking reminder emails (24h before)
├── Photo ready notifications
├── Booking status updates
├── SMS notifications (Twilio)
└── Push notifications (FCM)
```

---

**Architecture Documentation**  
**Version:** 1.0  
**Last Updated:** December 9, 2025  
**Status:** Complete & Production Ready
