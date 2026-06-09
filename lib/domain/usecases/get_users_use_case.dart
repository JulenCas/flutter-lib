import '../entities/user.dart';
import '../repositories/user_repository.dart';

/// Caso de uso que consulta usuarios.
///
/// Es el punto de entrada de presentación hacia dominio. Aquí se agregarían
/// reglas como paginación, filtros permitidos o políticas offline sin acoplar el
/// BLoC a repositorios concretos.
class GetUsersUseCase {
  /// Repositorio abstracto definido por dominio.
  final UserRepository repository;

  /// Recibe dependencias por inyección.
  const GetUsersUseCase(this.repository);

  /// Ejecuta la operación de negocio.
  Future<List<User>> call() => repository.getUsers();
}
