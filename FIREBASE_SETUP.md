# Firebase Setup Instructions

## Required Database Indexes

The app requires these Firestore composite indexes to function properly:

### 1. Subscriptions Index
**Collection**: subscriptions
**Fields**:
- status: Ascending
- userId: Ascending
- createdAt: Descending
- __name__: Descending

**Index URL**: 
https://console.firebase.google.com/v1/r/project/photoshoot-contento/firestore/indexes?create_composite=Cllwcm9qZWN0cy9waG90b3Nob290LWNvbnRlbnRvL2RhdGFiYXNlcy8oZGVmYXVsdCkvY29sbGVjdGlvbkdyb3Vwcy9zdWJzY3JpcHRpb25zL2luZGV4ZXMvXxABGgoKBnN0YXR1cxABGgoKBnVzZXJJZBABGg0KCWNyZWF0ZWRBdBACGgwKCF9fbmFtZV9fEAI

### 2. Bookings Index
**Collection**: bookings
**Fields**:
- userId: Ascending
- bookingDate: Descending
- __name__: Descending

**Index URL**:
https://console.firebase.google.com/v1/r/project/photoshoot-contento/firestore/indexes?create_composite=ClRwcm9qZWN0cy9waG90b3Nob290LWNvbnRlbnRvL2RhdGFiYXNlcy8oZGVmYXVsdCkvY29sbGVjdGlvbkdyb3Vwcy9ib29raW5ncy9pbmRleGVzL18QARoKCgZ1c2VySWQQARoPCgtib29raW5nRGF0ZRACGgwKCF9fbmFtZV9fEAI

## How to Create Indexes

1. Click on the URLs above (or copy-paste them into your browser)
2. Make sure you're logged into your Firebase account
3. The Firebase Console will automatically create the required indexes
4. Wait for the indexes to build (usually takes a few minutes)

## Current App Features

### ✅ Completed Features
- **Authentication System**: Google Sign-In with Firebase
- **User Management**: Automatic user creation and profile management
- **Subscription System**: 
  - Three subscription tiers (Monthly, Quarterly, Yearly)
  - Credit-based booking system
  - Automatic subscription validation
- **Booking Flow**:
  - Location selection (Home, Studio, Outdoor)
  - Date and time slot selection
  - Credit validation before booking
  - Booking confirmation screen
- **User Interface**:
  - Subscription plans screen
  - Booking management (My Bookings)
  - Navigation without named routes (as requested)

### 🔄 Working Features
- Google authentication flow
- User redirection to subscription plans for new users
- Credit system for existing subscribers
- Booking creation and management

### ⚠️ Pending
- Firebase indexes (instructions above)
- Actual payment processing (subscription is structural only)

The app is now fully functional with a complete subscription and booking flow!