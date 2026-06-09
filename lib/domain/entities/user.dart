import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';

/// Entidad de dominio que representa a un usuario del negocio.
///
/// Vive en `domain`, por lo que no conoce JSON, Dio, Hive ni Flutter. Los casos
/// de uso y gestores de estado la consumen como contrato estable de la regla de
/// negocio, mientras la capa `data` se encarga de mapear desde modelos externos.
@freezed
class User with _$User {
  /// Crea una entidad inmutable con igualdad por valor gracias a Freezed.
  const factory User({
    required int id,
    required String name,
    required String email,
  }) = _User;
}
