import '../entities/post.dart';

/// Contrato de dominio para publicaciones.
///
/// Abstrae Retrofit, GraphQL, Hive o cualquier detalle de almacenamiento para
/// que los casos de uso expresen solo operaciones de negocio.
abstract class PostRepository {
  /// Obtiene publicaciones asociadas opcionalmente a un usuario.
  Future<List<Post>> getPosts({int? userId});

  /// Crea una publicación para un usuario.
  Future<Post> createPost({
    required int userId,
    required String title,
    required String body,
  });
}
