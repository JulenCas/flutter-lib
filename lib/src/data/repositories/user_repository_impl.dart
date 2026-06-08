import 'package:dio/dio.dart';

import '../../core/network/api_exception.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../dtos/create_user_request_dto.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';

/// Implementación remota de [UserRepository].
///
/// Vive en la capa de datos porque conoce [UserService], DTOs y modelos. Su tarea
/// es coordinar llamadas HTTP, convertir errores técnicos a [ApiException] y
/// mapear [UserModel] hacia [User] para proteger el dominio.
class UserRepositoryImpl implements UserRepository {
  /// Servicio Retrofit encargado de realizar las peticiones REST.
  final UserService service;

  /// Crea el repositorio con el servicio remoto inyectado desde GetIt.
  const UserRepositoryImpl({required this.service});

  /// Solicita usuarios al servicio y los transforma en entidades de dominio.
  @override
  Future<List<User>> getUsers() async {
    try {
      final models = await service.getUsers();
      return models.map((model) => model.toEntity()).toList(growable: false);
    } on DioException catch (error) {
      throw _normalize(error);
    }
  }

  /// Construye un DTO de creación, llama a la API y devuelve la entidad creada.
  @override
  Future<User> createUser({required String name, required String email}) async {
    try {
      final model = await service.createUser(
        CreateUserRequestDto(name: name, email: email),
      );
      return model.toEntity();
    } on DioException catch (error) {
      throw _normalize(error);
    }
  }

  /// Extrae la [ApiException] generada por el interceptor o crea una por defecto.
  ApiException _normalize(DioException error) {
    final normalized = error.error;
    if (normalized is ApiException) {
      return normalized;
    }

    return ApiException(
      message: error.message ?? 'Error inesperado al consumir el servicio.',
      statusCode: error.response?.statusCode,
      cause: error,
    );
  }
}
