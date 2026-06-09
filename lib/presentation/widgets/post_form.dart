import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

/// Formulario reutilizable para crear publicaciones.
///
/// Captura datos de UI con `Form` y `TextFormField`, pero no conoce repositorios.
/// Su callback se transforma en evento BLoC desde la página contenedora.
class PostForm extends StatefulWidget {
  /// Callback de creación comunicado a la página.
  final void Function(int userId, String title, String body) onSubmit;

  /// Crea el formulario de publicación.
  const PostForm({super.key, required this.onSubmit});

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  final _formKey = GlobalKey<FormState>();
  final _userIdController = TextEditingController(text: '1');
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  void dispose() {
    _userIdController.dispose();
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('forms.postTitle'.tr(), style: Theme.of(context).textTheme.titleLarge),
          TextFormField(
            controller: _userIdController,
            decoration: InputDecoration(labelText: 'forms.userId'.tr()),
            keyboardType: TextInputType.number,
            validator: (value) => int.tryParse(value ?? '') == null ? 'forms.numberError'.tr() : null,
          ),
          TextFormField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'forms.title'.tr()),
            validator: (value) => (value == null || value.trim().isEmpty) ? 'forms.required'.tr() : null,
          ),
          TextFormField(
            controller: _bodyController,
            decoration: InputDecoration(labelText: 'forms.body'.tr()),
            minLines: 2,
            maxLines: 4,
            validator: (value) => (value == null || value.trim().length < 10) ? 'forms.bodyError'.tr() : null,
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                widget.onSubmit(int.parse(_userIdController.text), _titleController.text, _bodyController.text);
              }
            },
            child: Text('actions.createPost'.tr()),
          ),
        ],
      ),
    );
  }
}
