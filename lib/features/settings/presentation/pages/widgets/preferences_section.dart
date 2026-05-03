import 'package:flutter/material.dart';
import 'package:noctambuls/features/settings/presentation/pages/widgets/section_title.dart';
import 'package:noctambuls/features/settings/presentation/pages/widgets/settings_card.dart';
import 'package:noctambuls/features/settings/presentation/widgets/language_selector.dart';
import 'package:noctambuls/features/settings/presentation/widgets/theme_selector.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class PreferencesSection extends StatelessWidget {
  const PreferencesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: l10n.settingsPreferencesTitle),
        const SettingsCard(
          children: [
            LanguageSelector(),
            Divider(height: 1),
            ThemeSelector(),
          ],
        ),
      ],
    );
  }
}
