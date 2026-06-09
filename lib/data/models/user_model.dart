import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// Modelo serializable que refleja el contrato externo de usuarios.
///
/// Pertenece a `data` porque conoce JSON y puede cambiar si cambia el backend.
/// Su responsabilidad es deserializar respuestas REST/GraphQL y convertirlas en
/// la entidad pura [User] que consumen dominio y presentación.
@freezed
class UserModel with _$UserModel {
  /// Crea un modelo de usuario compatible con JsonSerializable.
  const factory UserModel({
    required int id,
    required String name,
    required String email,
  }) = _UserModel;

  /// Reconstruye el modelo desde JSON producido por Dio, Retrofit, Hive o tests.
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

/// Mapeos entre infraestructura y dominio.
extension UserModelMapper on UserModel {
  /// Convierte el modelo externo en entidad de dominio.
  User toEntity() => User(id: id, name: name, email: email);
}

/// Mapeos desde dominio hacia infraestructura para cache o payloads locales.
extension UserEntityMapper on User {
  /// Convierte una entidad de dominio en modelo serializable.
  UserModel toModel() => UserModel(id: id, name: name, email: email);
}
