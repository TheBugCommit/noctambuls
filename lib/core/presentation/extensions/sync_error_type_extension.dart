import 'package:noctambuls/features/observations/domain/enums/sync_error_type.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

extension SyncErrorTypeExtension on SyncErrorType {
  String errorMessage(AppLocalizations l10n) {
    return switch (this) {
      SyncErrorType.validation => l10n.syncErrorValidation,
      SyncErrorType.network => l10n.syncErrorNetwork,
      SyncErrorType.server => l10n.syncErrorServer,
      SyncErrorType.unknown => l10n.syncErrorUnknown,
    };
  }
}
