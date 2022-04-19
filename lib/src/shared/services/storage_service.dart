import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  static final _storageRef = FirebaseStorage.instance.ref();

  static Future<String?> uploadImage(File imageFile, String folderPath) async {
    final uploadTask = _storageRef.child(folderPath).putFile(imageFile);
    return await (await uploadTask).ref.getDownloadURL();
  }

  static Future<void> delete(String fileUrl) {
    final ref = FirebaseStorage.instance.refFromURL(fileUrl);
    return ref.delete();
  }
}
