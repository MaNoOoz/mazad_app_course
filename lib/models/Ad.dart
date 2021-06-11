// To parse this JSON data, do
//
//     final ad = adFromJson(jsonString);

import 'dart:convert';

Ad adFromJson(String str) => Ad.fromJson(json.decode(str));

String adToJson(Ad data) => json.encode(data.toJson());

class Ad {
  Ad({
    required this.id,
    required this.title,
    required this.content,
    required this.user,
    required this.category,
    required this.publishedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.adImages,
    required this.tags,
    required this.comments,
    required this.likes,
  });

  int? id;
  String? title;
  String? content;
  String? likes;
  User? user;
  Category? category;
  DateTime? publishedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<AdImage>? adImages;
  List<Tag>? tags;
  List<Comment>? comments;

  factory Ad.fromJson(Map<String, dynamic> json) => Ad(
        id: json["id"]== null ? null :json["id"],
        title: json["title"]== null ? null :json["title"],
        content: json["content"]== null ? null :json["content"],
        likes: json["likes"]== null ? null :json["likes"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
        publishedAt: DateTime.parse(json["published_at"]== null ? null :json["published_at"],),
        createdAt: DateTime.parse(json["created_at"]== null ? null :json["created_at"],),
        updatedAt: DateTime.parse(json["updated_at"]== null ? null :json["updated_at"],),
        adImages: List<AdImage>.from(json["ad_images"].map((x) => AdImage.fromJson(x))),
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        comments: List<Comment>.from(json["comments"].map((x) => Comment.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "likes": likes,
        "user": user!.toJson(),
        "category": category!.toJson(),
        "published_at": publishedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
        "ad_images": List<dynamic>.from(adImages!.map((x) => x.toJson())),
        "tags": List<dynamic>.from(tags!.map((x) => x.toJson())),
        "comments": List<dynamic>.from(comments!.map((x) => x.toJson())),
      };
}

class Tag {
  Tag({
    this.id,
    this.tagName,
    this.publishedAt,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? tagName;
  DateTime? publishedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["id"],
        tagName: json["tagName"],
        publishedAt: DateTime.parse(json["published_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tagName": tagName,
        "published_at": publishedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class AdImage {
  AdImage({
    required this.id,
    required this.name,
    required this.alternativeText,
    required this.caption,
    required this.width,
    required this.height,
    required this.formats,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.size,
    required this.url,
    required this.previewUrl,
    required this.provider,
    required this.providerMetadata,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String name;
  String alternativeText;
  String caption;
  int width;
  int height;
  Formats formats;
  String hash;
  String ext;
  String mime;
  double size;
  String url;
  dynamic previewUrl;
  String provider;
  dynamic providerMetadata;
  DateTime createdAt;
  DateTime updatedAt;

  factory AdImage.fromJson(Map<String, dynamic> json) => AdImage(
        id: json["id"],
        name: json["name"],
        alternativeText: json["alternativeText"],
        caption: json["caption"],
        width: json["width"],
        height: json["height"],
        formats: Formats.fromJson(json["formats"]),
        hash: json["hash"],
        ext: json["ext"],
        mime: json["mime"],
        size: json["size"].toDouble(),
        url: json["url"],
        previewUrl: json["previewUrl"],
        provider: json["provider"],
        providerMetadata: json["provider_metadata"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "alternativeText": alternativeText,
        "caption": caption,
        "width": width,
        "height": height,
        "formats": formats.toJson(),
        "hash": hash,
        "ext": ext,
        "mime": mime,
        "size": size,
        "url": url,
        "previewUrl": previewUrl,
        "provider": provider,
        "provider_metadata": providerMetadata,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class Formats {
  Formats({
    required this.thumbnail,
  });

  Thumbnail thumbnail;

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        thumbnail: Thumbnail.fromJson(json["thumbnail"]),
      );

  Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail.toJson(),
      };
}

class Thumbnail {
  Thumbnail({
    required this.name,
    required this.hash,
    required this.ext,
    required this.mime,
    required this.width,
    required this.height,
    required this.size,
    required this.path,
    required this.url,
  });

  String? name;
  String? hash;
  String? ext;
  String? mime;
  int? width;
  int? height;
  double? size;
  dynamic path;
  String? url;

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
        name: json["name"],
        hash: json["hash"],
        ext: json["ext"],
        mime: json["mime"],
        width: json["width"],
        height: json["height"],
        size: json["size"].toDouble(),
        path: json["path"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "hash": hash,
        "ext": ext,
        "mime": mime,
        "width": width,
        "height": height,
        "size": size,
        "path": path,
        "url": url,
      };
}

class Category {
  Category({
    required this.id,
    required this.title,
    required this.categoryImage,
    required this.publishedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  int? id;
  String? title;
  String? categoryImage;
  DateTime? publishedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        title: json["title"],
        categoryImage: json["CategoryImage"],
        publishedAt: DateTime.parse(json["published_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "CategoryImage": categoryImage,
        "published_at": publishedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class Comment {
  Comment({
    required this.id,
    required this.commentText,
    required this.publishedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  int? id;
  String? commentText;
  DateTime? publishedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        commentText: json["CommentText"] == null ? null : json["CommentText"],
        publishedAt: DateTime.parse(json["published_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "CommentText": commentText == null ? null : commentText,
        "published_at": publishedAt!.toIso8601String(),
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class User {
  User({
    required this.id,
    required this.username,
    required this.email,
    required this.provider,
    required this.confirmed,
    required this.blocked,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String? username;
  String? email;
  String? provider;
  bool? confirmed;
  dynamic blocked;
  int? role;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] == null ? null : json["id"],
        username: json["username"] == null ? null : json["username"],
        email: json["email"] == null ? null : json["email"],
        provider: json["provider"] == null ? null : json["provider"],
        confirmed: json["confirmed"] == null ? null : json["confirmed"],
        blocked: json["blocked"],
        role: json["role"] == null ? null : json["role"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "username": username == null ? null : username,
        "email": email == null ? null : email,
        "provider": provider == null ? null : provider,
        "confirmed": confirmed == null ? null : confirmed,
        "blocked": blocked,
        "role": role == null ? null : role,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
      };
}
