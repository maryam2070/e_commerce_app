
abstract class Failure{
  String message;
  Failure({required this.message});
}

class FirebaseAuthFailure extends Failure{
  @override
  String message;

  FirebaseAuthFailure({required this.message}) : super(message: '');
}
