/// EmailJS Configuration Constants
///
/// To set up EmailJS:
/// 1. Go to https://www.emailjs.com/
/// 2. Create an account and verify your email
/// 3. Add an email service (e.g., Gmail)
/// 4. Create an email template with the variables used in the service
/// 5. Copy your Service ID, Template ID, and Public Key
/// 6. Replace the values below with your actual credentials
///
/// Important: Keep these credentials secure in production!
library;

class EmailJSConfig {
  // EmailJS Service ID
  // Get this from: https://dashboard.emailjs.com/admin/services
  static const String serviceId = 'service_cbbxhmp';

  // EmailJS Template ID
  // Get this from: https://dashboard.emailjs.com/admin/templates
  static const String templateId = 'template_3ly93br';

  // EmailJS Public Key (User ID)
  // Get this from: https://dashboard.emailjs.com/admin/account
  static const String publicKey = 'smg9uwh8Mq-JdDvET';

  // Get this from: https://dashboard.emailjs.com/admin/account
  static const String privateKey = 'SXRofr0aPD1Q4wyi8uga4';

  // Client email where all bookings will be sent
  static const String clientEmail = 'tracy@mycontento.com';

  // Validate configuration
  static bool get isConfigured {
    return serviceId != 'YOUR_SERVICE_ID' &&
        templateId != 'YOUR_TEMPLATE_ID' &&
        publicKey != 'YOUR_PUBLIC_KEY';
  }
}
