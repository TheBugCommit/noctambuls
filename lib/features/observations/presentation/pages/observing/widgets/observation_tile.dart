import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/constants/app_routes.dart';
import 'package:noctambuls/core/presentation/widgets/app_sheet.dart';
import 'package:noctambuls/core/presentation/widgets/time_text.dart';
import 'package:noctambuls/features/guide/domain/entities/bird.dart';
import 'package:noctambuls/features/guide/presentation/pages/guide/widgets/bird_common_name.dart';
import 'package:noctambuls/features/guide/presentation/pages/guide/widgets/bird_image.dart';
import 'package:noctambuls/features/guide/presentation/pages/guide/widgets/bird_scientific_name.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_event.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/observation_form_page.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class ObservationTile extends StatelessWidget {
  const ObservationTile({
    required this.record,
    required this.bird,
    super.key,
  });

  final ObservationRecord record;
  final Bird bird;

  Future<void> _confirmAndDelete(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await AppSheet.showConfirm(
      context: context,
      title: l10n.confirmDeleteObservationTitle,
      message: l10n.confirmDeleteObservationMessage,
      confirmText: l10n.confirmDelete,
      cancelText: l10n.cancel,
      isDestructive: true,
    );

    if (!context.mounted) return;

    if (confirmed == true) {
      context.read<SessionObservationBloc>().add(DeleteRecord(record.id));
    }
  }

  void _openEdit(BuildContext context) {
    unawaited(
      context.push(
        AppRoutes.observationForm,
        extra: ObservationFormArgs(
          sessionId: record.sessionId,
          sessionBloc: context.read<SessionObservationBloc>(),
          existingRecord: record,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: AppDimensions.sm),
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      ),
      elevation: 1,
      child: Slidable(
        key: ValueKey(record.id),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          extentRatio: 0.25,
          children: [
            CustomSlidableAction(
              onPressed: (context) {
                context.read<SessionObservationBloc>().add(
                  DeleteRecord(record.id),
                );
              },
              backgroundColor: colorScheme.errorContainer,
              foregroundColor: colorScheme.onErrorContainer,
              child: const Icon(
                Icons.delete_outline,
                size: AppDimensions.iconMd,
              ),
            ),
          ],
        ),
        child: Material(
          color: colorScheme.surfaceContainerLow,
          child: InkWell(
            onTap: () => _openEdit(context),
            onLongPress: () => _confirmAndDelete(context),
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.sm),
              child: Row(
                children: [
                  _BirdThumbnail(bird: bird),
                  const SizedBox(width: AppDimensions.md),
                  Expanded(
                    child: _ObservationDetails(record: record, bird: bird),
                  ),
                  _ObservationTrailing(record: record),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _ObservationDetails extends StatelessWidget {
  const _ObservationDetails({required this.record, required this.bird});

  final ObservationRecord record;
  final Bird bird;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BirdCommonName(commonName: bird.commonName),
        BirdScientificName(scientificName: bird.scientificName),
        const SizedBox(height: AppDimensions.xs),
        Row(
          children: [
            Icon(
              Icons.access_time,
              size: AppDimensions.iconXs,
              color: colorScheme.secondary,
            ),
            const SizedBox(width: AppDimensions.xs),
            TimeText.dateTime(
              record.startTime,
              formatStyle: DateTimeFormatStyle.timeOnly,
            ),
          ],
        ),
      ],
    );
  }
}

class _ObservationTrailing extends StatelessWidget {
  const _ObservationTrailing({required this.record});

  final ObservationRecord record;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.sm,
            vertical: AppDimensions.xs,
          ),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          ),
          child: Text(
            'x${record.quantity}',
            style: textTheme.labelLarge?.copyWith(
              color: colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

class _BirdThumbnail extends StatelessWidget {
  const _BirdThumbnail({
    required this.bird,
    this.size = 60.0,
  });

  final Bird bird;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
        child: BirdImage(
          bird: bird,
          cacheWidth: (size * 2).toInt(),
        ),
      ),
    );
  }
}
