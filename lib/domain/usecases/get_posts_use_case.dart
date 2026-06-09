import '../entities/post.dart';
import '../repositories/post_repository.dart';

/// Caso de uso para listar publicaciones.
///
/// Puede recibir un `userId` para expresar una regla de consulta de dominio sin
/// que la UI conozca endpoints, queries GraphQL ni claves de cache.
class GetPostsUseCase {
  /// Repositorio abstracto de publicaciones.
  final PostRepository repository;

  /// Recibe el repositorio por inyección.
  const GetPostsUseCase(this.repository);

  /// Ejecuta la consulta de publicaciones.
  Future<List<Post>> call({int? userId}) => repository.getPosts(userId: userId);
}
