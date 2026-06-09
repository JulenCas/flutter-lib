import 'package:equatable/equatable.dart';

/// Evento base del BLoC de ejemplo.
///
/// Los eventos representan intenciones de UI. Extender [Equatable] facilita
/// pruebas y evita comparar instancias por identidad.
abstract class AppEvent extends Equatable {
  /// Constructor constante para eventos inmutables.
  const AppEvent();

  @override
  List<Object?> get props => const [];
}

/// Evento que solicita cargar usuarios y publicaciones.
class DashboardRequested extends AppEvent {
  /// Crea el evento de carga inicial.
  const DashboardRequested();
}

/// Evento que solicita crear un usuario desde el formulario.
class UserSubmitted extends AppEvent {
  /// Nombre capturado por el formulario.
  final String name;

  /// Correo capturado por el formulario.
  final String email;

  /// Crea el evento con datos de formulario.
  const UserSubmitted({required this.name, required this.email});

  @override
  List<Object?> get props => [name, email];
}

/// Evento que solicita crear una publicación.
class PostSubmitted extends AppEvent {
  /// Usuario propietario.
  final int userId;

  /// Título de la publicación.
  final String title;

  /// Contenido de la publicación.
  final String body;

  /// Crea el evento con datos del formulario de publicación.
  const PostSubmitted({required this.userId, required this.title, required this.body});

  @override
  List<Object?> get props => [userId, title, body];
}
