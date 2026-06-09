import '../entities/user.dart';

/// Contrato de dominio para operaciones de usuarios.
///
/// La presentación y los casos de uso dependen de esta abstracción. La capa de
/// datos implementa el contrato combinando fuentes remotas y locales, lo que
/// cumple la regla de dependencias de arquitectura limpia.
abstract class UserRepository {
  /// Obtiene usuarios, idealmente desde remoto y con fallback a cache local.
  Future<List<User>> getUsers();

  /// Crea un usuario y devuelve la entidad resultante.
  Future<User> createUser({required String name, required String email});
}
