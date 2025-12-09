import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contento/constants/firebase_collections.dart';
import 'package:contento/models/subscription_model.dart';
import 'package:contento/services/firebase_crud.dart';
import 'package:contento/utils/snackbars.dart';
import 'package:get/get.dart';

class SubscriptionController extends GetxController {
  // Observable variables
  var isLoading = false.obs;
  var currentSubscription = Rx<SubscriptionModel?>(null);
  var availablePlans = <SubscriptionPlan>[].obs;
  var subscriptionHistory = <SubscriptionModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadAvailablePlans();
  }

  // Load available subscription plans
  void loadAvailablePlans() {
    availablePlans.value = SubscriptionPlan.getAvailablePlans();
  }

  // Get current user subscription
  Future<void> getCurrentSubscription(String userId) async {
    try {
      isLoading.value = true;
      
      // Query for active subscription
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('subscriptions')
          .where('userId', isEqualTo: userId)
          .where('status', isEqualTo: SubscriptionStatus.active.name)
          .orderBy('createdAt', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        currentSubscription.value = SubscriptionModel.fromJson(
          querySnapshot.docs.first.data() as Map<String, dynamic>
        );
      } else {
        currentSubscription.value = null;
      }
    } catch (e) {
      print("Error fetching subscription: $e");
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Error", 
        message: "Failed to load subscription details"
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Get subscription history
  Future<void> getSubscriptionHistory(String userId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('subscriptions')
          .where('userId', isEqualTo: userId)
          .orderBy('createdAt', descending: true)
          .get();

      subscriptionHistory.value = querySnapshot.docs
          .map((doc) => SubscriptionModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Error fetching subscription history: $e");
    }
  }

  // Create new subscription
  Future<bool> createSubscription({
    required String userId,
    required SubscriptionType type,
    required double price,
    required int credits,
    required Duration duration,
  }) async {
    try {
      isLoading.value = true;

      String subscriptionId = FirebaseFirestore.instance
          .collection('subscriptions')
          .doc()
          .id;

      DateTime now = DateTime.now();
      DateTime endDate = now.add(duration);

      SubscriptionModel newSubscription = SubscriptionModel(
        id: subscriptionId,
        userId: userId,
        type: type,
        status: SubscriptionStatus.active,
        totalCredits: credits,
        usedCredits: 0,
        startDate: now,
        endDate: endDate,
        price: price,
        createdAt: now,
        updatedAt: now,
      );

      // Cancel any existing active subscription
      if (currentSubscription.value != null) {
        await cancelSubscription(currentSubscription.value!.id);
      }

      // Create new subscription
      await FirebaseCRUDService.instance.createDocument(
        collectionReference: subscriptionsCollection,
        docId: subscriptionId,
        data: newSubscription.toJson(),
      );

      currentSubscription.value = newSubscription;
      
      CustomSnackBars.instance.showSuccessSnackbar(
        title: "Success", 
        message: "Subscription activated successfully!"
      );
      
      return true;
    } catch (e) {
      print("Error creating subscription: $e");
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Error", 
        message: "Failed to create subscription"
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  // Use credit for booking
  Future<bool> useCredit(String subscriptionId) async {
    try {
      if (currentSubscription.value == null) {
        CustomSnackBars.instance.showFailureSnackbar(
          title: "No Subscription", 
          message: "Please purchase a subscription first"
        );
        return false;
      }

      if (currentSubscription.value!.remainingCredits <= 0) {
        CustomSnackBars.instance.showFailureSnackbar(
          title: "No Credits", 
          message: "You have no remaining credits. Please renew your subscription."
        );
        return false;
      }

      if (!currentSubscription.value!.isActive) {
        CustomSnackBars.instance.showFailureSnackbar(
          title: "Subscription Expired", 
          message: "Your subscription has expired. Please renew to continue."
        );
        return false;
      }

      // Update used credits
      SubscriptionModel updatedSubscription = currentSubscription.value!.copyWith(
        usedCredits: currentSubscription.value!.usedCredits + 1,
        updatedAt: DateTime.now(),
      );

      await FirebaseCRUDService.instance.updateDocument(
        collection: subscriptionsCollection,
        docId: subscriptionId,
        data: updatedSubscription.toJson(),
      );

      currentSubscription.value = updatedSubscription;
      
      return true;
    } catch (e) {
      print("Error using credit: $e");
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Error", 
        message: "Failed to use credit"
      );
      return false;
    }
  }

  // Cancel subscription
  Future<bool> cancelSubscription(String subscriptionId) async {
    try {
      if (currentSubscription.value == null) return false;
      
      SubscriptionModel updatedSubscription = currentSubscription.value!.copyWith(
        status: SubscriptionStatus.cancelled,
        updatedAt: DateTime.now(),
      );

      await FirebaseCRUDService.instance.updateDocument(
        collection: subscriptionsCollection,
        docId: subscriptionId,
        data: updatedSubscription.toJson(),
      );

      currentSubscription.value = updatedSubscription;
      
      CustomSnackBars.instance.showSuccessSnackbar(
        title: "Success", 
        message: "Subscription cancelled successfully"
      );
      
      return true;
    } catch (e) {
      print("Error cancelling subscription: $e");
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Error", 
        message: "Failed to cancel subscription"
      );
      return false;
    }
  }

  // Renew subscription
  Future<bool> renewSubscription({
    required String userId,
    required SubscriptionType type,
    required double price,
    required int credits,
    required Duration duration,
  }) async {
    return await createSubscription(
      userId: userId,
      type: type,
      price: price,
      credits: credits,
      duration: duration,
    );
  }

  // Check if user has active subscription
  bool get hasActiveSubscription {
    return currentSubscription.value?.isActive ?? false;
  }

  // Get remaining credits
  int get remainingCredits {
    return currentSubscription.value?.remainingCredits ?? 0;
  }

  // Get subscription type name
  String get subscriptionTypeName {
    return currentSubscription.value?.typeDisplayName ?? 'No Subscription';
  }

  // Get subscription status
  String get subscriptionStatus {
    return currentSubscription.value?.statusDisplayName ?? 'Inactive';
  }

  // Get days until expiration
  int get daysUntilExpiration {
    if (currentSubscription.value == null) return 0;
    
    DateTime now = DateTime.now();
    DateTime expiry = currentSubscription.value!.endDate;
    
    if (expiry.isBefore(now)) return 0;
    
    return expiry.difference(now).inDays;
  }

  // Format expiry date
  String get formattedExpiryDate {
    if (currentSubscription.value == null) return '';
    
    DateTime expiry = currentSubscription.value!.endDate;
    return "${expiry.day.toString().padLeft(2, '0')}-${expiry.month.toString().padLeft(2, '0')}-${expiry.year}";
  }
}