// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

List<Category> categoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
    required this.id,
    required this.title,
    required this.categoryImage,
    required this.publishedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.ads,
  });

  int? id;
  String? title;
  String? categoryImage;
  DateTime? publishedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<dynamic> ads;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        title: json["title"],
        categoryImage: json["CategoryImage"],
        publishedAt: DateTime.parse(json["published_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        ads: List<dynamic>.from(json["adsInCats"].map((x) => x)).toList(),
        // ads: toList(json["ads"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "CategoryImage": categoryImage!,
        "published_at": publishedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "adsInCats": List<dynamic>.from(ads.map((x) => x)),
      };

// static List<Ad> toList(List<dynamic> list) {
//   return List<Ad>.from(list);
// }
}
