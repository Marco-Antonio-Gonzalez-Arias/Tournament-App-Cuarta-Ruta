import 'package:flutter/material.dart';

class EmptyTournamentsWidget extends StatelessWidget {
  const EmptyTournamentsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "No hay torneos guardados",
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
