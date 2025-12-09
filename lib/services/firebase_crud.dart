import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contento/utils/snackbars.dart';

class FirebaseCRUDService {
  //private constructor
  FirebaseCRUDService._privateConstructor();

  //singleton instance variable
  static FirebaseCRUDService? _instance;

  //This code ensures that the singleton instance is created only when it's accessed for the first time.
  //Subsequent calls to FirebaseCRUDService.instance will return the same instance that was created before.

  //getter to access the singleton instance
  static FirebaseCRUDService get instance {
    _instance ??= FirebaseCRUDService._privateConstructor();
    return _instance!;
  }

  /// Create Document
  Future<bool> createDocument(
      {required CollectionReference collectionReference,
      required String docId,
      required Map<String, dynamic> data}) async {
    try {
      await collectionReference.doc(docId).set(data);
      //returning true to indicate that the document is created
      return true;
    } on FirebaseException catch (e) {
      //getting firebase error message
      final errorMessage = getFirestoreErrorMessage(e);

      //showing failure snackbar
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);

      //returning false to indicate that the document was not created
      return false;
    } catch (e) {
      print("This was the exception while creating document on Firestore: $e");

      //returning false to indicate that the document was not created
      return false;
    }
  }

  /// Read Single Document
  Future<DocumentSnapshot?> readSingleDocument(
      {required var collectionReference, required String docId}) async {
    try {
      DocumentSnapshot documentSnapshot =
          await collectionReference.doc(docId).get();

      if (documentSnapshot.exists) {
        return documentSnapshot;
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      //getting firebase error message
      final errorMessage = getFirestoreErrorMessage(e);

      //showing failure snackbar
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);
      return null;
    } catch (e) {
      print("This was the exception while reading document from Firestore: $e");
      return null;
    }
  }

  /// Read Single Document with where query
  Future<QueryDocumentSnapshot?> readSingleDocByFieldName({
    required CollectionReference collectionReference,
    required String fieldName,
    required String fieldValue,
  }) async {
    try {
      QuerySnapshot documentSnapshot = await collectionReference
          .where(fieldName, isEqualTo: fieldValue)
          .get();

      if (documentSnapshot.docs.isNotEmpty) {
        return documentSnapshot.docs[0];
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      //getting firebase error message
      final errorMessage = getFirestoreErrorMessage(e);

      //showing failure snackbar
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);
      return null;
    } catch (e) {
      print("This was the exception while reading document from Firestore: $e");
      return null;
    }
  }

  Future<List<QueryDocumentSnapshot>?> readAllDocByFieldName({
    required CollectionReference collectionReference,
    required String fieldName,
    required String fieldValue,
  }) async {
    try {
      QuerySnapshot documentSnapshot = await collectionReference
          .where(fieldName, isEqualTo: fieldValue)
          .get();

      if (documentSnapshot.docs.isNotEmpty) {
        return documentSnapshot.docs;
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      //getting firebase error message
      final errorMessage = getFirestoreErrorMessage(e);
      //showing failure snackbar
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);
      return null;
    } catch (e) {
      print("This was the exception while reading document from Firestore: $e");
      return null;
    }
  }

  Future<List<QueryDocumentSnapshot>?> readAllDoc({
    required var collectionReference,
  }) async {
    try {
      QuerySnapshot documentSnapshot = await collectionReference.get();

      if (documentSnapshot.docs.isNotEmpty) {
        return documentSnapshot.docs;
      } else {
        return null;
      }
    } on FirebaseException catch (e) {
      //getting firebase error message
      final errorMessage = getFirestoreErrorMessage(e);
      //showing failure snackbar
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);
      return null;
    } catch (e) {
      print("This was the exception while reading document from Firestore: $e");
      return null;
    }
  }

  //method to get single document stream
  Stream<DocumentSnapshot<Object?>> getSingleDocStream(
      {required CollectionReference collectionReference,
      required String docId}) {
    return collectionReference.doc(docId).snapshots();
  }

  Stream<DocumentSnapshot<Object?>> getSingleDocStreamListen({
    required CollectionReference collectionReference,
    required String docId,
  }) {
    StreamController<DocumentSnapshot<Object?>> streamController =
        StreamController();
    collectionReference.doc(docId).snapshots().listen((snapshot) {
      streamController.add(snapshot);
    });

    return streamController.stream;
  }

  //method to get stream of snapshots
  StreamSubscription<QuerySnapshot>? getStream(
      {required CollectionReference collectionReference}) {
    try {
      //getting document snapshots stream
      StreamSubscription<QuerySnapshot> stream =
          collectionReference.snapshots().listen((event) {});

      return stream;
    } on FirebaseException catch (e) {
      //getting firebase error message
      final errorMessage = getFirestoreErrorMessage(e);

      //showing failure snackbar
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);

      return null;
    } catch (e) {
      print("This was the exception while getting stream from Firestore: $e");

      return null;
    }
  }

  /// check if the document exists in Firestore
  Future<bool> isDocExist(
      {required CollectionReference collectionReference,
      required String docId}) async {
    try {
      DocumentSnapshot documentSnapshot =
          await collectionReference.doc(docId).get();

      if (documentSnapshot.exists) {
        return true;
      } else {
        return false;
      }
    } on FirebaseException catch (e) {
      print("This was the exception while reading document from Firestore: $e");

      return false;
    } catch (e) {
      print("This was the exception while reading document from Firestore: $e");

      return false;
    }
  }

  Future<(bool, QuerySnapshot?)> isDocExistByFieldName(
      {required CollectionReference collectionReference,
      required String fieldName,
      required String isEqualTo}) async {
    try {
      QuerySnapshot documentSnapshot = await collectionReference
          .where(fieldName, isEqualTo: isEqualTo)
          .get();

      if (documentSnapshot.docs.isNotEmpty) {
        return (true, documentSnapshot);
      } else {
        return (false, null);
      }
    } on FirebaseException catch (e) {
      print("This was the exception while reading document from Firestore: $e");

      return (false, null);
    } catch (e) {
      print("This was the exception while reading document from Firestore: $e");

      return (false, null);
    }
  }

  /// Read all documents
  Future<QuerySnapshot<Map<String, dynamic>>?> readAllDocument(
      {required CollectionReference<Map<String, dynamic>> collection}) async {
    await processFirebaseRequest(() async => await collection.get());
    return null;
  }

  /// Update Document
  Future<bool> updateDocument(
      {required CollectionReference collection,
      required String docId,
      required Map<String, dynamic> data}) async {
    try {
      await collection.doc(docId).update(data);
      return true;
    } on FirebaseException catch (e) {
      //getting firebase error message
      final errorMessage = getFirestoreErrorMessage(e);
      print("This was the exception while updating document on Firestore: $e");

      //showing failure snackbar
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);

      //returning false to indicate that the document was not created
      return false;
    } catch (e) {
      print("This was the exception while updating document on Firestore: $e");

      //returning false to indicate that the document was not created
      return false;
    }
  }

  //update single key of a document
  Future<bool> updateDocumentSingleKey({
    required CollectionReference collection,
    required String docId,
    required String key,
    required var value,
  }) async {
    try {
      await collection.doc(docId).update({
        key: value,
      });

      return true;
    } on FirebaseException catch (e) {
      //getting firebase error message
      final errorMessage = getFirestoreErrorMessage(e);

      //showing failure snackbar
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);

      //returning false to indicate that the document was not created
      return false;
    } catch (e) {
      print(
          "This was the exception while updating document single key on Firestore: $e");

      //returning false to indicate that the document was not created
      return false;
    }
  }

  /// Delete Document

  Future deleteDocument(
      {required CollectionReference collection, required String docId}) async {
    try {
      await collection.doc(docId).delete();
      return true;
    } on FirebaseException catch (e) {
      //getting firebase error message
      final errorMessage = getFirestoreErrorMessage(e);

      //showing failure snackbar
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);

      //returning false to indicate that the document was not created
      return false;
    } catch (e) {
      print(
          "This was the exception while updating document single key on Firestore: $e");

      //returning false to indicate that the document was not created
      return false;
    }
  }

  /// Read All Documents (Snapshot)
  Stream<QuerySnapshot> readAllDocuments(
      {required CollectionReference<Map<String, dynamic>> collection}) {
    return collection.snapshots();
  }

  /// This method is responsible for executing and handling Firebase operations
  Future<T?> processFirebaseRequest<T>(Future<T> Function() call) async {
    try {
      return await call();
    } on FirebaseException catch (e) {
      final errorMessage = getFirestoreErrorMessage(e);
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);
      return null; // or handle as needed
    } catch (e) {
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: e.toString());
      return null; // or handle as needed
    }
  }

  /// Method to get a user-friendly message from FirebaseException
  String getFirestoreErrorMessage(FirebaseException e) {
    switch (e.code) {
      case 'cancelled':
        return 'The operation was cancelled.';
      case 'unknown':
        return 'An unknown error occurred.';
      case 'invalid-argument':
        return 'Invalid argument provided.';
      case 'deadline-exceeded':
        return 'The deadline was exceeded, please try again.';
      case 'not-found':
        return 'Requested document was not found.';
      case 'already-exists':
        return 'The document already exists.';
      case 'permission-denied':
        return 'You do not have permission to execute this operation.';
      case 'resource-exhausted':
        return 'Resource limit has been exceeded.';
      case 'failed-precondition':
        return 'The operation failed due to a precondition.';
      case 'aborted':
        return 'The operation was aborted, please try again.';
      case 'out-of-range':
        return 'The operation was out of range.';
      case 'unimplemented':
        return 'This operation is not implemented or supported yet.';
      case 'internal':
        return 'Internal error occurred.';
      case 'unavailable':
        return 'The service is currently unavailable, please try again later.';
      case 'data-loss':
        return 'Data loss occurred, please try again.';
      case 'unauthenticated':
        return 'You are not authenticated, please printin and try again.';
      default:
        return 'An unexpected error occurred, please try again.';
    }
  }

  //batch write (the list of documents and collection paths should be of same lengths)
  Future<bool> batchWriteMultipleDocuments({
    required List<Map<String, dynamic>> documents,
    required List<String> respectiveDocIds,
    required List<CollectionReference> collectionPaths,
  }) async {
    if (documents.length != collectionPaths.length) {
      print(
          "The lengths of documents and collectionPaths lists should be the same!");
      return false;
    }

    try {
      // Get a Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Create a new batch
      WriteBatch batch = firestore.batch();

      // Iterate through the list of documents and add set operations to the batch
      for (int i = 0; i < documents.length; i++) {
        //getting reference
        DocumentReference docRef = collectionPaths[i].doc(respectiveDocIds[i]);

        batch.set(docRef, documents[i]);
      }

      // Commit the batch
      await batch.commit();
      return true;
    } on FirebaseException catch (e) {
      //getting firebase error message
      final errorMessage = getFirestoreErrorMessage(e);

      //showing failure snackbar
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);

      //returning false to indicate that the batch write was not successful
      return false;
    } catch (e) {
      print("This was the exception while creating document on Firestore: $e");

      //returning false to indicate that the batch write was not successful
      return false;
    }
  }

  /* --------- Notifications -------------------*/

  // Future saveNotificationToFirestore({
  //   required String title,
  //   required String body,
  //   required String sentBy,
  //   required String sentTo,
  //   required String type,
  //   DateTime? time,
  //   DateTime? date,
  // }) async {
  //   try {
  //     DocumentReference reference =
  //         FirebaseFirestore.instance.collection('notifications').doc(sentTo);

  //     await reference.set({
  //       'docId': sentTo,
  //     });

  //     print("********reference $reference");
  //     var subCollectionDocId = DateTime.now().millisecondsSinceEpoch.toString();
  //     var data = NotificationModel(
  //       title: title,
  //       body: body,
  //       sentBy: sentBy,
  //       sentTo: sentTo,
  //       type: type,
  //       time: time,
  //       date: date,
  //       notId: subCollectionDocId,
  //     ).toJson();
  //     await reference
  //         .collection('userNotification')
  //         .doc(subCollectionDocId)
  //         .set(data);
  //   } catch (e) {
  //     throw Exception(e);
  //   }
}

// Stream<QuerySnapshot<Map<String, dynamic>>> streamNotifications(userId) {
//   return FirebaseFirestore.instance
//       .collection('notificationCollection')
//       .where(Filter.and(Filter('sentTo', isEqualTo: userId),
//           Filter('type', isNotEqualTo: AppStrings.notificationMessage)))
//       // .where('sentTo', isEqualTo: userId).where('type',isNotEqualTo: AppStrings.notificationMessage)
//       .orderBy('time', descending: true)
//       .snapshots();
// }
