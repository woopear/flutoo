import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UploadFile extends ChangeNotifier {
  final _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadAvatar(data, String uid, String extension) async {
    UploadTask? file;

    /// on creer la reference de l'image (nom)
    final ref = _firebaseStorage.ref().child('avatars/user-$uid');
    
    if (kIsWeb) {
      /// on enregistre sur firebase mode web
      file = ref.putData(data, SettableMetadata(contentType: 'image/$extension'));
    } else {
      /// on enregistre sur firebase mode mobile
      file = ref.putFile(data);
    }

    /// on recupere le fichier
    final snapshot = await file.whenComplete(() {});

    /// on recupere l'url et on la retourne pour enregistrer dans le user
    final url = await snapshot.ref.getDownloadURL();
    return url;
  }
}

/// state de la class uploadFile
final uploadFileChange = ChangeNotifierProvider((ref) => UploadFile());
