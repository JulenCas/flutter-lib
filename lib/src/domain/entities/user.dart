import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

/// Entidad de dominio que representa a un usuario del negocio.
///
/// Las entidades viven en la capa de dominio y no conocen APIs, JSON ni bases de
/// datos. Freezed proporciona inmutabilidad, igualdad por valor y `copyWith` para
/// que los casos de uso trabajen con objetos seguros y expresivos.
@freezed
class User with _$User {
  /// Crea una entidad [User].
  ///
  /// [id] identifica de forma única al usuario en el dominio. [name] es el nombre
  /// visible. [email] se mantiene como dato de contacto y validación funcional.
  const factory User({
    required int id,
    required String name,
    required String email,
  }) = _User;
}
