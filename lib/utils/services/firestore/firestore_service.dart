import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  final _firestore = FirebaseFirestore.instance;

  /// set un document deja existant
  /// * modifie pas le document ecrase tous et le remplace
  /// ou creer un nouveau document mais il faudra
  /// init l'id vous meme
  Future<void> set({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = _firestore.doc(path);
    print('$path: $data => SET SUCCES');
    await reference.set(data);
  }

  /// ajouter un document à une collection
  /// avec génération automatique de l'id
  Future<DocumentReference<Map<String, dynamic>?>?>? add({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    final reference = _firestore.collection(path);
    print('$path: $data => ADD SUCCES');
    if (merge != true) {
      await reference.add(data);
    } else {
      return await reference.add(data);
    }
    return null;
  }

  /// modifie un document
  Future<void> update({
    required String path,
    required Map<String, dynamic> data,
    bool merge = false,
  }) async {
    final reference = _firestore.doc(path);
    print('$path: $data => UPDATE SUCCES');
    await reference.update(data);
  }

  /// supprime un document
  Future<void> delete({required String path}) async {
    final reference = _firestore.doc(path);
    print('delete: $path => SUCCES');
    await reference.delete();
  }

  /// recupere des documents d'une collection
  Future<List<T>> getCol<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentID) builder,
    Query Function(Query query)? queryBuilder,
  }) async {
    /// query par le path,
    /// ou creation d'une query via la fonction
    /// en parametre
    Query query = _firestore.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }

    ///retourne une List du model
    /// passé en parametre à la fonction builder
    final collection = await query.get();
    final result = collection.docs
        .map((e) => builder(e.data() as Map<String, dynamic>, e.id))
        .where((value) => value != null)
        .toList();

    print('getDoc: $path => SUCCES');

    return result;
  }

  /// recupere un document
  Future<DocumentSnapshot<Map<String, dynamic>>> getDoc({
    required String path,
    bool merge = false,
  }) async {
    final reference = _firestore.doc(path);
    print('getDoc: $path => SUCCES');
    return await reference.get();
  }

  /// ecouteur sur une collection
  Stream<List<T>> streamCol<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentID) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    /// query par le path,
    /// ou creation d'une query via la fonction
    /// en parametre
    Query query = _firestore.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }

    /// request ecouteur et retourne une List du model
    /// passé en parametre à la fonction builder
    final Stream<QuerySnapshot> snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map((snapshot) =>
              builder(snapshot.data() as Map<String, dynamic>, snapshot.id))
          .where((value) => value != null)
          .toList();

      print('result : $result => streamCol SUCCES');

      /// si besoin d'un sort
      /// la fonction en parametre
      /// permet d'en mettre un en fonction
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  /// ecouteur sur un docmuent
  Stream<T> streamDoc<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentID) builder,
  }) {
    final DocumentReference reference = _firestore.doc(path);
    final Stream<DocumentSnapshot> snapshots = reference.snapshots();

    return snapshots.map((snapshot) =>
        builder(snapshot.data() as Map<String, dynamic>, snapshot.id));
  }
}
