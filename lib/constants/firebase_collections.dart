import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference userCollection =
    FirebaseFirestore.instance.collection('users');

CollectionReference subscriptionsCollection =
    FirebaseFirestore.instance.collection('subscriptions');

CollectionReference bookingsCollection =
    FirebaseFirestore.instance.collection('bookings');

CollectionReference locationsCollection =
    FirebaseFirestore.instance.collection('locations');
