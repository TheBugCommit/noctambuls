import 'package:flutter/material.dart';

class FormattedProfileName extends StatelessWidget {
  const FormattedProfileName({
    required this.fullName,
    this.style,
    this.maxLines = 1,
    this.overflow = TextOverflow.ellipsis,
    super.key,
  });

  final String fullName;
  final TextStyle? style;
  final int maxLines;
  final TextOverflow overflow;

  String _formatName(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || parts[0].isEmpty) return name;

    final firstName = parts[0];
    if (parts.length == 1) return firstName;

    final initials = parts
        .skip(1)
        .take(2)
        .map((word) => '${word[0].toUpperCase()}.')
        .join();

    return '$firstName $initials';
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _formatName(fullName),
      style:
          style ??
          Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
