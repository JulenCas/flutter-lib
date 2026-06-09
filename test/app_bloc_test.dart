import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_clean_services/flutter_clean_services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockUserRepository extends Mock implements UserRepository {
  @override
  Future<List<User>> getUsers() => super.noSuchMethod(Invocation.method(#getUsers, const []), returnValue: Future<List<User>>.value(const [])) as Future<List<User>>;

  @override
  Future<User> createUser({required String name, required String email}) => super.noSuchMethod(Invocation.method(#createUser, const [], {#name: name, #email: email}), returnValue: Future<User>.value(const User(id: 0, name: 'mock', email: 'mock@example.com'))) as Future<User>;
}
class MockPostRepository extends Mock implements PostRepository {
  @override
  Future<List<Post>> getPosts({int? userId}) => super.noSuchMethod(Invocation.method(#getPosts, const [], {#userId: userId}), returnValue: Future<List<Post>>.value(const [])) as Future<List<Post>>;

  @override
  Future<Post> createPost({required int userId, required String title, required String body}) => super.noSuchMethod(Invocation.method(#createPost, const [], {#userId: userId, #title: title, #body: body}), returnValue: Future<Post>.value(const Post(id: 0, userId: 1, title: 'mock', body: 'mock body value'))) as Future<Post>;
}

void main() {
  late MockUserRepository userRepository;
  late MockPostRepository postRepository;
  late AppBloc bloc;

  setUp(() {
    userRepository = MockUserRepository();
    postRepository = MockPostRepository();
    bloc = AppBloc(
      getUsers: GetUsersUseCase(userRepository),
      createUser: CreateUserUseCase(userRepository),
      getPosts: GetPostsUseCase(postRepository),
      createPost: CreatePostUseCase(postRepository),
    );
  });

  tearDown(() => bloc.close());

  blocTest<AppBloc, AppState>(
    'emite carga y éxito al solicitar dashboard',
    build: () {
      when(userRepository.getUsers()).thenAnswer((_) async => const [User(id: 1, name: 'Ana', email: 'ana@example.com')]);
      when(postRepository.getPosts(userId: null)).thenAnswer((_) async => const [Post(id: 1, userId: 1, title: 'T', body: 'Contenido largo')]);
      return bloc;
    },
    act: (bloc) => bloc.add(const DashboardRequested()),
    expect: () => const [
      AppLoading(operation: 'dashboard'),
      DashboardSuccess(
        users: [User(id: 1, name: 'Ana', email: 'ana@example.com')],
        posts: [Post(id: 1, userId: 1, title: 'T', body: 'Contenido largo')],
      ),
    ],
  );
}
