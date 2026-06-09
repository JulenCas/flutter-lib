// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

mixin _$UserModel {
  int get id;
  String get name;
  String get email;
  Map<String, dynamic> toJson();
}

class _UserModel implements UserModel {
  const _UserModel({required this.id, required this.name, required this.email});

  @override
  final int id;

  @override
  final String name;

  @override
  final String email;

  @override
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  @override
  String toString() => 'UserModel(id, name, email)';

  @override
  bool operator ==(Object other) => identical(this, other) ||
      other is _UserModel && other.id == id && other.name == name && other.email == email;

  @override
  int get hashCode => Object.hash(id, name, email);
}
