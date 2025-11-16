import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  //private constructor
  FirebaseStorageService._privateConstructor();

  //singleton instance variable
  static FirebaseStorageService? _instance;

  //This code ensures that the singleton instance is created only when it's accessed for the first time.
  //Subsequent calls to FirebaseCRUDService.instance will return the same instance that was created before.

  //getter to access the singleton instance
  static FirebaseStorageService get instance {
    _instance ??= FirebaseStorageService._privateConstructor();
    return _instance!;
  }

  // Upload profile image to Firebase Storage
  Future<String> uploadImageToStorageGetsUrl(File image) async {
    // String userId = profileController.userModel.value.userId;
    Reference storageRef = FirebaseStorage.instance
        .ref()
        .child('image')
        .child('${DateTime.now().millisecondsSinceEpoch.toString()}.jpg');

    var uploadTask = storageRef.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }
}
