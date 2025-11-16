import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contento/constants/firebase_collections.dart';
import 'package:contento/models/user_model.dart';
import 'package:contento/services/firebase_auth.dart';
import 'package:contento/services/firebase_crud.dart';
import 'package:contento/utils/snackbars.dart';
import 'package:contento/view/screens/auth/login.dart';
import 'package:contento/view/screens/my_nav_bar/my_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AuthController extends GetxController {
  // Text Controllers for Sign Up
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // Text Controllers for Login
  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  // Text Controllers for Change Password
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Observable variables
  var selectedCountryCode = '+1'.obs;
  var selectedCountryFlag = '🇺🇸'.obs;
  var isLoading = false.obs;
  var rememberMe = false.obs;

  // Current user data
  Rx<UserModel?> currentUser = Rx<UserModel?>(null);

  @override
  void onInit() {
    super.onInit();
    checkUserLoggedIn();
  }

  @override
  void onClose() {
    // Dispose controllers
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    dobController.dispose();
    phoneController.dispose();
    loginEmailController.dispose();
    loginPasswordController.dispose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // Update selected country
  void updateCountry(String code, String flag) {
    selectedCountryCode.value = code;
    selectedCountryFlag.value = flag;
  }

  // Check if user is already logged in
  void checkUserLoggedIn() async {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      await fetchUserData(firebaseUser.uid);
      if (currentUser.value != null) {
        Get.offAll(() => MyNavBar());
      }
    }
  }

  // Fetch user data from Firestore
  Future<void> fetchUserData(String uid) async {
    try {
      DocumentSnapshot? doc = await FirebaseCRUDService.instance
          .readSingleDocument(collectionReference: userCollection, docId: uid);

      if (doc != null && doc.exists) {
        currentUser.value =
            UserModel.fromJson(doc.data() as Map<String, dynamic>);
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  // Pick Date of Birth
  Future<void> pickDOB(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate:
          DateTime.now().subtract(Duration(days: 6570)), // 18 years ago
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      dobController.text = formattedDate;
    }
  }

  // Validation
  bool validateSignUp() {
    if (firstNameController.text.trim().isEmpty) {
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Error",
        message: "Please enter your first name",
      );
      return false;
    }

    if (lastNameController.text.trim().isEmpty) {
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Error",
        message: "Please enter your last name",
      );
      return false;
    }

    if (emailController.text.trim().isEmpty) {
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Error",
        message: "Please enter your email",
      );
      return false;
    }

    if (!GetUtils.isEmail(emailController.text.trim())) {
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Error",
        message: "Please enter a valid email",
      );
      return false;
    }

    if (dobController.text.trim().isEmpty) {
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Error",
        message: "Please select your date of birth",
      );
      return false;
    }

    if (phoneController.text.trim().isEmpty) {
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Error",
        message: "Please enter your phone number",
      );
      return false;
    }

    if (passwordController.text.trim().isEmpty) {
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Error",
        message: "Please enter your password",
      );
      return false;
    }

    if (passwordController.text.trim().length < 6) {
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Error",
        message: "Password must be at least 6 characters",
      );
      return false;
    }

    return true;
  }

  bool validateLogin() {
    if (loginEmailController.text.trim().isEmpty) {
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Error",
        message: "Please enter your email",
      );
      return false;
    }

    if (!GetUtils.isEmail(loginEmailController.text.trim())) {
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Error",
        message: "Please enter a valid email",
      );
      return false;
    }

    if (loginPasswordController.text.trim().isEmpty) {
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Error",
        message: "Please enter your password",
      );
      return false;
    }

    return true;
  }

  // Sign Up with Email and Password
  Future<void> signUpWithEmail() async {
    if (!validateSignUp()) return;

    isLoading.value = true;

    try {
      User? user =
          await FirebaseAuthService.instance.signUpUsingEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (user != null) {
        // Create user data in Firestore
        UserModel newUser = UserModel(
          uid: user.uid,
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          email: emailController.text.trim(),
          phoneNumber: phoneController.text.trim(),
          countryCode: selectedCountryCode.value,
          dateOfBirth: dobController.text.trim(),
          authType: 'EMAIL',
          createdAt: DateTime.now(),
        );

        bool created = await FirebaseCRUDService.instance.createDocument(
          collectionReference: userCollection,
          docId: user.uid,
          data: newUser.toJson(),
        );

        if (created) {
          currentUser.value = newUser;
          CustomSnackBars.instance.showSuccessSnackbar(
            title: "Success",
            message: "Account created successfully!",
          );

          // Clear fields
          clearSignUpFields();

          // Navigate to home
          Get.offAll(() => MyNavBar());
        }
      }
    } catch (e) {
      print("Error during sign up: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Login with Email and Password
  Future<void> loginWithEmail() async {
    if (!validateLogin()) return;

    isLoading.value = true;

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: loginEmailController.text.trim(),
        password: loginPasswordController.text.trim(),
      );

      if (userCredential.user != null) {
        await fetchUserData(userCredential.user!.uid);

        if (currentUser.value != null) {
          CustomSnackBars.instance.showSuccessSnackbar(
            title: "Success",
            message: "Logged in successfully!",
          );

          // Clear fields
          loginEmailController.clear();
          loginPasswordController.clear();

          // Navigate to home
          Get.offAll(() => MyNavBar());
        }
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Login failed";

      switch (e.code) {
        case 'user-not-found':
          errorMessage = "No user found with this email";
          break;
        case 'wrong-password':
          errorMessage = "Incorrect password";
          break;
        case 'invalid-email':
          errorMessage = "Invalid email address";
          break;
        case 'user-disabled':
          errorMessage = "This account has been disabled";
          break;
        default:
          errorMessage = e.message ?? "Login failed";
      }

      CustomSnackBars.instance.showFailureSnackbar(
        title: "Login Error",
        message: errorMessage,
      );
    } catch (e) {
      print("Error during login: $e");
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Error",
        message: "An unexpected error occurred",
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Sign In with Google
  Future<void> signInWithGoogle() async {
    isLoading.value = true;

    try {
      var result = await FirebaseAuthService.instance.authWithGoogle();
      User? user = result.$1;
      bool isExist = result.$3;

      if (user != null) {
        if (!isExist) {
          // Create new user in Firestore
          UserModel newUser = UserModel(
            uid: user.uid,
            firstName: user.displayName?.split(' ').first ?? 'User',
            lastName: user.displayName?.split(' ').last ?? '',
            email: user.email ?? '',
            authType: 'GOOGLE',
            createdAt: DateTime.now(),
            profileImageUrl: user.photoURL,
          );

          bool created = await FirebaseCRUDService.instance.createDocument(
            collectionReference: userCollection,
            docId: user.uid,
            data: newUser.toJson(),
          );

          if (created) {
            currentUser.value = newUser;
          }
        } else {
          // Fetch existing user data
          await fetchUserData(user.uid);
        }

        CustomSnackBars.instance.showSuccessSnackbar(
          title: "Success",
          message: "Signed in with Google successfully!",
        );

        // Navigate to home
        Get.offAll(() => MyNavBar());
      }
    } catch (e) {
      print("Error during Google sign in: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Change Password
  Future<void> changePassword() async {
    // Check if user signed in with Google
    if (currentUser.value?.authType == 'GOOGLE') {
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Error",
        message: "You cannot change password for Google sign-in accounts",
      );
      return;
    }

    if (oldPasswordController.text.trim().isEmpty) {
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Error",
        message: "Please enter your old password",
      );
      return;
    }

    if (newPasswordController.text.trim().isEmpty) {
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Error",
        message: "Please enter your new password",
      );
      return;
    }

    if (newPasswordController.text.trim().length < 6) {
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Error",
        message: "Password must be at least 6 characters",
      );
      return;
    }

    if (confirmPasswordController.text.trim() !=
        newPasswordController.text.trim()) {
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Error",
        message: "Passwords do not match",
      );
      return;
    }

    isLoading.value = true;

    try {
      await FirebaseAuthService.instance.changeFirebasePassword(
        email: currentUser.value!.email,
        oldPassword: oldPasswordController.text.trim(),
        newPassword: newPasswordController.text.trim(),
      );

      CustomSnackBars.instance.showSuccessSnackbar(
        title: "Success",
        message: "Password changed successfully!",
      );

      // Clear fields
      oldPasswordController.clear();
      newPasswordController.clear();
      confirmPasswordController.clear();

      Get.back();
    } catch (e) {
      print("Error changing password: $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      currentUser.value = null;

      CustomSnackBars.instance.showSuccessSnackbar(
        title: "Success",
        message: "Logged out successfully!",
      );

      Get.offAll(() => LoginPage());
    } catch (e) {
      print("Error during logout: $e");
      CustomSnackBars.instance.showFailureSnackbar(
        title: "Error",
        message: "Failed to logout",
      );
    }
  }

  // Clear sign up fields
  void clearSignUpFields() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    passwordController.clear();
    dobController.clear();
    phoneController.clear();
    selectedCountryCode.value = '+1';
    selectedCountryFlag.value = '🇺🇸';
  }
}
