import 'package:dio/dio.dart';

import '../../core/network/api_exception.dart';
import '../../core/storage/local_storage_service.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../dtos/create_user_request_dto.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';

/// Implementación concreta de [UserRepository] con remoto y cache Hive.
///
/// Esta clase pertenece a `data`: coordina Retrofit, DTOs, modelos y cache local.
/// Expone únicamente entidades [User] para proteger al dominio de detalles de
/// infraestructura y habilita fallback offline cuando falla la red.
class UserRepositoryImpl implements UserRepository {
  static const _cacheKey = 'users_cache';

  /// Fuente remota REST generada por Retrofit.
  final UserService service;

  /// Fuente local usada como cache offline.
  final LocalStorageService localStorage;

  /// Crea el repositorio con fuentes inyectadas.
  const UserRepositoryImpl({required this.service, required this.localStorage});

  /// Obtiene usuarios desde remoto, actualiza cache y usa Hive como fallback.
  @override
  Future<List<User>> getUsers() async {
    try {
      final models = await service.getUsers();
      await _cacheUsers(models);
      return models.map((model) => model.toEntity()).toList(growable: false);
    } on DioException catch (error) {
      final cached = _readCachedUsers();
      if (cached.isNotEmpty) return cached;
      throw _normalize(error);
    }
  }

  /// Crea un usuario remoto y sincroniza la cache local.
  @override
  Future<User> createUser({required String name, required String email}) async {
    try {
      final model = await service.createUser(CreateUserRequestDto(name: name, email: email));
      final cached = _readCachedUsers().map((user) => user.toModel()).toList();
      await _cacheUsers([model, ...cached.where((item) => item.id != model.id)]);
      return model.toEntity();
    } on DioException catch (error) {
      throw _normalize(error);
    }
  }

  /// Persiste modelos serializados para que Hive no dependa de adaptadores.
  Future<void> _cacheUsers(List<UserModel> models) {
    return localStorage.setCached(
      _cacheKey,
      models.map((model) => model.toJson()).toList(growable: false),
    );
  }

  /// Reconstruye entidades cacheadas desde Hive.
  List<User> _readCachedUsers() {
    final raw = localStorage.getCached<List<dynamic>>(_cacheKey) ?? const [];
    return raw
        .whereType<Map>()
        .map((json) => UserModel.fromJson(Map<String, dynamic>.from(json)).toEntity())
        .toList(growable: false);
  }

  /// Convierte errores Dio a [ApiException] estable para capas superiores.
  ApiException _normalize(DioException error) {
    final normalized = error.error;
    if (normalized is ApiException) return normalized;
    return ApiException(
      message: error.message ?? 'Error inesperado al consumir usuarios.',
      statusCode: error.response?.statusCode,
      cause: error,
    );
  }
}
