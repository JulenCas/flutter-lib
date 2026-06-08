import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repositories/user_repository_impl.dart';
import '../../data/services/user_service.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/usecases/create_user_use_case.dart';
import '../../domain/usecases/get_users_use_case.dart';
import '../../presentation/bloc/user_bloc.dart';
import '../network/dio_client.dart';
import '../storage/local_storage_service.dart';

/// Instancia global de GetIt usada como contenedor de dependencias.
///
/// Exponer una variable nombrada facilita que la aplicación registre módulos
/// adicionales o reemplace dependencias en pruebas de integración.
final GetIt serviceLocator = GetIt.instance;

/// Configura todas las dependencias de la librería.
///
/// La función respeta el flujo de arquitectura limpia: primero registra
/// infraestructura (`Dio`, almacenamiento y servicios), luego repositorios,
/// después casos de uso y finalmente BLoCs. [baseUrl] define el backend REST y
/// [hiveBoxName] identifica la caja local compartida para utilidades.
Future<void> configureDependencies({
  required String baseUrl,
  String hiveBoxName = 'flutter_clean_services_cache',
}) async {
  if (!Hive.isBoxOpen(hiveBoxName)) {
    await Hive.openBox<dynamic>(hiveBoxName);
  }

  final sharedPreferences = await SharedPreferences.getInstance();
  final hiveBox = Hive.box<dynamic>(hiveBoxName);

  _registerCore(
    baseUrl: baseUrl,
    sharedPreferences: sharedPreferences,
    hiveBox: hiveBox,
  );
  _registerData();
  _registerDomain();
  _registerPresentation();
}

/// Registra servicios transversales de infraestructura.
///
/// [Dio] se crea con interceptores de logging y errores. [LocalStorageService]
/// encapsula Hive y SharedPreferences para que el resto del código no dependa de
/// inicialización concreta de plugins.
void _registerCore({
  required String baseUrl,
  required SharedPreferences sharedPreferences,
  required Box<dynamic> hiveBox,
}) {
  if (!serviceLocator.isRegistered<Dio>()) {
    serviceLocator.registerLazySingleton<Dio>(
      () => DioClient.create(baseUrl: baseUrl),
    );
  }

  if (!serviceLocator.isRegistered<LocalStorageService>()) {
    serviceLocator.registerLazySingleton<LocalStorageService>(
      () => LocalStorageService(
        sharedPreferences: sharedPreferences,
        hiveBox: hiveBox,
      ),
    );
  }
}

/// Registra adaptadores de la capa de datos.
///
/// [UserService] es el cliente Retrofit generado y [UserRepositoryImpl] adapta
/// sus modelos remotos al contrato [UserRepository] del dominio.
void _registerData() {
  if (!serviceLocator.isRegistered<UserService>()) {
    serviceLocator.registerLazySingleton<UserService>(
      () => UserService(serviceLocator<Dio>()),
    );
  }

  if (!serviceLocator.isRegistered<UserRepository>()) {
    serviceLocator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(service: serviceLocator<UserService>()),
    );
  }
}

/// Registra casos de uso de dominio.
///
/// Cada caso de uso recibe repositorios abstractos, lo que permite probar reglas
/// de negocio sin levantar HTTP ni almacenamiento local.
void _registerDomain() {
  if (!serviceLocator.isRegistered<GetUsersUseCase>()) {
    serviceLocator.registerLazySingleton<GetUsersUseCase>(
      () => GetUsersUseCase(serviceLocator<UserRepository>()),
    );
  }

  if (!serviceLocator.isRegistered<CreateUserUseCase>()) {
    serviceLocator.registerLazySingleton<CreateUserUseCase>(
      () => CreateUserUseCase(serviceLocator<UserRepository>()),
    );
  }
}

/// Registra fábricas de presentación.
///
/// El BLoC se registra como factory porque su ciclo de vida suele pertenecer a
/// una pantalla o widget, evitando compartir estado accidentalmente entre vistas.
void _registerPresentation() {
  if (!serviceLocator.isRegistered<UserBloc>()) {
    serviceLocator.registerFactory<UserBloc>(
      () => UserBloc(
        getUsers: serviceLocator<GetUsersUseCase>(),
        createUser: serviceLocator<CreateUserUseCase>(),
      ),
    );
  }
}
