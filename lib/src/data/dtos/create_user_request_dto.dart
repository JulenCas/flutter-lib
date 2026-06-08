import 'package:freezed_annotation/freezed_annotation.dart';

part 'create_user_request_dto.freezed.dart';
part 'create_user_request_dto.g.dart';

/// DTO de entrada para crear un usuario mediante la API.
///
/// Los DTOs describen payloads específicos de infraestructura. Separarlos de las
/// entidades evita que el dominio dependa de campos temporales, nombres JSON o
/// requisitos particulares del backend.
@freezed
class CreateUserRequestDto with _$CreateUserRequestDto {
  /// Crea el cuerpo de una solicitud `POST /users`.
  ///
  /// [name] y [email] son los valores mínimos requeridos por el ejemplo de API.
  const factory CreateUserRequestDto({
    required String name,
    required String email,
  }) = _CreateUserRequestDto;

  /// Deserializa el DTO cuando se necesita reconstruirlo desde cache o pruebas.
  factory CreateUserRequestDto.fromJson(Map<String, dynamic> json) =>
      _$CreateUserRequestDtoFromJson(json);
}
