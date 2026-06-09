import 'package:freezed_annotation/freezed_annotation.dart';

part 'post.freezed.dart';

/// Entidad de dominio que representa una publicación creada por un usuario.
///
/// La entidad se usa en casos de uso y BLoCs sin acoplarlos al contrato REST,
/// GraphQL o cache local. Esto permite cambiar infraestructura sin modificar la
/// presentación ni las reglas de negocio.
@freezed
class Post with _$Post {
  /// Crea una publicación de dominio inmutable.
  const factory Post({
    required int id,
    required int userId,
    required String title,
    required String body,
  }) = _Post;
}
