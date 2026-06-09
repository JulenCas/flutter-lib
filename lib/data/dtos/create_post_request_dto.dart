import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_post_request_dto.freezed.dart';
part 'create_post_request_dto.g.dart';

/// DTO usado para crear publicaciones en el backend.
///
/// Encapsula el payload técnico de infraestructura y evita filtrar requisitos de
/// la API hacia casos de uso o widgets.
@freezed
class CreatePostRequestDto with _$CreatePostRequestDto {
  /// Crea el cuerpo de `POST /posts`.
  const factory CreatePostRequestDto({
    required int userId,
    required String title,
    required String body,
  }) = _CreatePostRequestDto;

  /// Deserializa JSON para pruebas, reintentos o persistencia temporal.
  factory CreatePostRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreatePostRequestDtoFromJson(json);
}
