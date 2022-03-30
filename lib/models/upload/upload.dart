import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class UploadFile extends ChangeNotifier {
  final _firebaseStorage = FirebaseStorage.instance;

  Future<String> upload(File data, String uid) async {
    /// on creer la reference de l'image (nom)
    final ref = _firebaseStorage.ref().child('avatars/user-$uid');
    /// on enregistre sur firebase
    UploadTask? file = ref.putFile(data);

    /// on recupere le fichier
    final snapshot = await file.whenComplete(() {});
    /// on recupere l'url pour enregistrer dans le user
    final url = await snapshot.ref.getDownloadURL();

    return url;
  }
}
