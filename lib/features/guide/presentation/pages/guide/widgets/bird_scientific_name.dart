import 'package:flutter/material.dart';

class BirdScientificName extends StatelessWidget {
  const BirdScientificName({
    required this.scientificName,
    super.key,
  });

  final String scientificName;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      scientificName,
      style: theme.textTheme.bodySmall?.copyWith(
        fontStyle: FontStyle.italic,
        color: theme.colorScheme.onSurfaceVariant,
      ),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
