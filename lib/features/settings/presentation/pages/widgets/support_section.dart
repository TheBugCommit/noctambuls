import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/constants/env_config.dart';
import 'package:noctambuls/core/presentation/bloc/share/share_bloc.dart';
import 'package:noctambuls/core/presentation/bloc/share/share_event.dart';
import 'package:noctambuls/core/presentation/bloc/url/url_bloc.dart';
import 'package:noctambuls/core/presentation/bloc/url/url_event.dart';
import 'package:noctambuls/features/settings/presentation/pages/widgets/section_title.dart';
import 'package:noctambuls/features/settings/presentation/pages/widgets/settings_card.dart';
import 'package:noctambuls/features/settings/presentation/pages/widgets/settings_link_tile.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class SupportSection extends StatelessWidget {
  const SupportSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: l10n.settingsSupportTitle),
        SettingsCard(
          children: [
            SettingsLinkTile(
              icon: Icons.help_outline,
              title: l10n.settingsHelp,
              onTap: () => context.read<UrlBloc>().add(
                const OpenUrlRequested(EnvConfig.helpUrl),
              ),
            ),
            const Divider(
              height: 1,
              indent: AppDimensions.md,
              endIndent: AppDimensions.md,
            ),
            SettingsLinkTile(
              icon: Icons.info_outline,
              title: l10n.settingsAbout,
              onTap: () => context.read<UrlBloc>().add(
                const OpenUrlRequested(EnvConfig.aboutUrl),
              ),
            ),
            const Divider(
              height: 1,
              indent: AppDimensions.md,
              endIndent: AppDimensions.md,
            ),
            SettingsLinkTile(
              icon: Icons.share,
              title: l10n.settingsTellAFriend,
              onTap: () {
                context.read<ShareBloc>().add(
                  ShareTextRequested(text: l10n.settingsTellAFriendText),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
