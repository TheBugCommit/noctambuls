import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/constants/env_config.dart';
import 'package:noctambuls/core/presentation/bloc/url/url_bloc.dart';
import 'package:noctambuls/core/presentation/bloc/url/url_event.dart';
import 'package:noctambuls/features/settings/presentation/pages/widgets/section_title.dart';
import 'package:noctambuls/features/settings/presentation/pages/widgets/settings_card.dart';
import 'package:noctambuls/features/settings/presentation/pages/widgets/settings_link_tile.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class LegalSection extends StatelessWidget {
  const LegalSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: l10n.settingsLegalTitle),
        SettingsCard(
          children: [
            SettingsLinkTile(
              icon: Icons.privacy_tip_outlined,
              title: l10n.settingsPrivacyPolicy,
              onTap: () => context.read<UrlBloc>().add(
                const OpenUrlRequested(EnvConfig.privacyUrl),
              ),
            ),
            const Divider(
              height: 1,
              indent: AppDimensions.md,
              endIndent: AppDimensions.md,
            ),
            SettingsLinkTile(
              icon: Icons.description_outlined,
              title: l10n.settingsTermsOfUse,
              onTap: () => context.read<UrlBloc>().add(
                const OpenUrlRequested(EnvConfig.termsAndConditionsUrl),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
