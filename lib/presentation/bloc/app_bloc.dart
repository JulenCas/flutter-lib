import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/create_post_use_case.dart';
import '../../domain/usecases/create_user_use_case.dart';
import '../../domain/usecases/get_posts_use_case.dart';
import '../../domain/usecases/get_users_use_case.dart';
import 'app_event.dart';
import 'app_state.dart';

/// BLoC principal del ejemplo de arquitectura limpia.
///
/// Recibe eventos desde widgets, ejecuta casos de uso de dominio y emite estados
/// Equatable. No conoce Dio, Retrofit, Hive ni modelos JSON.
class AppBloc extends Bloc<AppEvent, AppState> {
  /// Caso de uso para obtener usuarios.
  final GetUsersUseCase getUsers;

  /// Caso de uso para crear usuarios.
  final CreateUserUseCase createUser;

  /// Caso de uso para obtener publicaciones.
  final GetPostsUseCase getPosts;

  /// Caso de uso para crear publicaciones.
  final CreatePostUseCase createPost;

  /// Registra handlers y recibe dependencias desde GetIt.
  AppBloc({
    required this.getUsers,
    required this.createUser,
    required this.getPosts,
    required this.createPost,
  }) : super(const AppInitial()) {
    on<DashboardRequested>(_onDashboardRequested);
    on<UserSubmitted>(_onUserSubmitted);
    on<PostSubmitted>(_onPostSubmitted);
  }

  /// Carga datos del dashboard usando casos de uso independientes.
  Future<void> _onDashboardRequested(DashboardRequested event, Emitter<AppState> emit) async {
    emit(const AppLoading(operation: 'dashboard'));
    try {
      final usersFuture = getUsers();
      final postsFuture = getPosts();
      final users = await usersFuture;
      final posts = await postsFuture;
      emit(DashboardSuccess(users: users, posts: posts));
    } catch (error) {
      emit(AppFailure(message: error.toString(), cause: error));
    }
  }

  /// Crea un usuario y emite una confirmación.
  Future<void> _onUserSubmitted(UserSubmitted event, Emitter<AppState> emit) async {
    emit(const AppLoading(operation: 'createUser'));
    try {
      final user = await createUser(name: event.name, email: event.email);
      emit(MutationSuccess('Usuario creado: ${user.name}'));
      add(const DashboardRequested());
    } catch (error) {
      emit(AppFailure(message: error.toString(), cause: error));
    }
  }

  /// Crea una publicación y emite una confirmación.
  Future<void> _onPostSubmitted(PostSubmitted event, Emitter<AppState> emit) async {
    emit(const AppLoading(operation: 'createPost'));
    try {
      final post = await createPost(userId: event.userId, title: event.title, body: event.body);
      emit(MutationSuccess('Publicación creada: ${post.title}'));
      add(const DashboardRequested());
    } catch (error) {
      emit(AppFailure(message: error.toString(), cause: error));
    }
  }
}
