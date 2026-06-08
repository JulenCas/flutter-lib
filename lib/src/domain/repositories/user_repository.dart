import '../entities/user.dart';

/// Contrato del repositorio de usuarios definido por la capa de dominio.
///
/// La presentación y los casos de uso dependen de esta interfaz, no de Dio ni de
/// Retrofit. Esto permite sustituir la implementación por una API remota, cache,
/// mock de pruebas o base de datos local sin cambiar reglas de negocio.
abstract class UserRepository {
  /// Recupera usuarios como entidades puras del dominio.
  Future<List<User>> getUsers();

  /// Crea un usuario y devuelve la entidad resultante.
  ///
  /// [name] y [email] son parámetros de negocio; la implementación decide cómo
  /// convertirlos al DTO requerido por la API.
  Future<User> createUser({required String name, required String email});
}
