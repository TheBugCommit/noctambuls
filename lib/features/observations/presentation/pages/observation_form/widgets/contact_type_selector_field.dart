import 'package:flutter/material.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/presentation/extensions/contact_type_extension.dart';
import 'package:noctambuls/features/observations/domain/enums/contact_type.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class ContactTypeSelectorField extends StatelessWidget {
  const ContactTypeSelectorField({
    required this.selectedContactType,
    required this.onChanged,
    this.isReadOnly = false,
    super.key,
  });

  final ContactType selectedContactType;
  final ValueChanged<ContactType> onChanged;
  final bool isReadOnly;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.contactTypeLabel,
          style: theme.textTheme.titleSmall?.copyWith(
            color: isReadOnly ? theme.colorScheme.onSurfaceVariant : null,
          ),
        ),
        const SizedBox(height: AppDimensions.xs),
        SizedBox(
          width: double.infinity,
          child: SegmentedButton<ContactType>(
            segments: [
              ButtonSegment(
                value: ContactType.auditive,
                label: Text(ContactType.auditive.label(l10n)),
                icon: const Icon(Icons.hearing_outlined),
              ),
              ButtonSegment(
                value: ContactType.visual,
                label: Text(ContactType.visual.label(l10n)),
                icon: const Icon(Icons.visibility_outlined),
              ),
            ],
            selected: {selectedContactType},
            onSelectionChanged: isReadOnly
                ? null
                : (newSelection) {
                    onChanged(newSelection.first);
                  },
          ),
        ),
      ],
    );
  }
}
