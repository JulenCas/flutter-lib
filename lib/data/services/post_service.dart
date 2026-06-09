import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../dtos/create_post_request_dto.dart';
import '../models/post_model.dart';

part 'post_service.g.dart';

/// Cliente REST Retrofit para publicaciones.
///
/// Declara endpoints y contratos técnicos, manteniéndolos fuera del dominio y
/// permitiendo que el repositorio combine resultados con cache local.
@RestApi()
abstract class PostService {
  /// Construye el cliente generado usando [Dio].
  factory PostService(Dio dio, {String baseUrl}) = _PostService;

  /// Ejecuta `GET /posts`, opcionalmente filtrado por `userId`.
  @GET('/posts')
  Future<List<PostModel>> getPosts(@Query('userId') int? userId);

  /// Ejecuta `POST /posts` con payload serializable.
  @POST('/posts')
  Future<PostModel> createPost(@Body() CreatePostRequestDto request);
}
