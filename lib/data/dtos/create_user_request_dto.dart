import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_user_request_dto.freezed.dart';
part 'create_user_request_dto.g.dart';

/// DTO usado exclusivamente para `POST /users`.
///
/// Los DTOs viven en `data` porque describen payloads técnicos. Mantenerlos
/// separados de las entidades evita que reglas de negocio dependan de campos o
/// formatos requeridos por un proveedor externo.
@freezed
class CreateUserRequestDto with _$CreateUserRequestDto {
  /// Crea el cuerpo serializable para registrar usuarios.
  const factory CreateUserRequestDto({
    required String name,
    required String email,
  }) = _CreateUserRequestDto;

  /// Reconstruye el DTO desde JSON para pruebas o reintentos cacheados.
  factory CreateUserRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreateUserRequestDtoFromJson(json);
}
