import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contento/constants/firebase_collections.dart';
import 'package:contento/models/booking_model.dart';
import 'package:contento/services/firebase_crud.dart';
import 'package:contento/utils/snackbars.dart';
import 'package:contento/controller/subscription_controller.dart';
import 'package:contento/controller/auth_controller.dart';
import 'package:get/get.dart';

class BookingController extends GetxController {
  // Observable variables
  var isLoading = false.obs;
  var userBookings = <BookingModel>[].obs;
  var selectedLocation = Rx<LocationModel?>(null);
  var selectedDate = Rx<DateTime?>(null);
  var selectedTimeSlot = Rx<String?>(null);
  var availableLocations = <LocationModel>[].obs;
  var bookingNotes = ''.obs;

  // Dependencies
  final SubscriptionController subscriptionController =
      Get.find<SubscriptionController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    loadAvailableLocations();
  }

  // Load available locations
  void loadAvailableLocations() {
    availableLocations.value = LocationModel.getSampleLocations();
  }

  // Get user bookings
  Future<void> getUserBookings(String userId) async {
    try {
      isLoading.value = true;

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('bookings')
          .where('userId', isEqualTo: userId)
          .orderBy('bookingDate', descending: true)
          .get();

      userBookings.value = querySnapshot.docs
          .map((doc) =>
              BookingModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Error fetching bookings: $e");
      CustomSnackBars.instance.showFailureSnackbar(
          title: "Error", message: "Failed to load bookings");
    } finally {
      isLoading.value = false;
    }
  }

  // Create new booking
  Future<bool> createBooking() async {
    try {
      // Validate inputs
      if (!_validateBookingData()) return false;

      // TODO: Enable subscription check when needed
      // Check subscription and use credit (commented for now)
      // if (!subscriptionController.hasActiveSubscription) {
      //   CustomSnackBars.instance.showFailureSnackbar(
      //     title: "No Subscription",
      //     message: "Please purchase a subscription to book a photoshoot"
      //   );
      //   return false;
      // }

      isLoading.value = true;

      String bookingId =
          FirebaseFirestore.instance.collection('bookings').doc().id;

      DateTime now = DateTime.now();

      BookingModel newBooking = BookingModel(
        id: bookingId,
        userId: authController.currentUser.value!.uid,
        locationId: selectedLocation.value!.id,
        photographerId: 'default_photographer', // You can expand this later
        bookingDate: selectedDate.value!,
        timeSlot: selectedTimeSlot.value!,
        status: BookingStatus.pending,
        notes: bookingNotes.value,
        createdAt: now,
        updatedAt: now,
      );

      // TODO: Enable credit usage when subscription is active
      // Use a credit from subscription (commented for now)
      // bool creditUsed = await subscriptionController.useCredit(
      //   subscriptionController.currentSubscription.value!.id
      // );

      // if (!creditUsed) return false;

      // Create booking
      bool success = await FirebaseCRUDService.instance.createDocument(
        collectionReference: bookingsCollection,
        docId: bookingId,
        data: newBooking.toJson(),
      );

      if (success) {
        userBookings.insert(0, newBooking);
        _clearBookingForm();

        CustomSnackBars.instance.showSuccessSnackbar(
            title: "Booking Created",
            message: "Your photoshoot has been booked successfully!");

        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error creating booking: $e");
      CustomSnackBars.instance.showFailureSnackbar(
          title: "Error", message: "Failed to create booking");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Update booking status
  Future<bool> updateBookingStatus(
      String bookingId, BookingStatus status) async {
    try {
      BookingModel? booking =
          userBookings.firstWhereOrNull((b) => b.id == bookingId);
      if (booking == null) return false;

      BookingModel updatedBooking = booking.copyWith(
        status: status,
        updatedAt: DateTime.now(),
      );

      bool success = await FirebaseCRUDService.instance.updateDocument(
        collection: bookingsCollection,
        docId: bookingId,
        data: updatedBooking.toJson(),
      );

      if (success) {
        int index = userBookings.indexWhere((b) => b.id == bookingId);
        if (index != -1) {
          userBookings[index] = updatedBooking;
        }

        CustomSnackBars.instance.showSuccessSnackbar(
            title: "Booking Updated",
            message: "Booking status updated successfully");
      }

      return success;
    } catch (e) {
      print("Error updating booking: $e");
      CustomSnackBars.instance.showFailureSnackbar(
          title: "Error", message: "Failed to update booking");
      return false;
    }
  }

  // Cancel booking
  Future<bool> cancelBooking(String bookingId) async {
    return await updateBookingStatus(bookingId, BookingStatus.cancelled);
  }

  // Add photos to booking
  Future<bool> addPhotosToBooking(
      String bookingId, List<String> imageUrls) async {
    try {
      BookingModel? booking =
          userBookings.firstWhereOrNull((b) => b.id == bookingId);
      if (booking == null) return false;

      BookingModel updatedBooking = booking.copyWith(
        imageUrls: [...booking.imageUrls, ...imageUrls],
        updatedAt: DateTime.now(),
      );

      bool success = await FirebaseCRUDService.instance.updateDocument(
        collection: bookingsCollection,
        docId: bookingId,
        data: updatedBooking.toJson(),
      );

      if (success) {
        int index = userBookings.indexWhere((b) => b.id == bookingId);
        if (index != -1) {
          userBookings[index] = updatedBooking;
        }
      }

      return success;
    } catch (e) {
      print("Error adding photos: $e");
      return false;
    }
  }

  // Set selected location
  void setSelectedLocation(LocationModel location) {
    selectedLocation.value = location;
    selectedTimeSlot.value = null; // Reset time slot when location changes
  }

  // Set selected date
  void setSelectedDate(DateTime date) {
    selectedDate.value = date;
    selectedTimeSlot.value = null; // Reset time slot when date changes
  }

  // Set selected time slot
  void setSelectedTimeSlot(String timeSlot) {
    selectedTimeSlot.value = timeSlot;
  }

  // Set booking notes
  void setBookingNotes(String notes) {
    bookingNotes.value = notes;
  }

  // Get available time slots for selected location
  List<String> get availableTimeSlots {
    if (selectedLocation.value == null) return [];
    return selectedLocation.value!.availableTimeSlots;
  }

  // Validate booking data
  bool _validateBookingData() {
    if (selectedLocation.value == null) {
      CustomSnackBars.instance.showFailureSnackbar(
          title: "Location Required", message: "Please select a location");
      return false;
    }

    if (selectedDate.value == null) {
      CustomSnackBars.instance.showFailureSnackbar(
          title: "Date Required", message: "Please select a date");
      return false;
    }

    if (selectedDate.value!.isBefore(DateTime.now())) {
      CustomSnackBars.instance.showFailureSnackbar(
          title: "Invalid Date", message: "Please select a future date");
      return false;
    }

    if (selectedTimeSlot.value == null || selectedTimeSlot.value!.isEmpty) {
      CustomSnackBars.instance.showFailureSnackbar(
          title: "Time Slot Required", message: "Please select a time slot");
      return false;
    }

    return true;
  }

  // Clear booking form
  void _clearBookingForm() {
    selectedLocation.value = null;
    selectedDate.value = null;
    selectedTimeSlot.value = null;
    bookingNotes.value = '';
  }

  // Get bookings by status
  List<BookingModel> getBookingsByStatus(BookingStatus status) {
    return userBookings.where((booking) => booking.status == status).toList();
  }

  // Get upcoming bookings
  List<BookingModel> get upcomingBookings {
    DateTime now = DateTime.now();
    return userBookings
        .where((booking) =>
            (booking.status == BookingStatus.confirmed ||
                booking.status == BookingStatus.pending) &&
            booking.bookingDate.isAfter(now))
        .toList();
  }

  // Get completed bookings
  List<BookingModel> get completedBookings {
    return getBookingsByStatus(BookingStatus.completed);
  }

  // Get cancelled bookings
  List<BookingModel> get cancelledBookings {
    return getBookingsByStatus(BookingStatus.cancelled);
  }

  // Check if booking form is complete
  bool get isBookingFormComplete {
    return selectedLocation.value != null &&
        selectedDate.value != null &&
        selectedTimeSlot.value != null;
  }

  // Format booking date
  String formatBookingDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }
}
