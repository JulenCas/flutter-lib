import 'package:flutter_clean_services/flutter_clean_services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

/// Mock manual de Mockito para probar casos de uso sin infraestructura.
class MockUserRepository extends Mock implements UserRepository {
  @override
  Future<List<User>> getUsers() => super.noSuchMethod(Invocation.method(#getUsers, const []), returnValue: Future<List<User>>.value(const [])) as Future<List<User>>;

  @override
  Future<User> createUser({required String name, required String email}) => super.noSuchMethod(Invocation.method(#createUser, const [], {#name: name, #email: email}), returnValue: Future<User>.value(const User(id: 0, name: 'mock', email: 'mock@example.com'))) as Future<User>;
}

/// Mock manual de Mockito para probar publicaciones sin red ni Hive.
class MockPostRepository extends Mock implements PostRepository {
  @override
  Future<List<Post>> getPosts({int? userId}) => super.noSuchMethod(Invocation.method(#getPosts, const [], {#userId: userId}), returnValue: Future<List<Post>>.value(const [])) as Future<List<Post>>;

  @override
  Future<Post> createPost({required int userId, required String title, required String body}) => super.noSuchMethod(Invocation.method(#createPost, const [], {#userId: userId, #title: title, #body: body}), returnValue: Future<Post>.value(const Post(id: 0, userId: 1, title: 'mock', body: 'mock body value'))) as Future<Post>;
}

void main() {
  group('CreateUserUseCase', () {
    test('valida y delega la creación al repositorio', () async {
      final repository = MockUserRepository();
      final created = User(id: 1, name: 'Ana', email: 'ana@example.com');
      when(repository.createUser(name: 'Ana', email: 'ana@example.com')).thenAnswer((_) async => created);

      final result = await CreateUserUseCase(repository)(name: ' Ana ', email: ' ana@example.com ');

      expect(result, created);
      verify(repository.createUser(name: 'Ana', email: 'ana@example.com')).called(1);
    });

    test('rechaza correos inválidos antes de llamar infraestructura', () {
      final repository = MockUserRepository();

      expect(
        () => CreateUserUseCase(repository)(name: 'Ana', email: 'invalid'),
        throwsA(isA<ArgumentError>()),
      );
      verifyNever(repository.createUser(name: anyNamed('name'), email: anyNamed('email')));
    });
  });

  group('CreatePostUseCase', () {
    test('valida y delega la creación de posts', () async {
      final repository = MockPostRepository();
      final created = Post(id: 10, userId: 1, title: 'Hola', body: 'Contenido largo');
      when(repository.createPost(userId: 1, title: 'Hola', body: 'Contenido largo')).thenAnswer((_) async => created);

      final result = await CreatePostUseCase(repository)(userId: 1, title: ' Hola ', body: ' Contenido largo ');

      expect(result, created);
      verify(repository.createPost(userId: 1, title: 'Hola', body: 'Contenido largo')).called(1);
    });
  });
}
