
class User{

  String uid;
  String name;
  String email;

  User({required this.uid,required this.name,required this.email});

  Map<String, dynamic> toJson() {
    return {
      "uid": this.uid,
      "name": this.name,
      "email": this.email,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json["uid"],
      name: json["name"],
      email: json["email"],
    );
  }

}