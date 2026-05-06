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
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_event.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/observation_form_page.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class ObservationCard extends StatefulWidget {
  const ObservationCard({
    required this.record,
    required this.bird,
    required this.session,
    super.key,
  });

  final ObservationRecord record;
  final Bird bird;
  final ObservationSession session;

  @override
  State<ObservationCard> createState() => _ObservationCardState();
}

class _ObservationCardState extends State<ObservationCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _sizeAnimation;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      value: 1,
    );

    _sizeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _animateAndDelete() async {
    await _animationController.reverse();
    if (mounted) {
      context.read<SessionObservationBloc>().add(
        DeleteRecord(widget.record.id),
      );
    }
  }

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

    if (!mounted) return;

    if (confirmed == true) {
      await _animateAndDelete();
    }
  }

  void _openEdit(BuildContext context) {
    unawaited(
      context.push(
        AppRoutes.observationForm,
        extra: ObservationFormArgs(
          session: widget.session,
          sessionBloc: context.read<SessionObservationBloc>(),
          existingRecord: widget.record,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizeTransition(
      sizeFactor: _sizeAnimation,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: Card(
          margin: const EdgeInsets.only(bottom: AppDimensions.sm),
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          ),
          elevation: 1,
          child: Slidable(
            key: ValueKey(widget.record.id),
            endActionPane: ActionPane(
              motion: const DrawerMotion(),
              extentRatio: 0.25,
              dismissible: DismissiblePane(
                onDismissed: () {
                  context.read<SessionObservationBloc>().add(
                    DeleteRecord(widget.record.id),
                  );
                },
              ),
              children: [
                CustomSlidableAction(
                  onPressed: (context) {
                    unawaited(_animateAndDelete());
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
                      _BirdThumbnail(bird: widget.bird),
                      const SizedBox(width: AppDimensions.md),
                      Expanded(
                        child: _ObservationDetails(
                          record: widget.record,
                          bird: widget.bird,
                        ),
                      ),
                      _ObservationTrailing(record: widget.record),
                    ],
                  ),
                ),
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
    final l10n = AppLocalizations.of(context)!;

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
            color: colorScheme.tertiaryContainer,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          ),
          child: Text(
            l10n.obsCardQuantityLabel(record.quantity),
            style: textTheme.labelLarge?.copyWith(
              color: colorScheme.onTertiaryContainer,
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
