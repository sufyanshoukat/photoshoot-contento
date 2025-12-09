import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contento/constants/firebase_collections.dart';
import 'package:contento/services/firebase_crud.dart';
import 'package:contento/utils/snackbars.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl/intl.dart';

class FirebaseAuthService {
  //private constructor
  FirebaseAuthService._privateConstructor();

  //singleton instance variable
  static FirebaseAuthService? _instance;

  //This code ensures that the singleton instance is created only when it's accessed for the first time.
  //Subsequent calls to FirebaseCRUDService.instance will return the same instance that was created before.

  //getter to access the singleton instance
  static FirebaseAuthService get instance {
    _instance ??= FirebaseAuthService._privateConstructor();
    return _instance!;
  }

  //signing up user with email and password
  Future<User?> signUpUsingEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (FirebaseAuth.instance.currentUser != null) {
        User user = FirebaseAuth.instance.currentUser!;
        // Send email verification
        await user.sendEmailVerification();
        return user;
      }
      if (FirebaseAuth.instance.currentUser == null) {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      //showing failure snackbar
      CustomSnackBars.instance.showFailureSnackbar(
          title: 'Authentication Error', message: '${e.message}');

      return null;
    } on FirebaseException catch (e) {
      //showing failure snackbar
      CustomSnackBars.instance.showFailureSnackbar(
          title: 'Authentication Error', message: '${e.message}');

      return null;
    } catch (e) {
      log("This was the exception while signing up: $e");

      return null;
    }

    return null;
  }

  //method to check if the user's account already exists on firebase
  Future<bool> isAlreadyExist({required String uid}) async {
    DocumentSnapshot? userData = await FirebaseCRUDService.instance
        .readSingleDocument(collectionReference: userCollection, docId: uid);
    if (userData != null && userData.exists) {
      return true;
    } else {
      return false;
    }
    //if the user data is not null, it means the document already exists
  }

  //method to authenticate with google account
  Future<(User?, GoogleSignInAccount?, bool)> authWithGoogle() async {
    try {
      print('Starting Google Sign-In with 7.1.1 API...');

      // Use GoogleSignIn.instance for 7.1.1
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;

      // Initialize if needed
      await googleSignIn.initialize();

      print('Attempting Google authentication...');

      // Use authenticate method
      if (!googleSignIn.supportsAuthenticate()) {
        print('Google Sign-In authentication not supported on this platform');
        return (null, null, false);
      }

      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      print('Getting Firebase authentication data...');

      // Get authentication tokens (only idToken is available in 7.1.1)
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      if (googleAuth.idToken == null) {
        print('Failed to get ID token from Google authentication');
        return (null, null, false);
      }

      // For Firebase, we need both accessToken and idToken
      // In 7.1.1, we need to get accessToken via authorization
      print('Getting access token via authorization...');

      // Get authorization with basic scopes for Firebase
      const List<String> scopes = <String>[
        'email',
        'profile',
      ];

      final GoogleSignInClientAuthorization? authorization =
          await googleUser.authorizationClient.authorizationForScopes(scopes);

      if (authorization == null) {
        print('Failed to get authorization for Firebase');
        return (null, null, false);
      }

      print('Creating Firebase credential...');
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: authorization.accessToken,
        idToken: googleAuth.idToken,
      );

      print('Signing in with Firebase...');
      await FirebaseAuth.instance.signInWithCredential(credential);

      if (FirebaseAuth.instance.currentUser == null) {
        print('Firebase sign-in failed - no current user');
        return (null, null, false);
      }

      if (FirebaseAuth.instance.currentUser != null) {
        User user = FirebaseAuth.instance.currentUser!;
        print('Firebase sign-in successful for user: ${user.email}');

        //checking if the user's account already exists on firebase
        bool isExist = await isAlreadyExist(uid: user.uid);
        print('User exists in Firestore: $isExist');

        return (user, googleUser, isExist);
      }
    } on FirebaseAuthException catch (e) {
      print(
          'FirebaseAuthException during Google Sign-In: ${e.code} - ${e.message}');
      //showing failure snackbar
      CustomSnackBars.instance.showFailureSnackbar(
          title: 'Firebase Authentication Error', message: '${e.message}');

      return (null, null, false);
    } on FirebaseException catch (e) {
      print(
          'FirebaseException during Google Sign-In: ${e.code} - ${e.message}');
      //showing failure snackbar
      CustomSnackBars.instance.showFailureSnackbar(
          title: 'Firebase Error', message: '${e.message}');

      return (null, null, false);
    } catch (e) {
      print('General exception during Google Sign-In: $e');
      log("This was the exception while signing up: $e");

      return (null, null, false);
    }

    return (null, null, false);
  }

  //reAuthenticating user to confirm if the same user is requesting
  Future<void> changeFirebaseEmail(
      {required String email,
      required String password,
      required String newEmail}) async {
    try {
      final User user = FirebaseAuth.instance.currentUser!;

      final cred =
          EmailAuthProvider.credential(email: email, password: password);

      await user.reauthenticateWithCredential(cred).then((value) async {
        await user.verifyBeforeUpdateEmail(newEmail);

        CustomSnackBars.instance.showSuccessSnackbar(
          title: "Vefification Link Sent",
          message:
              "We have sent you a verification email, please update your email by verifying from the link",
          duration: 6,
        );

        //logging out user (so that we can update his email on the Firebase when he logs in again)
        await FirebaseAuth.instance.signOut();

        //navigating back to Login Screen
        // Get.offAll(() => const Login());
      }).onError((error, stackTrace) {
        CustomSnackBars.instance
            .showFailureSnackbar(title: 'Error', message: '$error');
      });
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          CustomSnackBars.instance
              .showFailureSnackbar(title: 'Error', message: 'User not found');
          break;
        case 'wrong-password':
          CustomSnackBars.instance
              .showFailureSnackbar(title: 'Error', message: 'Wrong password');
          break;
        case 'invalid-email':
          CustomSnackBars.instance
              .showFailureSnackbar(title: 'Error', message: 'Invalid email');
          break;
        case 'email-already-in-use':
          CustomSnackBars.instance.showFailureSnackbar(
              title: 'Error', message: 'Email already in use');
          break;
        default:
          CustomSnackBars.instance.showFailureSnackbar(
              title: 'Retry', message: 'Something went wrong');
          break;
      }
    }
  }

  //method to change Firebase password
  Future<void> changeFirebasePassword({
    required String email,
    required String oldPassword,
    required String newPassword,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    final cred =
        EmailAuthProvider.credential(email: email, password: oldPassword);

    try {
      user!.reauthenticateWithCredential(cred).then((value) {
        user.updatePassword(newPassword).then((_) {
          CustomSnackBars.instance.showSuccessSnackbar(
              title: "Success", message: "Password updated successfully");
        }).onError((error, stackTrace) {
          CustomSnackBars.instance
              .showFailureSnackbar(title: "Failure", message: "$error");
        });
      }).onError((error, stackTrace) {
        CustomSnackBars.instance
            .showFailureSnackbar(title: "Failure", message: "$error");
      });
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          CustomSnackBars.instance
              .showFailureSnackbar(title: 'Error', message: 'User not found');
          break;
        case 'wrong-password':
          CustomSnackBars.instance
              .showFailureSnackbar(title: 'Error', message: 'Wrong password');
          break;
        case 'invalid-email':
          CustomSnackBars.instance
              .showFailureSnackbar(title: 'Error', message: 'Invalid email');
          break;
        case 'email-already-in-use':
          CustomSnackBars.instance.showFailureSnackbar(
              title: 'Error', message: 'Email already in use');
          break;
        default:
          CustomSnackBars.instance.showFailureSnackbar(
              title: 'Retry', message: 'Something went wrong');
          break;
      }
    }
  }

// forgot password , send email link to email to reset password
  Future<void> resetPasswordUsingEmailSendLink({required String email}) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    if (email.isEmpty) {
      Get.snackbar("Error", "Please enter your email",
          snackPosition: SnackPosition.TOP);
      return;
    }

    try {
      await auth.sendPasswordResetEmail(email: email);
      Get.snackbar("Success", "Password reset email sent. Check your inbox.",
          snackPosition: SnackPosition.TOP);
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.TOP);
    }
  }

  // pick dob for user sign
  Future<String?> pickDOBForUserSign(context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      return formattedDate;
    } else {
      return null;
    }
  }

  /// Apple Sign-In authentication method
  // Future<(User?, AuthorizationCredentialAppleID?, bool)> authWithApple() async {
  //   try {
  //     print('Starting Apple Sign-In process...');

  //     // Check if Apple Sign-In is available on this device
  //     if (!await SignInWithApple.isAvailable()) {
  //       print('Apple Sign-In is not available on this device');
  //       return (null, null, false);
  //     }

  //     // Request Apple ID credential
  //     final appleCredential = await SignInWithApple.getAppleIDCredential(
  //       scopes: [
  //         AppleIDAuthorizationScopes.email,
  //         AppleIDAuthorizationScopes.fullName,
  //       ],
  //     );

  //     print('Apple ID credential received');

  //     // Create OAuth credential for Firebase
  //     final oauthCredential = OAuthProvider("apple.com").credential(
  //       idToken: appleCredential.identityToken,
  //       accessToken: appleCredential.authorizationCode,
  //     );

  //     // Sign in to Firebase with Apple credential
  //     final authResult =
  //         await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  //     final user = authResult.user;

  //     if (user == null) {
  //       print('Firebase sign-in failed - no current user');
  //       return (null, null, false);
  //     }

  //     print('Firebase sign-in successful for user: ${user.email}');

  //     // Check if the user's account already exists on Firestore
  //     bool isExist = await isAlreadyExist(uid: user.uid);
  //     print('User exists in Firestore: $isExist');

  //     return (user, appleCredential, isExist);
  //   } on SignInWithAppleAuthorizationException catch (e) {
  //     print('Apple Sign-In authorization error: ${e.code} - ${e.message}');

  //     String errorMessage;
  //     switch (e.code) {
  //       case AuthorizationErrorCode.canceled:
  //         errorMessage = 'Apple Sign-In was canceled';
  //         break;
  //       case AuthorizationErrorCode.failed:
  //         errorMessage = 'Apple Sign-In failed';
  //         break;
  //       case AuthorizationErrorCode.invalidResponse:
  //         errorMessage = 'Invalid response from Apple';
  //         break;
  //       case AuthorizationErrorCode.notHandled:
  //         errorMessage = 'Apple Sign-In not handled';
  //         break;
  //       case AuthorizationErrorCode.unknown:
  //         errorMessage = 'Unknown Apple Sign-In error';
  //         break;
  //       default:
  //         errorMessage = 'Apple Sign-In error: ${e.message}';
  //     }

  //     CustomSnackBars.instance.showFailureSnackbar(
  //         title: 'Apple Sign-In Error', message: errorMessage);

  //     return (null, null, false);
  //   } on FirebaseAuthException catch (e) {
  //     print(
  //         'FirebaseAuthException during Apple Sign-In: ${e.code} - ${e.message}');

  //     String errorMessage;
  //     switch (e.code) {
  //       case 'account-exists-with-different-credential':
  //         errorMessage =
  //             'An account already exists with a different sign-in method.';
  //         break;
  //       case 'invalid-credential':
  //         errorMessage = 'Invalid Apple credentials. Please try again.';
  //         break;
  //       case 'operation-not-allowed':
  //         errorMessage = 'Apple Sign-In is not enabled.';
  //         break;
  //       case 'user-disabled':
  //         errorMessage = 'This user account has been disabled.';
  //         break;
  //       default:
  //         errorMessage = 'Apple Sign-In failed: ${e.message}';
  //     }

  //     CustomSnackBars.instance.showFailureSnackbar(
  //         title: 'Firebase Authentication Error', message: errorMessage);

  //     return (null, null, false);
  //   } catch (e) {
  //     print('General exception during Apple Sign-In: $e');

  //     CustomSnackBars.instance.showFailureSnackbar(
  //         title: 'Apple Sign-In Error',
  //         message:
  //             'An unexpected error occurred during Apple Sign-In. Please try again.');

  //     return (null, null, false);
  //   }
  // }
}
