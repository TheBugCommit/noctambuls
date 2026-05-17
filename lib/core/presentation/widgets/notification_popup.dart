import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart'; // 👇 Nou import
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/presentation/bloc/notification_inbox/notification_inbox_bloc.dart';
import 'package:noctambuls/core/presentation/widgets/app_button.dart';
import 'package:noctambuls/core/presentation/widgets/app_dialog.dart';
import 'package:noctambuls/core/presentation/widgets/time_text.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class NotificationPopup extends StatelessWidget {
  const NotificationPopup({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<NotificationInboxBloc, NotificationInboxState>(
      builder: (context, state) {
        return AppDialog(
          title: l10n.notificationsTitle,
          primaryButton: AppButton.primary(
            label: l10n.notificationsClose,
            onPressed: () => context.pop(),
          ),
          secondaryButton: state.notifications.isNotEmpty
              ? TextButton(
                  onPressed: () => context.read<NotificationInboxBloc>().add(
                    const NotificationInboxCleared(),
                  ),
                  child: Text(
                    l10n.notificationsClearAll,
                    style: TextStyle(color: colorScheme.error),
                  ),
                )
              : null,
          content: SizedBox(
            width: double.maxFinite,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
              child: state.notifications.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppDimensions.xl,
                      ),
                      child: Center(
                        child: Text(
                          l10n.notificationsEmpty,
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                    )
                  : Padding(
                      // 2. Afegim un marge lateral perquè el text i el Slidable no toquin la vora física
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.sm,
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.notifications.length,
                        separatorBuilder: (_, _) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final n = state.notifications[index];

                          return Slidable(
                            key: ValueKey(n.id),
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              extentRatio: 0.25,
                              children: [
                                SlidableAction(
                                  onPressed: (context) {
                                    context.read<NotificationInboxBloc>().add(
                                      NotificationInboxDeleted(n.id),
                                    );
                                  },
                                  backgroundColor: colorScheme.error,
                                  foregroundColor: colorScheme.onError,
                                  icon: Icons.delete,
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(
                                      AppDimensions.radiusSm,
                                    ),
                                    bottomRight: Radius.circular(
                                      AppDimensions.radiusSm,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            child: ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                n.title,
                                style: textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    n.body,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: AppDimensions.xs),
                                  TimeText.dateTime(
                                    n.receivedAt,
                                    style: textTheme.labelSmall?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                              isThreeLine: true,
                            ),
                          );
                        },
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
