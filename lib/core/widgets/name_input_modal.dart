import 'package:flutter/material.dart';

class NameInputModal extends StatelessWidget {
  final String title;
  final String hint;

  const NameInputModal({
    super.key,
    required this.title,
    this.hint = "Nombre...",
  });

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final theme = Theme.of(context);

    return AlertDialog(
      backgroundColor: theme.colorScheme.surface,
      title: Text(title, style: theme.textTheme.titleSmall),
      content: TextField(
        controller: controller,
        style: theme.textTheme.bodySmall,
        autofocus: true,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withAlpha(50),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Cancelar', style: theme.textTheme.bodySmall),
        ),
        TextButton(
          onPressed: () {
            final text = controller.text.trim();
            if (text.isNotEmpty) Navigator.pop(context, text);
          },
          child: Text(
            'Guardar',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}