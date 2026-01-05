import 'package:flutter/material.dart';
import 'package:cuarta_ruta_app/core/utils/responsive_util.dart';

class ConfirmModalWidget extends StatelessWidget {
  final String title;
  final String message;
  final String confirmLabel;

  const ConfirmModalWidget({
    super.key,
    required this.title,
    required this.message,
    this.confirmLabel = 'Eliminar',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      backgroundColor: theme.colorScheme.surface,
      title: Text(title, style: theme.textTheme.bodySmall),
      content: SizedBox(
        width: context.res.wp(80),
        child: Text(message, style: theme.textTheme.labelLarge),
      ),
      actions: _buildActions(context, theme),
    );
  }

  List<Widget> _buildActions(BuildContext context, ThemeData theme) => [
    TextButton(
      onPressed: () => Navigator.pop(context, false),
      child: Text('Cancelar', style: theme.textTheme.bodySmall),
    ),
    TextButton(
      onPressed: () => Navigator.pop(context, true),
      child: Text(
        confirmLabel,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.error,
        ),
      ),
    ),
  ];
}
