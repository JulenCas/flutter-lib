import 'package:dio/dio.dart';

import '../../core/network/api_exception.dart';
import '../../core/storage/local_storage_service.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../dtos/create_post_request_dto.dart';
import '../models/post_model.dart';
import '../services/post_service.dart';

/// Implementación de [PostRepository] con Retrofit y cache Hive.
///
/// Mantiene las fuentes de datos detrás del contrato de dominio. La presentación
/// recibe [Post] sin conocer JSON, Dio ni la estrategia de persistencia.
class PostRepositoryImpl implements PostRepository {
  static const _cacheKey = 'posts_cache';

  /// Fuente remota REST de publicaciones.
  final PostService service;

  /// Fuente local Hive para cache offline.
  final LocalStorageService localStorage;

  /// Crea el repositorio con fuentes inyectadas.
  const PostRepositoryImpl({required this.service, required this.localStorage});

  /// Consulta remoto, actualiza cache y usa cache ante errores de red.
  @override
  Future<List<Post>> getPosts({int? userId}) async {
    try {
      final models = await service.getPosts(userId);
      await _cachePosts(models);
      return models.map((model) => model.toEntity()).toList(growable: false);
    } on DioException catch (error) {
      final cached = _readCachedPosts(userId: userId);
      if (cached.isNotEmpty) return cached;
      throw _normalize(error);
    }
  }

  /// Crea una publicación y agrega el resultado a cache.
  @override
  Future<Post> createPost({required int userId, required String title, required String body}) async {
    try {
      final model = await service.createPost(CreatePostRequestDto(userId: userId, title: title, body: body));
      final cached = _readCachedPosts().map((post) => post.toModel()).toList();
      await _cachePosts([model, ...cached.where((item) => item.id != model.id)]);
      return model.toEntity();
    } on DioException catch (error) {
      throw _normalize(error);
    }
  }

  /// Guarda modelos como JSON para evitar adaptadores Hive específicos.
  Future<void> _cachePosts(List<PostModel> models) {
    return localStorage.setCached(
      _cacheKey,
      models.map((model) => model.toJson()).toList(growable: false),
    );
  }

  /// Lee publicaciones cacheadas y aplica filtro local opcional.
  List<Post> _readCachedPosts({int? userId}) {
    final raw = localStorage.getCached<List<dynamic>>(_cacheKey) ?? const [];
    final posts = raw
        .whereType<Map>()
        .map((json) => PostModel.fromJson(Map<String, dynamic>.from(json)).toEntity())
        .toList(growable: false);
    if (userId == null) return posts;
    return posts.where((post) => post.userId == userId).toList(growable: false);
  }

  /// Normaliza fallos de red para no filtrar Dio fuera de `data`.
  ApiException _normalize(DioException error) {
    final normalized = error.error;
    if (normalized is ApiException) return normalized;
    return ApiException(
      message: error.message ?? 'Error inesperado al consumir publicaciones.',
      statusCode: error.response?.statusCode,
      cause: error,
    );
  }
}
