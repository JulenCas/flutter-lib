// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_post_request_dto.dart';

mixin _$CreatePostRequestDto {
  int get userId;
  String get title;
  String get body;
  Map<String, dynamic> toJson();
}

class _CreatePostRequestDto implements CreatePostRequestDto {
  const _CreatePostRequestDto({required this.userId, required this.title, required this.body});

  @override
  final int userId;

  @override
  final String title;

  @override
  final String body;

  @override
  Map<String, dynamic> toJson() => _$CreatePostRequestDtoToJson(this);

  @override
  String toString() => 'CreatePostRequestDto(userId, title, body)';

  @override
  bool operator ==(Object other) => identical(this, other) ||
      other is _CreatePostRequestDto && other.userId == userId && other.title == title && other.body == body;

  @override
  int get hashCode => Object.hash(userId, title, body);
}
