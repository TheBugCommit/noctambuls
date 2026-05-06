import 'package:flutter/material.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

extension SessionTypeExtension on SessionType {
  IconData icon() {
    return switch (this) {
      SessionType.census => Icons.groups_outlined,
      SessionType.station => Icons.person_pin_circle_outlined,
      SessionType.incidental => Icons.visibility_outlined,
    };
  }

  String name(AppLocalizations l10n) {
    return switch (this) {
      SessionType.census => l10n.censusLabel,
      SessionType.station => l10n.stationLabel,
      SessionType.incidental => l10n.incidentalLabel,
    };
  }
}
