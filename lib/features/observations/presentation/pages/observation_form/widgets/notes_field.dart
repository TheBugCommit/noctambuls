import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/constants/env_config.dart';
import 'package:noctambuls/core/presentation/bloc/url/url_bloc.dart';
import 'package:noctambuls/core/presentation/bloc/url/url_event.dart';
import 'package:noctambuls/core/presentation/widgets/app_text_field.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class NotesField extends StatelessWidget {
  const NotesField({
    required this.controller,
    this.enabled = true,
    super.key,
  });

  final TextEditingController controller;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.notesLabel,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: AppDimensions.sm),

        AppTextField(
          controller: controller,
          hintText: l10n.notesHint,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          maxLines: 50,
          minLines: 3,
          enabled: enabled,
        ),
        const SizedBox(height: AppDimensions.sm),

        _ContactHint(l10n: l10n, theme: theme),
      ],
    );
  }
}

class _ContactHint extends StatelessWidget {
  const _ContactHint({required this.l10n, required this.theme});

  final AppLocalizations l10n;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    final mutedColor = theme.colorScheme.onSurfaceVariant;
    final baseStyle = theme.textTheme.bodySmall?.copyWith(color: mutedColor);
    final linkStyle = baseStyle?.copyWith(
      color: theme.colorScheme.primary,
      decoration: TextDecoration.underline,
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.tertiary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            l10n.notesContactHintIntro,
            style: baseStyle,
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  text: EnvConfig.supportEmail,
                  style: linkStyle,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.read<UrlBloc>().add(
                        const OpenUrlRequested(
                          'mailto:${EnvConfig.supportEmail}',
                        ),
                      );
                    },
                ),
              ),
              Text.rich(
                TextSpan(
                  text: EnvConfig.supportPhone,
                  style: linkStyle,
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      context.read<UrlBloc>().add(
                        const OpenUrlRequested(
                          'https://wa.me/${EnvConfig.supportPhone}',
                        ),
                      );
                    },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
