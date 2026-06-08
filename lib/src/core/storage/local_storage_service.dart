import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Servicio de almacenamiento local para utilidades transversales.
///
/// Combina [SharedPreferences] para valores simples de configuración y [Hive]
/// para datos estructurados o cacheables. La interfaz concreta se registra en
/// GetIt para que repositorios o casos de uso puedan depender de una abstracción
/// de almacenamiento sin crear instancias manualmente.
class LocalStorageService {
  /// Preferencias livianas del dispositivo, útiles para flags, tokens o ajustes.
  final SharedPreferences sharedPreferences;

  /// Caja de Hive usada para cache genérica. Puede reemplazarse por cajas más
  /// específicas cuando el dominio crezca.
  final Box<dynamic> hiveBox;

  /// Construye el servicio con dependencias inicializadas por el service locator.
  const LocalStorageService({
    required this.sharedPreferences,
    required this.hiveBox,
  });

  /// Lee una cadena desde [SharedPreferences].
  String? getString(String key) => sharedPreferences.getString(key);

  /// Guarda una cadena en [SharedPreferences].
  Future<bool> setString(String key, String value) =>
      sharedPreferences.setString(key, value);

  /// Lee cualquier valor serializable desde Hive.
  T? getCached<T>(String key) => hiveBox.get(key) as T?;

  /// Guarda cualquier valor compatible con Hive en la caja configurada.
  Future<void> setCached<T>(String key, T value) => hiveBox.put(key, value);

  /// Elimina datos de ambas tecnologías para una clave concreta.
  Future<void> remove(String key) async {
    await sharedPreferences.remove(key);
    await hiveBox.delete(key);
  }
}
