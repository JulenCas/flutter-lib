/// Punto de entrada público de la librería y aplicación de ejemplo.
///
/// Exporta piezas representativas de una arquitectura limpia: `data` contiene
/// modelos, DTOs, servicios y repositorios concretos; `domain` contiene entidades,
/// contratos y casos de uso; `presentation` contiene BLoC y widgets Flutter.
library flutter_clean_services;

export 'core/di/service_locator.dart';
export 'core/network/api_exception.dart';
export 'core/network/dio_client.dart';
export 'core/storage/local_storage_service.dart';
export 'data/dtos/create_post_request_dto.dart';
export 'data/dtos/create_user_request_dto.dart';
export 'data/models/post_model.dart';
export 'data/models/user_model.dart';
export 'data/repositories/post_repository_impl.dart';
export 'data/repositories/user_repository_impl.dart';
export 'data/services/graphql_content_service.dart';
export 'data/services/post_service.dart';
export 'data/services/user_service.dart';
export 'domain/entities/post.dart';
export 'domain/entities/user.dart';
export 'domain/repositories/post_repository.dart';
export 'domain/repositories/user_repository.dart';
export 'domain/usecases/create_post_use_case.dart';
export 'domain/usecases/create_user_use_case.dart';
export 'domain/usecases/get_posts_use_case.dart';
export 'domain/usecases/get_users_use_case.dart';
export 'presentation/bloc/app_bloc.dart';
export 'presentation/bloc/app_event.dart';
export 'presentation/bloc/app_state.dart';
export 'presentation/pages/clean_architecture_example_app.dart';
export 'presentation/widgets/post_form.dart';
export 'presentation/widgets/user_form.dart';
export 'src/widgets/flutter_widget_catalog.dart';
