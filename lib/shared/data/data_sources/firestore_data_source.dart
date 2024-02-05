import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirestoreDataSource {
  Future<bool> deleteData(String path);

  Future<bool> setData(
      {required String path, required Map<String, dynamic> data});

  Future<Stream<T>> documentsStream<T>(
      {required String path,
        required T Function(Map<String, dynamic>? data, String docId) builder});

  Stream<List<T>> collectionsStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  });
}

class FirestoreDataSourceImpl implements FirestoreDataSource {
  FirebaseFirestore firestore;

  FirestoreDataSourceImpl({required this.firestore});

  @override
  Future<bool> deleteData(String path) async {
    bool deleted = false;
    try {
      await firestore.doc(path).delete().whenComplete(() => deleted = true);

      return deleted;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<bool> setData(
      {required String path, required Map<String, dynamic> data}) async {
    bool uploaded = false;
    try {
      await firestore.doc(path).set(data).whenComplete(() => uploaded = true);
      return uploaded;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Stream<T>> documentsStream<T>(
      {required String path,
        required T Function(Map<String, dynamic>? data, String docId)
        builder}) async {
    final snapshot = firestore.doc(path).snapshots();
    return snapshot.map((snapshot) => builder(snapshot.data(), snapshot.id));
  }

  @override
  Stream<List<T>> collectionsStream<T>({
    required String path,
    required T Function(Map<String, dynamic>? data, String documentId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query query = firestore.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map(
            (snapshot) => builder(
          snapshot.data() as Map<String, dynamic>,
          snapshot.id,
        ),
      )
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }
}
