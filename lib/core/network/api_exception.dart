/// Excepción normalizada para fallos de infraestructura.
///
/// Los interceptores, servicios y repositorios convierten errores técnicos en
/// esta clase para que dominio y presentación reciban un contrato estable con
/// mensaje, código HTTP opcional y causa para observabilidad.
class ApiException implements Exception {
  /// Mensaje legible o clave que la UI puede localizar.
  final String message;

  /// Código HTTP, si existe una respuesta del servidor.
  final int? statusCode;

  /// Error original conservado para logs.
  final Object? cause;

  /// Crea una excepción de API normalizada.
  const ApiException({required this.message, this.statusCode, this.cause});

  @override
  String toString() => 'ApiException(statusCode: $statusCode, message: $message)';
}
