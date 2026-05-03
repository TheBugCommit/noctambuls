import 'package:flutter/material.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    required this.photoUrl,
    required this.radius,
    super.key,
  });

  final String? photoUrl;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return CircleAvatar(
      radius: radius,
      backgroundColor: theme.colorScheme.surfaceContainerHigh,
      backgroundImage: photoUrl != null ? NetworkImage(photoUrl!) : null,
      child: photoUrl == null
          ? Icon(
              Icons.person,
              size: radius,
              color: theme.colorScheme.onSurfaceVariant,
            )
          : null,
    );
  }
}
