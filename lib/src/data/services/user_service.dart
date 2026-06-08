import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../dtos/create_user_request_dto.dart';
import '../models/user_model.dart';

part 'user_service.g.dart';

/// Servicio Retrofit que declara las operaciones REST de usuarios.
///
/// Esta clase pertenece a la capa de datos porque conoce rutas HTTP, verbos,
/// cuerpos y tipos serializables. Retrofit genera la implementación concreta en
/// `user_service.g.dart` al ejecutar `dart run build_runner build`.
@RestApi()
abstract class UserService {
  /// Construye el cliente generado usando la instancia de [Dio] configurada en
  /// `DioClient`. [baseUrl] permite sobrescribir la URL para pruebas o entornos.
  factory UserService(Dio dio, {String baseUrl}) = _UserService;

  /// Obtiene todos los usuarios disponibles en el backend.
  ///
  /// La anotación [GET] declara el endpoint y Retrofit transforma la respuesta
  /// JSON en una lista de [UserModel].
  @GET('/users')
  Future<List<UserModel>> getUsers();

  /// Crea un usuario en el backend.
  ///
  /// [request] contiene el cuerpo JSON del `POST`. El backend responde con el
  /// [UserModel] creado, que después será mapeado a una entidad de dominio.
  @POST('/users')
  Future<UserModel> createUser(@Body() CreateUserRequestDto request);
}
