import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// Modelo de datos que refleja la representación JSON del backend para usuarios.
///
/// A diferencia de [User], este tipo pertenece a la capa de datos y puede incluir
/// detalles de serialización. Su responsabilidad principal es transformar JSON en
/// objetos Dart y mapearlos hacia la entidad de dominio.
@freezed
class UserModel with _$UserModel {
  /// Crea un modelo recibido o enviado por la API.
  ///
  /// [id], [name] y [email] se anotan implícitamente con JsonSerializable por
  /// Freezed, manteniendo paridad con el contrato REST.
  const factory UserModel({
    required int id,
    required String name,
    required String email,
  }) = _UserModel;

  /// Deserializa un mapa JSON producido por Retrofit/Dio.
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

/// Extensión de mapeo para aislar conversiones entre datos y dominio.
extension UserModelMapper on UserModel {
  /// Convierte el modelo de infraestructura a entidad pura de dominio.
  User toEntity() => User(id: id, name: name, email: email);
}
