import 'package:flutter/material.dart';

class SettingsLinkTile extends StatelessWidget {
  const SettingsLinkTile({
    required this.icon,
    required this.title,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, size: 20),
      iconColor: Theme.of(context).colorScheme.secondary,
      onTap: onTap,
    );
  }
}
