# 🚀 EmailJS Quick Start Guide

## ⚡ Get Started in 5 Minutes

### Step 1: Create EmailJS Account (2 minutes)
1. Go to https://www.emailjs.com/
2. Click "Sign Up" (top right)
3. Use Google sign-in or email signup
4. Verify your email

### Step 2: Connect Email Service (1 minute)
1. In EmailJS dashboard, click **"Email Services"** → **"Add New Service"**
2. Choose **Gmail** (or your preferred provider)
3. Click **"Connect Account"** and sign in
4. Copy your **Service ID** (looks like: `service_xyz123`)

### Step 3: Create Email Template (1 minute)
1. Click **"Email Templates"** → **"Create New Template"**
2. Name it: `booking_notification`
3. **Copy-paste** the content from `email_template.html` into the template
4. Set **To Email:** `{{to_email}}`
5. Set **Subject:** `{{subject}}`
6. Set **Reply To:** `{{customer_email}}`
7. Copy your **Template ID** (looks like: `template_abc456`)

### Step 4: Get Public Key (30 seconds)
1. Click your profile icon → **"Account"**
2. Go to **"General"** tab
3. Copy your **Public Key** (looks like: `user_def789`)

### Step 5: Configure Flutter App (30 seconds)
Open `lib/constants/emailjs_config.dart` and update:

```dart
class EmailJSConfig {
  static const String serviceId = 'service_xyz123';      // ← Paste here
  static const String templateId = 'template_abc456';    // ← Paste here
  static const String publicKey = 'user_def789';         // ← Paste here
  
  static const String clientEmail = 'tracy@mycontento.com'; // ✓ Already set
}
```

### Step 6: Test! (30 seconds)

Run your app and create a booking, OR run this test code:

```dart
import 'package:contento/services/emailjs_service.dart';

// Test email configuration
await EmailJSService.instance.testEmailConfiguration();
```

**Check tracy@mycontento.com** for the email! 📧

---

## 📧 What You'll Receive

Every booking will send a professional email to **tracy@mycontento.com** containing:

- 🆔 Booking ID
- 📅 Booking Date & Time
- 👤 Customer Name, Email, Phone
- 📍 Location Name & Address
- 📝 Additional Notes
- 🏷️ Status Badge

---

## ✅ That's It!

You're ready to receive booking notifications. The email will be sent **automatically** every time a customer creates a booking.

---

## 🔧 Need Help?

- **Full Setup Guide:** See `EMAILJS_SETUP.md`
- **Implementation Details:** See `EMAILJS_IMPLEMENTATION.md`
- **Code Examples:** See `lib/services/emailjs_example.dart`

---

## 🎯 Pro Tips

1. **Free Tier Limits:** 200 emails/month (upgrade if needed)
2. **Test First:** Use the test function before going live
3. **Check Spam:** First email might go to spam - whitelist the sender
4. **Monitor Usage:** Check EmailJS dashboard regularly

---

**Ready?** Set up takes less than 5 minutes! ⏱️
