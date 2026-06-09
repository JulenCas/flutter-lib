import 'package:dio/dio.dart';

/// Interceptor de logging para peticiones HTTP.
///
/// En una aplicación real se puede reemplazar `print` por un logger corporativo
/// o por integración con observabilidad. Está en `core/network` porque es una
/// utilidad transversal usada por cualquier servicio Retrofit.
class LoggingInterceptor extends Interceptor {
  /// Registra método, URL y payload saliente antes de enviar la petición.
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // ignore: avoid_print
    print('[HTTP] --> ${options.method} ${options.uri} data=${options.data}');
    handler.next(options);
  }

  /// Registra código de estado y URL cuando el backend responde correctamente.
  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    // ignore: avoid_print
    print('[HTTP] <-- ${response.statusCode} ${response.requestOptions.uri}');
    handler.next(response);
  }

  /// Registra el error de red antes de delegar la normalización al interceptor de errores.
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // ignore: avoid_print
    print('[HTTP] xx ${err.response?.statusCode} ${err.requestOptions.uri}: ${err.message}');
    handler.next(err);
  }
}
