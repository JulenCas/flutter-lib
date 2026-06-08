/// Punto de entrada público de la librería.
///
/// Este archivo exporta únicamente las piezas que una aplicación Flutter necesita
/// para integrar la librería: configuración de dependencias, entidades de
/// dominio, casos de uso y BLoC. La implementación de datos permanece disponible
/// para composición avanzada, pero la aplicación debería depender principalmente
/// del contrato de dominio para respetar arquitectura limpia.
library flutter_clean_services;

export 'src/core/di/service_locator.dart';
export 'src/core/network/api_exception.dart';
export 'src/core/storage/local_storage_service.dart';
export 'src/data/dtos/create_user_request_dto.dart';
export 'src/data/models/user_model.dart';
export 'src/data/repositories/user_repository_impl.dart';
export 'src/data/services/user_service.dart';
export 'src/domain/entities/user.dart';
export 'src/domain/repositories/user_repository.dart';
export 'src/domain/usecases/create_user_use_case.dart';
export 'src/domain/usecases/get_users_use_case.dart';
export 'src/presentation/bloc/user_bloc.dart';
export 'src/presentation/bloc/user_event.dart';
export 'src/presentation/bloc/user_state.dart';
export 'src/widgets/flutter_widget_catalog.dart';
