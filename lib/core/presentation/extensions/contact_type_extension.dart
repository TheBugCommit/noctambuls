import 'package:noctambuls/features/observations/domain/enums/contact_type.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

extension ContactTypeExtension on ContactType {
  String label(AppLocalizations l10n) {
    switch (this) {
      case ContactType.visual:
        return l10n.visualContactType;
      case ContactType.auditive:
        return l10n.auditiveContactType;
    }
  }
}
