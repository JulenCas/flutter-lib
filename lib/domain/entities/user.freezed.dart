// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

mixin _$User {
  int get id;
  String get name;
  String get email;
}

class _User implements User {
  const _User({required this.id, required this.name, required this.email});

  @override
  final int id;

  @override
  final String name;

  @override
  final String email;

  @override
  String toString() => 'User(id, name, email)';

  @override
  bool operator ==(Object other) => identical(this, other) ||
      other is _User && other.id == id && other.name == name && other.email == email;

  @override
  int get hashCode => Object.hash(id, name, email);
}
