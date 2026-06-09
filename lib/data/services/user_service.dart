import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../dtos/create_user_request_dto.dart';
import '../models/user_model.dart';

part 'user_service.g.dart';

/// Cliente REST Retrofit para usuarios.
///
/// Pertenece a `data` porque conoce verbos HTTP, rutas y DTOs. Retrofit genera
/// la implementación concreta, dejando al repositorio la tarea de mapear modelos
/// hacia entidades de dominio.
@RestApi()
abstract class UserService {
  /// Crea el cliente generado a partir de un [Dio] configurado.
  factory UserService(Dio dio, {String baseUrl}) = _UserService;

  /// Ejecuta `GET /users` y devuelve modelos serializables.
  @GET('/users')
  Future<List<UserModel>> getUsers();

  /// Ejecuta `POST /users` con un DTO de creación.
  @POST('/users')
  Future<UserModel> createUser(@Body() CreateUserRequestDto request);
}
