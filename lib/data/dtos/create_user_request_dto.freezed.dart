// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_user_request_dto.dart';

mixin _$CreateUserRequestDto {
  String get name;
  String get email;
  Map<String, dynamic> toJson();
}

class _CreateUserRequestDto implements CreateUserRequestDto {
  const _CreateUserRequestDto({required this.name, required this.email});

  @override
  final String name;

  @override
  final String email;

  @override
  Map<String, dynamic> toJson() => _$CreateUserRequestDtoToJson(this);

  @override
  String toString() => 'CreateUserRequestDto(name, email)';

  @override
  bool operator ==(Object other) => identical(this, other) ||
      other is _CreateUserRequestDto && other.name == name && other.email == email;

  @override
  int get hashCode => Object.hash(name, email);
}
