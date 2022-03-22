import 'package:http/http.dart';

class Post {
  int? id;
  int? admin_id;
  String? name;
  int? category;
  String? description;
  String? delivery_time;
  int? price;
  String? image;

  Post(
      {this.id,
      this.admin_id,
      this.name,
      this.category,
      this.description,
      this.delivery_time,
      this.price,
      this.image});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        admin_id: json['admin_id'],
        name: json['name'],
        category: json['category'],
        description: json['description'],
        delivery_time: json['delivery_time'],
        price: json['price'],
        image: json['image']);
  }
}
