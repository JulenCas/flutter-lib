import '../entities/user.dart';
import '../repositories/user_repository.dart';

/// Caso de uso para crear usuarios.
///
/// Centraliza reglas previas a la creación para que el BLoC solo coordine estado
/// de UI. Si mañana se agregan validaciones avanzadas o auditoría, se incorporan
/// aquí sin modificar la capa de presentación.
class CreateUserUseCase {
  /// Repositorio abstracto definido por el dominio.
  final UserRepository repository;

  /// Construye el caso de uso con su dependencia de dominio.
  const CreateUserUseCase(this.repository);

  /// Valida datos mínimos y delega la creación al repositorio.
  ///
  /// [name] no puede estar vacío y [email] debe contener `@` para demostrar una
  /// regla de negocio sencilla antes de invocar infraestructura.
  Future<User> call({required String name, required String email}) {
    final trimmedName = name.trim();
    final trimmedEmail = email.trim();

    if (trimmedName.isEmpty) {
      throw ArgumentError.value(name, 'name', 'El nombre no puede estar vacío.');
    }

    if (!trimmedEmail.contains('@')) {
      throw ArgumentError.value(email, 'email', 'El correo no es válido.');
    }

    return repository.createUser(name: trimmedName, email: trimmedEmail);
  }
}
