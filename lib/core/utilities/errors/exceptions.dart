class AuthException implements Exception {
  String message;

  AuthException({required this.message});
}

class FirestoreException implements Exception {
  String message;

  FirestoreException({required this.message});
}