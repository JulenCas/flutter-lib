import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/create_user_use_case.dart';
import '../../domain/usecases/get_users_use_case.dart';
import 'user_event.dart';
import 'user_state.dart';

/// BLoC que orquesta casos de uso de usuarios y estados de presentación.
///
/// La UI envía [UserEvent] y escucha [UserState]. El BLoC no conoce Dio,
/// Retrofit ni modelos JSON; solo depende de casos de uso del dominio, cumpliendo
/// la regla de dependencias de arquitectura limpia.
class UserBloc extends Bloc<UserEvent, UserState> {
  /// Caso de uso encargado de obtener usuarios.
  final GetUsersUseCase getUsers;

  /// Caso de uso encargado de crear usuarios.
  final CreateUserUseCase createUser;

  /// Registra los handlers de eventos y recibe dependencias desde GetIt.
  UserBloc({
    required this.getUsers,
    required this.createUser,
  }) : super(const UserInitial()) {
    on<UsersRequested>(_onUsersRequested);
    on<UserCreationRequested>(_onUserCreationRequested);
  }

  /// Maneja la intención de cargar usuarios.
  ///
  /// Emite carga, ejecuta [GetUsersUseCase] y finaliza con éxito o error.
  Future<void> _onUsersRequested(
    UsersRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading(operation: 'loadUsers'));

    try {
      final users = await getUsers();
      emit(UserLoadSuccess(users));
    } catch (error) {
      emit(UserFailure(message: error.toString(), cause: error));
    }
  }

  /// Maneja la intención de crear un usuario.
  ///
  /// El BLoC delega validaciones al caso de uso y solo transforma el resultado en
  /// un estado que la UI pueda representar.
  Future<void> _onUserCreationRequested(
    UserCreationRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading(operation: 'createUser'));

    try {
      final user = await createUser(name: event.name, email: event.email);
      emit(UserCreateSuccess(user));
    } catch (error) {
      emit(UserFailure(message: error.toString(), cause: error));
    }
  }
}
