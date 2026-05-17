import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/features/settings/presentation/bloc/notification_settings_bloc.dart';
import 'package:noctambuls/features/settings/presentation/bloc/notification_settings_event.dart';
import 'package:noctambuls/features/settings/presentation/bloc/notification_settings_state.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class NotificationSelector extends StatefulWidget {
  const NotificationSelector({super.key});

  @override
  State<NotificationSelector> createState() => _NotificationSelectorState();
}

class _NotificationSelectorState extends State<NotificationSelector>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<NotificationSettingsBloc>().add(
      const NotificationPermissionCheckRequested(),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<NotificationSettingsBloc>().add(
        const NotificationPermissionCheckRequested(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<NotificationSettingsBloc, NotificationSettingsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.md,
            vertical: AppDimensions.sm,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    state.isEnabled
                        ? Icons.notifications_active_outlined
                        : Icons.notifications_off_outlined,
                    color: colorScheme.secondary,
                  ),
                  const SizedBox(width: AppDimensions.md),
                  Text(
                    l10n.settingsNotifications,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              Switch(
                value: state.isEnabled,
                onChanged: (value) {
                  context.read<NotificationSettingsBloc>().add(
                    ToggleNotificationsRequested(isEnabled: value),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
