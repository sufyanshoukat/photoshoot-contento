# EmailJS Setup Guide for Contento Photography

This guide will walk you through setting up EmailJS to send booking notifications.

## 📋 Prerequisites

- An email account (Gmail recommended)
- Access to the EmailJS dashboard

## 🚀 Step-by-Step Setup

### 1. Create EmailJS Account

1. Go to [https://www.emailjs.com/](https://www.emailjs.com/)
2. Click **"Sign Up"** and create a free account
3. Verify your email address

### 2. Add Email Service

1. Log in to your EmailJS dashboard
2. Navigate to **"Email Services"** in the left sidebar
3. Click **"Add New Service"**
4. Choose your email provider (e.g., Gmail)
5. Follow the instructions to connect your email account:
   - **For Gmail:**
     - Click "Connect Account"
     - Sign in with your Google account
     - Grant necessary permissions
6. Save the service and note down your **Service ID** (e.g., `service_xyz123`)

### 3. Create Email Template

1. Navigate to **"Email Templates"** in the left sidebar
2. Click **"Create New Template"**
3. Name your template: `booking_notification`
4. Copy the content from `email_template.html` in the project root
5. Paste it into the **"Content"** tab
6. In the template, EmailJS uses `{{variable_name}}` syntax for dynamic values

#### Required Template Variables:

Make sure your template includes these variables:
- `{{to_email}}` - Recipient email (tracy@mycontento.com)
- `{{booking_id}}` - Unique booking identifier
- `{{booking_date}}` - Formatted booking date
- `{{booking_time}}` - Time slot
- `{{booking_status}}` - Current status
- `{{booking_created}}` - When booking was created
- `{{customer_name}}` - Customer's full name
- `{{customer_email}}` - Customer's email
- `{{customer_phone}}` - Customer's phone number
- `{{location_name}}` - Location name
- `{{location_address}}` - Location address
- `{{booking_notes}}` - Additional notes
- `{{subject}}` - Email subject line

7. In the **"Settings"** tab:
   - **To Email:** `{{to_email}}`
   - **From Name:** `Contento Photography`
   - **From Email:** Your verified email
   - **Subject:** `{{subject}}`
   - **Reply To:** `{{customer_email}}`

8. Click **"Save"** and note down your **Template ID** (e.g., `template_abc456`)

### 4. Get Your Public Key

1. Navigate to **"Account"** in the left sidebar
2. Go to the **"General"** tab
3. Find your **Public Key** (also called User ID)
4. Copy it (e.g., `user_def789`)

### 5. Configure the Flutter App

1. Open `lib/constants/emailjs_config.dart`
2. Replace the placeholder values with your actual credentials:

```dart
class EmailJSConfig {
  static const String serviceId = 'service_xyz123';      // Your Service ID
  static const String templateId = 'template_abc456';    // Your Template ID
  static const String publicKey = 'user_def789';         // Your Public Key
  
  static const String clientEmail = 'tracy@mycontento.com';
}
```

### 6. Install Dependencies

Run the following command in your project directory:

```bash
flutter pub get
```

### 7. Test the Integration

You can test the email service by calling:

```dart
bool success = await EmailJSService.instance.testEmailConfiguration();
if (success) {
  print('Email service is working!');
}
```

## 🎨 Customizing the Email Template

The HTML template is located at `email_template.html`. You can customize:

- **Colors:** Change the gradient colors in the header
- **Logo:** Add your company logo
- **Styling:** Modify padding, fonts, and spacing
- **Content:** Add or remove sections as needed

### Color Scheme Used:
- Primary: `#667eea` (Purple)
- Secondary: `#764ba2` (Dark Purple)
- Success: `#10b981` (Green)
- Warning: `#fbbf24` (Yellow)

## 🔒 Security Best Practices

1. **Never commit credentials:** The `emailjs_config.dart` file should be added to `.gitignore` in production
2. **Use environment variables:** For production, consider using environment variables
3. **Monitor usage:** Check your EmailJS dashboard regularly for quota usage
4. **Rate limiting:** EmailJS free tier has limits (200 emails/month)

## 📧 Email Features

The current implementation sends emails when:
- ✅ A new booking is created
- ✅ Booking status is updated (optional)

### Email Contains:
- Booking ID and status badge
- Date and time in readable format
- Customer information (name, email, phone)
- Location details
- Additional notes
- Professional styling with responsive design

## 🐛 Troubleshooting

### Email not sending?

1. **Check credentials:** Verify Service ID, Template ID, and Public Key are correct
2. **Check console:** Look for error messages in the Flutter console
3. **Verify email service:** Make sure your email service is connected in EmailJS dashboard
4. **Check quota:** Ensure you haven't exceeded your monthly email limit
5. **Test connection:** Use the `testEmailConfiguration()` method

### Template variables not showing?

1. Make sure variable names match exactly (case-sensitive)
2. Check that variables are wrapped in double curly braces: `{{variable_name}}`
3. Verify the template is saved in EmailJS dashboard

### Emails going to spam?

1. **Verify your domain:** In EmailJS settings, verify your sending domain
2. **Use professional content:** Avoid spam trigger words
3. **Add SPF/DKIM records:** Set up email authentication
4. **Whitelist sender:** Ask recipients to whitelist your email

## 📊 EmailJS Free Tier Limits

- 200 emails per month
- 2 email services
- 1 email template
- Limited support

For higher limits, consider upgrading to a paid plan.

## 🔗 Useful Links

- [EmailJS Documentation](https://www.emailjs.com/docs/)
- [EmailJS Dashboard](https://dashboard.emailjs.com/)
- [EmailJS Pricing](https://www.emailjs.com/pricing/)
- [Flutter EmailJS Package](https://pub.dev/packages/emailjs)

## ✅ Verification Checklist

Before deploying to production:

- [ ] EmailJS account created and verified
- [ ] Email service connected (Gmail/Outlook/etc.)
- [ ] Email template created with all required variables
- [ ] Service ID, Template ID, and Public Key configured
- [ ] Dependencies installed (`flutter pub get`)
- [ ] Test email sent successfully
- [ ] Email appears professional and renders correctly
- [ ] All booking information displays correctly
- [ ] Customer email is clickable (reply-to works)
- [ ] Mobile responsive design verified

## 📝 Notes

- The email will be sent to `tracy@mycontento.com` for every new booking
- Customers will receive confirmation via the app (you can extend this to send to customers too)
- Email sending is asynchronous and won't block the booking process
- Failed emails are logged but don't prevent booking creation

---

**Need Help?** Contact the development team or refer to the EmailJS documentation.
