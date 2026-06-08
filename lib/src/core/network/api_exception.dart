/// Excepción normalizada para la capa de red.
///
/// La capa de datos transforma errores específicos de Dio, Retrofit o del
/// servidor en esta clase para que las capas superiores no dependan de detalles
/// de infraestructura. El dominio y la presentación reciben un mensaje, un código
/// HTTP opcional y el error original únicamente para trazabilidad.
class ApiException implements Exception {
  /// Mensaje legible que puede mostrarse o mapearse a una cadena localizada.
  final String message;

  /// Código HTTP recibido desde el backend. Es `null` cuando el error ocurrió
  /// antes de obtener una respuesta, por ejemplo por timeout o falta de conexión.
  final int? statusCode;

  /// Error original capturado en infraestructura. Mantenerlo como `Object?`
  /// evita filtrar tipos concretos hacia dominio o presentación.
  final Object? cause;

  /// Crea una excepción de API con datos mínimos para diagnóstico y UI.
  const ApiException({
    required this.message,
    this.statusCode,
    this.cause,
  });

  @override
  String toString() => 'ApiException(statusCode: $statusCode, message: $message)';
}
