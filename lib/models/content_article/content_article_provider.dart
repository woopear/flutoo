import 'package:flutoo/utils/services/firestore/firestore_service.dart';
import 'package:flutter/widgets.dart';

class ContentArticleProvider extends ChangeNotifier {
  final _firestoreService = FirestoreService.instance;
}
