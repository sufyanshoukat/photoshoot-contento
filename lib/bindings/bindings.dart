import 'package:contento/controller/auth_controller.dart';
import 'package:contento/controller/subscription_controller.dart';
import 'package:contento/controller/booking_controller.dart';
import 'package:get/get.dart';

class AuthBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<AuthController>(AuthController());
    Get.put<SubscriptionController>(SubscriptionController());
    Get.put<BookingController>(BookingController());
  }
}

// class HostBinding implements Bindings {
//   @override
//   void dependencies() {
//     Get.put<GuestHomeController>(
//         GuestHomeController()); // Need this for user data
//     Get.put<AddListingController>(AddListingController());
//     Get.put<HostBookingController>(HostBookingController());
//     Get.put<ChatController>(ChatController());
//   }
// }

// class AddlistingBindings implements Bindings {
//   @override
//   void dependencies() {
//   }
// }
