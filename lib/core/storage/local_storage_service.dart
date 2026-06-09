import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Fachada de almacenamiento local basada en Hive y SharedPreferences.
///
/// Es infraestructura compartida por repositorios. Hive guarda colecciones
/// serializables como cache offline, mientras SharedPreferences conserva valores
/// simples de configuración. La UI nunca usa esta clase directamente.
class LocalStorageService {
  /// Preferencias simples de la plataforma.
  final SharedPreferences sharedPreferences;

  /// Caja Hive compartida para cache del ejemplo.
  final Box<dynamic> hiveBox;

  /// Construye la fachada con plugins ya inicializados por DI.
  const LocalStorageService({required this.sharedPreferences, required this.hiveBox});

  /// Recupera una cadena desde preferencias.
  String? getString(String key) => sharedPreferences.getString(key);

  /// Guarda una cadena en preferencias.
  Future<bool> setString(String key, String value) => sharedPreferences.setString(key, value);

  /// Recupera un valor cacheado desde Hive.
  T? getCached<T>(String key) => hiveBox.get(key) as T?;

  /// Guarda un valor serializable en Hive.
  Future<void> setCached<T>(String key, T value) => hiveBox.put(key, value);

  /// Elimina una clave tanto de preferencias como de Hive.
  Future<void> remove(String key) async {
    await sharedPreferences.remove(key);
    await hiveBox.delete(key);
  }
}
