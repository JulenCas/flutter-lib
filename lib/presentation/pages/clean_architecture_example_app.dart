import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/di/service_locator.dart';
import '../../domain/entities/post.dart';
import '../../domain/entities/user.dart';
import '../bloc/app_bloc.dart';
import '../bloc/app_event.dart';
import '../bloc/app_state.dart';
import '../widgets/post_form.dart';
import '../widgets/user_form.dart';

/// Aplicación de ejemplo que ensambla la capa de presentación.
///
/// Usa Easy Localization para textos, Bloc para estado, BottomNavigationBar para
/// navegación de secciones, Navigator para detalle, ListView.builder para listas,
/// formularios Material y animaciones con AnimatedContainer/Lottie.
class CleanArchitectureExampleApp extends StatelessWidget {
  /// Crea la app demostrativa. Debe llamarse después de `configureDependencies`.
  const CleanArchitectureExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [Locale('es'), Locale('en')],
      path: 'assets/translations',
      fallbackLocale: const Locale('es'),
      child: Builder(
        builder: (context) => MaterialApp(
          title: 'app.title'.tr(),
          locale: context.locale,
          supportedLocales: context.supportedLocales,
          localizationsDelegates: context.localizationDelegates,
          theme: ThemeData(colorSchemeSeed: Colors.indigo, useMaterial3: true),
          home: BlocProvider(
            create: (_) => serviceLocator<AppBloc>()..add(const DashboardRequested()),
            child: const DashboardPage(),
          ),
        ),
      ),
    );
  }
}

/// Pantalla principal que organiza navegación y estado del dashboard.
///
/// Depende únicamente de [AppBloc] y entidades de dominio. No instancia servicios
/// ni repositorios, por lo que respeta la dirección de dependencias.
class DashboardPage extends StatefulWidget {
  /// Crea la pantalla principal.
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  var _index = 0;
  var _permissionRequested = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('app.title'.tr())),
      body: BlocConsumer<AppBloc, AppState>(
        listener: (context, state) {
          if (state is MutationSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is AppLoading) return const _LoadingView();
          if (state is AppFailure) return _ErrorView(message: state.message);
          if (state is DashboardSuccess) {
            return IndexedStack(
              index: _index,
              children: [
                _UsersTab(users: state.users),
                _PostsTab(posts: state.posts),
                _FormsTab(onPermissionPressed: _requestContactsPermission),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (value) => setState(() => _index = value),
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.people), label: 'nav.users'.tr()),
          BottomNavigationBarItem(icon: const Icon(Icons.article), label: 'nav.posts'.tr()),
          BottomNavigationBarItem(icon: const Icon(Icons.edit), label: 'nav.forms'.tr()),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.read<AppBloc>().add(const DashboardRequested()),
        icon: const Icon(Icons.refresh),
        label: Text('actions.refresh'.tr()),
      ),
    );
  }

  /// Solicita permisos con Permission Handler desde presentación.
  ///
  /// En una app real, esta interacción podría envolverse en un servicio de
  /// plataforma, pero aquí se muestra explícitamente la dependencia solicitada.
  Future<void> _requestContactsPermission() async {
    final status = await Permission.contacts.request();
    if (!mounted || _permissionRequested) return;
    _permissionRequested = true;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(status.isGranted ? 'permissions.granted'.tr() : 'permissions.denied'.tr())),
    );
  }
}

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset('assets/lottie/loading.json', width: 120, repeat: true),
          const SizedBox(height: 16),
          Text('states.loading'.tr()),
        ],
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () => context.read<AppBloc>().add(const DashboardRequested()),
              child: Text('actions.retry'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}

class _UsersTab extends StatelessWidget {
  final List<User> users;
  const _UsersTab({required this.users});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(16),
          ),
          child: ListTile(
            leading: CircleAvatar(child: Text(user.name.characters.first.toUpperCase())),
            title: Text(user.name),
            subtitle: Text(user.email),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => UserDetailPage(user: user)),
            ),
          ),
        );
      },
    );
  }
}

class _PostsTab extends StatelessWidget {
  final List<Post> posts;
  const _PostsTab({required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text(post.title),
            subtitle: Text(post.body, maxLines: 2, overflow: TextOverflow.ellipsis),
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => PostDetailPage(post: post)),
            ),
          ),
        );
      },
    );
  }
}

class _FormsTab extends StatelessWidget {
  final VoidCallback onPermissionPressed;
  const _FormsTab({required this.onPermissionPressed});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        UserForm(onSubmit: (name, email) => context.read<AppBloc>().add(UserSubmitted(name: name, email: email))),
        const SizedBox(height: 24),
        PostForm(onSubmit: (userId, title, body) => context.read<AppBloc>().add(PostSubmitted(userId: userId, title: title, body: body))),
        const SizedBox(height: 24),
        OutlinedButton.icon(
          onPressed: onPermissionPressed,
          icon: const Icon(Icons.lock_open),
          label: Text('permissions.contacts'.tr()),
        ),
      ],
    );
  }
}

/// Pantalla de detalle de usuario abierta con Navigator.
class UserDetailPage extends StatelessWidget {
  /// Usuario de dominio recibido desde la lista.
  final User user;

  /// Crea el detalle de usuario.
  const UserDetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.name)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Text('${user.email}\nID: ${user.id}', style: Theme.of(context).textTheme.headlineSmall),
      ),
    );
  }
}

/// Pantalla de detalle de publicación abierta con Navigator.
class PostDetailPage extends StatelessWidget {
  /// Publicación de dominio recibida desde la lista.
  final Post post;

  /// Crea el detalle de publicación.
  const PostDetailPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(post.title)),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(post.body, style: Theme.of(context).textTheme.bodyLarge),
      ),
    );
  }
}
