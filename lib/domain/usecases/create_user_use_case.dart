import '../entities/user.dart';
import '../repositories/user_repository.dart';

/// Caso de uso que crea usuarios.
///
/// Centraliza validaciones de negocio antes de delegar en el repositorio, de modo
/// que la UI solo coordine eventos y renderizado.
class CreateUserUseCase {
  /// Repositorio abstracto de usuarios.
  final UserRepository repository;

  /// Crea el caso de uso con dependencias inyectadas.
  const CreateUserUseCase(this.repository);

  /// Valida datos mínimos y registra un usuario.
  Future<User> call({required String name, required String email}) {
    final cleanName = name.trim();
    final cleanEmail = email.trim();

    if (cleanName.isEmpty) {
      throw ArgumentError.value(name, 'name', 'El nombre no puede estar vacío.');
    }
    if (!cleanEmail.contains('@')) {
      throw ArgumentError.value(email, 'email', 'El correo no es válido.');
    }

    return repository.createUser(name: cleanName, email: cleanEmail);
  }
}
