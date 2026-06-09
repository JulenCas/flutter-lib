// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

mixin _$PostModel {
  int get id;
  int get userId;
  String get title;
  String get body;
  Map<String, dynamic> toJson();
}

class _PostModel implements PostModel {
  const _PostModel({required this.id, required this.userId, required this.title, required this.body});

  @override
  final int id;

  @override
  final int userId;

  @override
  final String title;

  @override
  final String body;

  @override
  Map<String, dynamic> toJson() => _$PostModelToJson(this);

  @override
  String toString() => 'PostModel(id, userId, title, body)';

  @override
  bool operator ==(Object other) => identical(this, other) ||
      other is _PostModel && other.id == id && other.userId == userId && other.title == title && other.body == body;

  @override
  int get hashCode => Object.hash(id, userId, title, body);
}
