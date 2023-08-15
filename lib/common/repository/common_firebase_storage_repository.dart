import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final commonFireBaseStorageRepoProvider = Provider((ref) =>
    CommonFireBaseStorageRepo(firebaseStorage: FirebaseStorage.instance));

class CommonFireBaseStorageRepo {
  final FirebaseStorage firebaseStorage;
  CommonFireBaseStorageRepo({required this.firebaseStorage});

  Future<String> storeFiletoFirebse(String ref, File file) async {
    UploadTask uploadTask = firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
