// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

mixin _$Post {
  int get id;
  int get userId;
  String get title;
  String get body;
}

class _Post implements Post {
  const _Post({required this.id, required this.userId, required this.title, required this.body});

  @override
  final int id;

  @override
  final int userId;

  @override
  final String title;

  @override
  final String body;

  @override
  String toString() => 'Post(id, userId, title, body)';

  @override
  bool operator ==(Object other) => identical(this, other) ||
      other is _Post && other.id == id && other.userId == userId && other.title == title && other.body == body;

  @override
  int get hashCode => Object.hash(id, userId, title, body);
}
