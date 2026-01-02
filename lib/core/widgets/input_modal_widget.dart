import 'package:flutter/material.dart';

class InputModalWidget extends StatefulWidget {
  final String title;
  final String hint;
  final double? titleFontSize;
  final double? hintFontSize;

  const InputModalWidget({
    super.key,
    required this.title,
    this.hint = "Escribe aquí...",
    this.titleFontSize,
    this.hintFontSize,
  });

  @override
  State<InputModalWidget> createState() => _InputModalWidgetState();
}

class _InputModalWidgetState extends State<InputModalWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      backgroundColor: theme.colorScheme.surface,
      title: _buildTitle(theme),
      content: _buildTextField(theme),
      actions: _buildActions(context, theme),
    );
  }

  Widget _buildTitle(ThemeData theme) =>
      Text(widget.title, style: _getTitleStyle(theme));

  Widget _buildTextField(ThemeData theme) => TextField(
    controller: _controller,
    autofocus: true,
    style: theme.textTheme.bodySmall,
    decoration: InputDecoration(
      hintText: widget.hint,
      hintStyle: _getHintStyle(theme),
    ),
  );

  TextStyle? _getTitleStyle(ThemeData theme) =>
      theme.textTheme.bodySmall?.copyWith(fontSize: widget.titleFontSize);

  TextStyle? _getHintStyle(ThemeData theme) =>
      theme.textTheme.labelLarge?.copyWith(
        fontSize: widget.hintFontSize,
        color: theme.colorScheme.onSurface.withAlpha(50),
      );

  List<Widget> _buildActions(BuildContext context, ThemeData theme) => [
    TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text('Cancelar', style: theme.textTheme.bodySmall),
    ),
    TextButton(
      onPressed: () => _handleConfirm(context),
      child: Text(
        'Guardar',
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.primary,
        ),
      ),
    ),
  ];

  void _handleConfirm(BuildContext context) {
    final text = _controller.text.trim();
    if (text.isNotEmpty) Navigator.pop(context, text);
  }
}
