import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/repositories/post_repository_impl.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../data/services/graphql_content_service.dart';
import '../../data/services/post_service.dart';
import '../../data/services/user_service.dart';
import '../../domain/repositories/post_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/usecases/create_post_use_case.dart';
import '../../domain/usecases/create_user_use_case.dart';
import '../../domain/usecases/get_posts_use_case.dart';
import '../../domain/usecases/get_users_use_case.dart';
import '../../presentation/bloc/app_bloc.dart';
import '../network/dio_client.dart';
import '../storage/local_storage_service.dart';

/// Instancia global de GetIt para la composición de dependencias.
///
/// La aplicación depende de este punto de ensamblaje, no de constructores
/// dispersos. En proyectos grandes puede reemplazarse por el archivo generado de
/// Injectable manteniendo los mismos registros conceptuales.
final GetIt serviceLocator = GetIt.instance;

/// Módulo demostrativo para Injectable.
///
/// Las anotaciones documentan cómo migrar el registro manual a generación con
/// `injectable_generator` si el equipo desea usar `@InjectableInit` y módulos
/// generados. El ejemplo mantiene registros explícitos para ser legible.
@module
abstract class AppInjectableModule {
  /// Expone GetIt para módulos generados o pruebas.
  GetIt get getIt => serviceLocator;
}

/// Configura dependencias siguiendo arquitectura limpia.
///
/// El orden es infraestructura, fuentes remotas/locales, repositorios, casos de
/// uso y finalmente gestores de estado. [baseUrl] apunta al REST backend y
/// [graphQlUrl] activa el servicio opcional GraphQL.
Future<void> configureDependencies({
  required String baseUrl,
  String? graphQlUrl,
  String hiveBoxName = 'clean_architecture_cache',
}) async {
  if (!Hive.isBoxOpen(hiveBoxName)) {
    await Hive.openBox<dynamic>(hiveBoxName);
  }

  final sharedPreferences = await SharedPreferences.getInstance();
  final hiveBox = Hive.box<dynamic>(hiveBoxName);

  _registerCore(baseUrl: baseUrl, graphQlUrl: graphQlUrl, sharedPreferences: sharedPreferences, hiveBox: hiveBox);
  _registerData();
  _registerDomain();
  _registerPresentation();
}

/// Registra infraestructura transversal.
void _registerCore({
  required String baseUrl,
  required String? graphQlUrl,
  required SharedPreferences sharedPreferences,
  required Box<dynamic> hiveBox,
}) {
  if (!serviceLocator.isRegistered<Dio>()) {
    serviceLocator.registerLazySingleton<Dio>(() => DioClient.create(baseUrl: baseUrl));
  }

  if (!serviceLocator.isRegistered<LocalStorageService>()) {
    serviceLocator.registerLazySingleton<LocalStorageService>(
      () => LocalStorageService(sharedPreferences: sharedPreferences, hiveBox: hiveBox),
    );
  }

  if (graphQlUrl != null && !serviceLocator.isRegistered<GraphQLClient>()) {
    serviceLocator.registerLazySingleton<GraphQLClient>(
      () => GraphQLClient(link: HttpLink(graphQlUrl), cache: GraphQLCache(store: InMemoryStore())),
    );
    serviceLocator.registerLazySingleton<GraphqlContentService>(() => GraphqlContentService(serviceLocator<GraphQLClient>()));
  }
}

/// Registra servicios remotos y repositorios de datos.
void _registerData() {
  if (!serviceLocator.isRegistered<UserService>()) {
    serviceLocator.registerLazySingleton<UserService>(() => UserService(serviceLocator<Dio>()));
  }
  if (!serviceLocator.isRegistered<PostService>()) {
    serviceLocator.registerLazySingleton<PostService>(() => PostService(serviceLocator<Dio>()));
  }
  if (!serviceLocator.isRegistered<UserRepository>()) {
    serviceLocator.registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(service: serviceLocator<UserService>(), localStorage: serviceLocator<LocalStorageService>()),
    );
  }
  if (!serviceLocator.isRegistered<PostRepository>()) {
    serviceLocator.registerLazySingleton<PostRepository>(
      () => PostRepositoryImpl(service: serviceLocator<PostService>(), localStorage: serviceLocator<LocalStorageService>()),
    );
  }
}

/// Registra casos de uso de dominio.
void _registerDomain() {
  if (!serviceLocator.isRegistered<GetUsersUseCase>()) {
    serviceLocator.registerLazySingleton<GetUsersUseCase>(() => GetUsersUseCase(serviceLocator<UserRepository>()));
  }
  if (!serviceLocator.isRegistered<CreateUserUseCase>()) {
    serviceLocator.registerLazySingleton<CreateUserUseCase>(() => CreateUserUseCase(serviceLocator<UserRepository>()));
  }
  if (!serviceLocator.isRegistered<GetPostsUseCase>()) {
    serviceLocator.registerLazySingleton<GetPostsUseCase>(() => GetPostsUseCase(serviceLocator<PostRepository>()));
  }
  if (!serviceLocator.isRegistered<CreatePostUseCase>()) {
    serviceLocator.registerLazySingleton<CreatePostUseCase>(() => CreatePostUseCase(serviceLocator<PostRepository>()));
  }
}

/// Registra gestores de estado de presentación.
void _registerPresentation() {
  if (!serviceLocator.isRegistered<AppBloc>()) {
    serviceLocator.registerFactory<AppBloc>(
      () => AppBloc(
        getUsers: serviceLocator<GetUsersUseCase>(),
        createUser: serviceLocator<CreateUserUseCase>(),
        getPosts: serviceLocator<GetPostsUseCase>(),
        createPost: serviceLocator<CreatePostUseCase>(),
      ),
    );
  }
}
