import 'package:flutter/material.dart';
import 'package:noctambuls/features/settings/presentation/widgets/language_selector.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settingsTitle),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Divider(),
            LanguageSelector(l10n: l10n),
          ],
        ),
      ),
    );
  }
}
