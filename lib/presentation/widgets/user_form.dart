import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// Formulario reutilizable para crear usuarios.
///
/// Es un widget puro de presentación: valida entradas visuales y delega la
/// intención mediante [onSubmit]. El BLoC y los casos de uso aplican las reglas
/// de negocio definitivas.
class UserForm extends StatefulWidget {
  /// Callback que comunica la intención de crear usuario al contenedor.
  final void Function(String name, String email) onSubmit;

  /// Crea el formulario de usuario.
  const UserForm({super.key, required this.onSubmit});

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('forms.userTitle'.tr(), style: Theme.of(context).textTheme.titleLarge),
          TextFormField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'forms.name'.tr()),
            validator: (value) => (value == null || value.trim().isEmpty) ? 'forms.required'.tr() : null,
          ),
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(labelText: 'forms.email'.tr()),
            keyboardType: TextInputType.emailAddress,
            validator: (value) => (value == null || !value.contains('@')) ? 'forms.emailError'.tr() : null,
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                widget.onSubmit(_nameController.text, _emailController.text);
              }
            },
            child: Text('actions.createUser'.tr()),
          ),
        ],
      ),
    );
  }
}
