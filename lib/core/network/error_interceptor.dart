import 'package:dio/dio.dart';

import 'api_exception.dart';

/// Interceptor responsable de convertir fallos HTTP en [ApiException].
///
/// Esta clase centraliza la traducción de errores técnicos de Dio a un lenguaje
/// estable para el resto de la app. De esta forma, repositorios y BLoCs no tienen
/// que conocer tipos como [DioExceptionType].
class ErrorInterceptor extends Interceptor {
  /// Analiza la respuesta o el tipo de fallo y adjunta una [ApiException] como
  /// `error` normalizado dentro de [DioException].
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;
    final message = _messageFor(err, statusCode);

    handler.reject(
      err.copyWith(
        error: ApiException(
          message: message,
          statusCode: statusCode,
          cause: err,
        ),
      ),
    );
  }

  /// Resuelve mensajes consistentes por timeout, cancelación o códigos HTTP.
  String _messageFor(DioException err, int? statusCode) {
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout) {
      return 'La solicitud tardó demasiado en responder.';
    }

    if (err.type == DioExceptionType.cancel) {
      return 'La solicitud fue cancelada.';
    }

    if (statusCode != null) {
      return 'El servidor respondió con el código HTTP $statusCode.';
    }

    return 'No fue posible completar la solicitud de red.';
  }
}
