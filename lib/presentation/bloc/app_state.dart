import 'package:equatable/equatable.dart';

import '../../domain/entities/post.dart';
import '../../domain/entities/user.dart';

/// Estado base para el BLoC de presentación.
///
/// La UI observa estas clases para renderizar carga, éxito o error sin conocer
/// repositorios, servicios ni modelos de datos.
abstract class AppState extends Equatable {
  /// Constructor constante para estados inmutables.
  const AppState();

  @override
  List<Object?> get props => const [];
}

/// Estado inicial antes de ejecutar casos de uso.
class AppInitial extends AppState {
  /// Crea el estado inicial.
  const AppInitial();
}

/// Estado de carga con descripción de operación activa.
class AppLoading extends AppState {
  /// Operación que originó la carga.
  final String operation;

  /// Crea un estado de carga.
  const AppLoading({required this.operation});

  @override
  List<Object?> get props => [operation];
}

/// Estado de éxito del dashboard.
class DashboardSuccess extends AppState {
  /// Usuarios listos para pintar con `ListView.builder`.
  final List<User> users;

  /// Publicaciones listas para pintar con `ListView.builder`.
  final List<Post> posts;

  /// Crea el estado exitoso con entidades de dominio.
  const DashboardSuccess({required this.users, required this.posts});

  @override
  List<Object?> get props => [users, posts];
}

/// Estado exitoso tras crear un registro.
class MutationSuccess extends AppState {
  /// Mensaje descriptivo para UI/localización.
  final String message;

  /// Crea el estado de mutación correcta.
  const MutationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

/// Estado de error normalizado para presentación.
class AppFailure extends AppState {
  /// Mensaje que el widget puede mostrar o traducir.
  final String message;

  /// Causa técnica opcional para logs.
  final Object? cause;

  /// Crea el estado de fallo.
  const AppFailure({required this.message, this.cause});

  @override
  List<Object?> get props => [message, cause];
}
