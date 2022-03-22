class User {
  int? id;
  String? name;
  String? email;
  String? token;
  int? root;

  User({this.id, this.name, this.email, this.token, this.root});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['user']['id'],
        name: json['user']['name'],
        email: json['user']['email'],
        token: json['token'],
        root: json['root']);
  }
}
