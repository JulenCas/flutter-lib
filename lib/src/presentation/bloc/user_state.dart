import 'package:equatable/equatable.dart';

import '../../domain/entities/user.dart';

/// Estado base del BLoC de usuarios.
///
/// La presentación consume estas clases para renderizar pantallas de carga,
/// éxito o error sin conocer repositorios ni servicios. [Equatable] permite que
/// Flutter BLoC compare estados de forma eficiente.
abstract class UserState extends Equatable {
  /// Constructor constante para estados inmutables.
  const UserState();

  @override
  List<Object?> get props => const [];
}

/// Estado inicial antes de ejecutar cualquier caso de uso.
class UserInitial extends UserState {
  /// Representa una pantalla sin datos cargados ni error.
  const UserInitial();
}

/// Estado emitido mientras se ejecuta una operación asíncrona.
class UserLoading extends UserState {
  /// Permite diferenciar si la carga corresponde a lectura o creación.
  final String operation;

  /// Crea un estado de carga con descripción de la operación activa.
  const UserLoading({this.operation = 'load'});

  @override
  List<Object?> get props => [operation];
}

/// Estado de éxito con la colección de usuarios disponible para UI.
class UserLoadSuccess extends UserState {
  /// Lista de entidades de dominio ya separadas de JSON o modelos remotos.
  final List<User> users;

  /// Crea el estado de éxito para pintar la lista de usuarios.
  const UserLoadSuccess(this.users);

  @override
  List<Object?> get props => [users];
}

/// Estado de éxito específico para creación de usuario.
class UserCreateSuccess extends UserState {
  /// Entidad creada por el backend y devuelta por el caso de uso.
  final User user;

  /// Crea el estado de éxito para que la UI muestre confirmación o navegue.
  const UserCreateSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

/// Estado de error normalizado para la UI.
class UserFailure extends UserState {
  /// Mensaje listo para mostrar o mapear a traducciones.
  final String message;

  /// Error original opcional para logging o telemetría.
  final Object? cause;

  /// Crea un estado de error sin exponer detalles técnicos al widget.
  const UserFailure({required this.message, this.cause});

  @override
  List<Object?> get props => [message, cause];
}
