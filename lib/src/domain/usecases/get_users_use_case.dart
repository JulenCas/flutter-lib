import '../entities/user.dart';
import '../repositories/user_repository.dart';

/// Caso de uso para consultar usuarios.
///
/// Los casos de uso encapsulan acciones de negocio y son el punto de entrada que
/// utiliza la presentación. Aunque aquí la lógica es simple, este archivo es el
/// lugar correcto para añadir validaciones, reglas de cache o combinaciones de
/// repositorios sin acoplar el BLoC a infraestructura.
class GetUsersUseCase {
  /// Repositorio abstracto definido en dominio.
  final UserRepository repository;

  /// Recibe el repositorio por inyección de dependencias.
  const GetUsersUseCase(this.repository);

  /// Ejecuta la consulta de usuarios.
  Future<List<User>> call() => repository.getUsers();
}
