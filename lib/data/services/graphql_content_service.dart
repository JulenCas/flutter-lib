import 'package:graphql_flutter/graphql_flutter.dart';

/// Servicio opcional GraphQL para lecturas de contenido.
///
/// Demuestra cómo la capa `data` puede integrar otra tecnología de red sin
/// afectar casos de uso. El repositorio puede elegir REST o GraphQL detrás de la
/// misma abstracción de dominio.
class GraphqlContentService {
  /// Cliente GraphQL configurado por inyección.
  final GraphQLClient client;

  /// Construye el servicio opcional.
  const GraphqlContentService(this.client);

  /// Consulta usuarios con GraphQL y devuelve mapas serializables.
  Future<List<Map<String, dynamic>>> fetchUsers() async {
    final result = await client.query(
      QueryOptions(
        document: gql(r'''
          query Users {
            users { id name email }
          }
        '''),
      ),
    );

    if (result.hasException) {
      throw result.exception!;
    }

    final users = result.data?['users'] as List<dynamic>? ?? const [];
    return users.cast<Map<String, dynamic>>();
  }
}
