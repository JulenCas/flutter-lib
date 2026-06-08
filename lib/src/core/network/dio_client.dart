import 'package:dio/dio.dart';

import 'error_interceptor.dart';
import 'logging_interceptor.dart';

/// Fábrica centralizada de [Dio].
///
/// Mantener la configuración HTTP en un único punto facilita cambiar cabeceras,
/// timeouts, autenticación o trazabilidad sin modificar cada servicio Retrofit.
class DioClient {
  /// Crea una instancia configurada con URL base, timeouts e interceptores.
  ///
  /// [baseUrl] identifica el backend REST. [extraInterceptors] permite a la app
  /// agregar autenticación, métricas u otros comportamientos específicos sin
  /// editar esta librería.
  static Dio create({
    required String baseUrl,
    Iterable<Interceptor> extraInterceptors = const [],
  }) {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        headers: const {
          Headers.acceptHeader: 'application/json',
          Headers.contentTypeHeader: 'application/json',
        },
      ),
    );

    dio.interceptors.addAll([
      LoggingInterceptor(),
      ErrorInterceptor(),
      ...extraInterceptors,
    ]);

    return dio;
  }
}
