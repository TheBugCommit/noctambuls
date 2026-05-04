import 'package:flutter/material.dart';

class BirdCommonName extends StatelessWidget {
  const BirdCommonName({
    required this.commonName,
    this.style,
    super.key,
  });

  final String commonName;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Text(
      commonName,
      style:
          style ??
          theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
    );
  }
}
