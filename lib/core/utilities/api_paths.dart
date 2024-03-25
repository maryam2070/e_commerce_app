class ApiPaths {
  static const String products = 'products';
  static String cartProducts(String uid) => 'users/$uid/cart';
  static String userPath(String uid) => 'users/$uid/';
}
