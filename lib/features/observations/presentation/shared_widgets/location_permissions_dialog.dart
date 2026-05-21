import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/presentation/bloc/phone_settings/phone_settings_bloc.dart';
import 'package:noctambuls/core/presentation/bloc/phone_settings/phone_settings_event.dart';
import 'package:noctambuls/core/presentation/widgets/app_dialog.dart';
import 'package:noctambuls/features/observations/domain/enums/location_error_type.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class LocationPermissionsDialog {
  static bool _isShowing = false;

  static Future<void> showLocationErrorDialog(
    BuildContext context,
    LocationErrorType errorType,
  ) async {
    if (_isShowing) return;
    _isShowing = true;

    try {
      final l10n = AppLocalizations.of(context)!;
      final isGpsOff = errorType == LocationErrorType.gpsDisabled;

      final title = isGpsOff
          ? l10n.locationGpsOffTitle
          : l10n.locationPermissionTitle;
      final content = isGpsOff
          ? l10n.locationGpsOffContent
          : l10n.locationPermissionContent;

      final shouldOpenSettings = await AppDialog.showConfirm(
        context: context,
        title: title,
        message: content,
        icon: isGpsOff ? Icons.location_off_outlined : Icons.gpp_maybe_outlined,
        iconColor: Theme.of(context).colorScheme.error,
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
    } finally {
      _isShowing = false;
    }
  }
}
