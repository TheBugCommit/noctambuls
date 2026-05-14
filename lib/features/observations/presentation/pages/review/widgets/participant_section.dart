import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_deeplinks.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/constants/app_routes.dart';
import 'package:noctambuls/features/observations/presentation/pages/review/qr_scanner_page.dart';
import 'package:noctambuls/features/observations/presentation/pages/review/widgets/adaptative_manual_code.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class ParticipantsSection extends StatelessWidget {
  const ParticipantsSection({
    required this.participants,
    required this.onAddParticipant,
    required this.onRemoveParticipant,
    required this.isReadOnly,
    super.key,
  });

  final List<String> participants;
  final ValueChanged<String> onAddParticipant;
  final ValueChanged<String> onRemoveParticipant;
  final bool isReadOnly;

  Future<void> _openScanner(BuildContext context) async {
    if (isReadOnly) return;

    final l10n = AppLocalizations.of(context)!;

    final code = await context.push<String>(
      AppRoutes.qrScanner,
      extra: QrScannerArgs(
        title: l10n.scannerTitle,
        helperText: l10n.scannerHelperText,
        manualEntryModalBuilder: (context) => const AdaptiveManualCodeModal(),
        validator: (rawValue) {
          final sanitizedValue = rawValue.replaceAll('#', '%23');
          final uri = Uri.tryParse(sanitizedValue);
          if (uri == null || !AppDeepLinks.isValidDeepLink(uri)) return null;
          return AppDeepLinks.extractParticipantCode(uri);
        },
      ),
    );

    if (!context.mounted) return;

    if (code != null && code.trim().isNotEmpty) {
      if (!participants.contains(code)) {
        onAddParticipant(code);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.participantAlreadyAdded),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.participantsTitle,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (!isReadOnly)
              TextButton.icon(
                onPressed: () => _openScanner(context),
                icon: const Icon(Icons.person_add_alt_1),
                label: Text(l10n.addParticipant),
              ),
          ],
        ),

        _ParticipantChipList(
          participants: participants,
          isReadOnly: isReadOnly,
          onRemoveParticipant: onRemoveParticipant,
        ),
      ],
    );
  }
}

class _ParticipantChipList extends StatelessWidget {
  const _ParticipantChipList({
    required this.participants,
    required this.isReadOnly,
    required this.onRemoveParticipant,
  });

  final List<String> participants;
  final bool isReadOnly;
  final ValueChanged<String> onRemoveParticipant;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    if (participants.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: AppDimensions.xs),
        child: Text(
          l10n.noParticipantsAdded,
          style: TextStyle(color: theme.colorScheme.onSurfaceVariant),
        ),
      );
    }

    return Wrap(
      spacing: AppDimensions.sm,
      runSpacing: AppDimensions.xs,
      children: participants.map((code) {
        return InputChip(
          label: Text(
            code,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          deleteIcon: isReadOnly
              ? null
              : const Icon(Icons.close_outlined, size: AppDimensions.iconSm),
          onDeleted: isReadOnly ? null : () => onRemoveParticipant(code),
          backgroundColor: theme.colorScheme.secondaryContainer,
          labelStyle: TextStyle(
            color: theme.colorScheme.onSecondaryContainer,
          ),
          isEnabled: !isReadOnly,
        );
      }).toList(),
    );
  }
}
