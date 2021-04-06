class Auth {
  User? user;
  Auth({this.user});
  bool get isAuth => user != null;
}

String getId() => "fergef";

class User {
  final String sId;
  String? userName;
  String userEmail;
  User({this.userName, required this.userEmail, userId})
      : sId = userId ?? getId();

  User._({this.userName, required this.userEmail, required userId})
      : sId = userId;

  factory User.fromJson(Map<String, dynamic> json) {
    return new User._(
        userEmail: json["user_email"],
        userName: json["user_name"],
        userId: json['user_id']!);
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["user_email"] = this.userEmail;
    data["user_name"] = this.userName;
    data["user_id"] = this.sId;
    return data;
  }
}
