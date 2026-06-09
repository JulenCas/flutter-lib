import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/post.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

/// Modelo serializable que representa una publicación en infraestructura.
///
/// Separa nombres y reglas de serialización del backend de la entidad [Post],
/// preservando la independencia de la capa de dominio.
@freezed
class PostModel with _$PostModel {
  /// Crea un modelo de publicación compatible con JsonSerializable.
  const factory PostModel({
    required int id,
    required int userId,
    required String title,
    required String body,
  }) = _PostModel;

  /// Deserializa JSON recibido desde REST, GraphQL o cache Hive.
  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}

/// Mapeos entre modelo de datos y entidad de dominio.
extension PostModelMapper on PostModel {
  /// Convierte el modelo externo en entidad pura.
  Post toEntity() => Post(id: id, userId: userId, title: title, body: body);
}

/// Mapeos desde dominio hacia serialización local.
extension PostEntityMapper on Post {
  /// Convierte una entidad en modelo listo para cache.
  PostModel toModel() => PostModel(id: id, userId: userId, title: title, body: body);
}
