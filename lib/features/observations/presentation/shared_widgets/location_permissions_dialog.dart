import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/presentation/bloc/phone_settings/phone_settings_bloc.dart';
import 'package:noctambuls/core/presentation/bloc/phone_settings/phone_settings_event.dart';
import 'package:noctambuls/core/presentation/widgets/app_dialog.dart';
import 'package:noctambuls/features/observations/domain/enums/location_error_type.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class LocationPermissionsDialog {
  static Future<void> showLocationErrorDialog(
    BuildContext context,
    LocationErrorType errorType,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final isGpsOff = errorType == LocationErrorType.gpsDisabled;

    final title = isGpsOff
        ? l10n.locationGpsOffTitle
        : l10n.locationPermissionTitle;
    final content = isGpsOff
        ? l10n.locationGpsOffContent
        : l10n.locationPermissionContent;

    // Utilitzem el nou AppDialog súper net
    final shouldOpenSettings = await AppDialog.showConfirm(
      context: context,
      title: title,
      message: content,
      // Hi posem una icona d'avís ben maca!
      icon: isGpsOff ? Icons.location_off_outlined : Icons.gpp_maybe_outlined,
      iconColor: Theme.of(context).colorScheme.error,
      // Icona en vermell/error
      confirmText: l10n.actionOpenSettings,
      cancelText: l10n.actionLater,
    );

    if (!context.mounted) return;

    if (shouldOpenSettings == true) {
      if (isGpsOff) {
        context.read<PhoneSettingsBloc>().add(
          const OpenLocationSettingsRequested(),
        );
      } else {
        context.read<PhoneSettingsBloc>().add(
          const OpenAppSettingsRequested(),
        );
      }
    }
  }
}
