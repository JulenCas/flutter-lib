import 'package:equatable/equatable.dart';

/// Evento base del BLoC de usuarios.
///
/// Los eventos representan intenciones de la UI. Extender [Equatable] evita
/// reconstrucciones innecesarias y facilita pruebas comparando instancias por
/// valor en lugar de identidad.
abstract class UserEvent extends Equatable {
  /// Constructor constante para permitir eventos inmutables.
  const UserEvent();

  @override
  List<Object?> get props => const [];
}

/// Evento para cargar usuarios desde el caso de uso de consulta.
class UsersRequested extends UserEvent {
  /// No requiere propiedades porque la carga obtiene la colección completa.
  const UsersRequested();
}

/// Evento para crear un usuario nuevo desde la UI.
class UserCreationRequested extends UserEvent {
  /// Nombre introducido por el usuario.
  final String name;

  /// Correo introducido por el usuario.
  final String email;

  /// Crea el evento con los datos necesarios para el caso de uso de creación.
  const UserCreationRequested({
    required this.name,
    required this.email,
  });

  @override
  List<Object?> get props => [name, email];
}
