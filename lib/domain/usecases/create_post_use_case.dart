import '../entities/post.dart';
import '../repositories/post_repository.dart';

/// Caso de uso para crear publicaciones.
///
/// Aísla validaciones de negocio respecto a título, cuerpo y propietario antes
/// de llegar a infraestructura.
class CreatePostUseCase {
  /// Repositorio abstracto definido por dominio.
  final PostRepository repository;

  /// Crea el caso de uso con dependencia inyectada.
  const CreatePostUseCase(this.repository);

  /// Valida y crea una publicación.
  Future<Post> call({required int userId, required String title, required String body}) {
    final cleanTitle = title.trim();
    final cleanBody = body.trim();

    if (userId <= 0) {
      throw ArgumentError.value(userId, 'userId', 'El usuario debe ser válido.');
    }
    if (cleanTitle.isEmpty) {
      throw ArgumentError.value(title, 'title', 'El título no puede estar vacío.');
    }
    if (cleanBody.length < 10) {
      throw ArgumentError.value(body, 'body', 'El cuerpo debe tener al menos 10 caracteres.');
    }

    return repository.createPost(userId: userId, title: cleanTitle, body: cleanBody);
  }
}
