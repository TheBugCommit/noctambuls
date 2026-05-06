import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/constants/app_routes.dart';
import 'package:noctambuls/core/presentation/widgets/app_button.dart';
import 'package:noctambuls/core/presentation/widgets/bottom_nav_bar.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_state.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_review_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_review_event.dart';
import 'package:noctambuls/features/observations/presentation/pages/observation_form/observation_form_page.dart';
import 'package:noctambuls/features/observations/presentation/pages/observing/widgets/empty_observations.dart';
import 'package:noctambuls/features/observations/presentation/pages/observing/widgets/observation_card.dart';
import 'package:noctambuls/features/observations/presentation/pages/review/widgets/listening_point_field.dart';
import 'package:noctambuls/features/observations/presentation/pages/review/widgets/review_header.dart';
import 'package:noctambuls/features/observations/presentation/pages/review/widgets/review_meteo_section.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class ReviewContent extends StatelessWidget {
  const ReviewContent({
    required this.session,
    required this.isReadOnly,
    required this.showValidationErrors,
    required this.listeningPointController,
    required this.onDelete,
    required this.onFinalize,
    super.key,
  });

  final ObservationSession session;
  final bool isReadOnly;
  final bool showValidationErrors;
  final TextEditingController listeningPointController;
  final void Function(BuildContext) onDelete;
  final void Function(BuildContext) onFinalize;

  bool get _needsListeningPoint =>
      session.sessionType == SessionType.census ||
      session.sessionType == SessionType.station;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final canPop = context.canPop();

    return Scaffold(
      appBar: AppBar(
        leading: canPop
            ? BackButton(onPressed: () => context.pop())
            : IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => context.go(AppRoutes.home),
              ),
        title: Text(l10n.reviewTitle),
        actions: [
          Icon(isReadOnly ? Icons.lock_outline : Icons.edit_outlined),
          const SizedBox(width: AppDimensions.md),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppDimensions.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ReviewHeader(session: session),
                  const SizedBox(height: AppDimensions.xl),

                  ReviewMeteoSection(session: session, isReadOnly: isReadOnly),

                  if (_needsListeningPoint) ...[
                    ListeningPointField(
                      controller: listeningPointController,
                      isReadOnly: isReadOnly,
                      hasError:
                          showValidationErrors &&
                          session.listeningPoint == null,
                      onChanged: (val) {
                        final parsed = int.tryParse(val);
                        context.read<SessionReviewBloc>().add(
                          ReviewUpdateProperties(listeningPoint: parsed),
                        );
                      },
                    ),
                    const SizedBox(height: AppDimensions.md),
                  ],

                  const Divider(height: AppDimensions.xxl),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        l10n.reviewObservationsTitle,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      if (!isReadOnly)
                        TextButton.icon(
                          onPressed: () => context.push(
                            AppRoutes.observationForm,
                            extra: ObservationFormArgs(
                              sessionId: session.id,
                              sessionBloc: context
                                  .read<SessionObservationBloc>(),
                            ),
                          ),
                          icon: const Icon(Icons.add),
                          label: Text(l10n.reviewAddObservationBtn),
                        ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.md),
                ],
              ),
            ),
          ),

          BlocBuilder<SessionObservationBloc, SessionObservationState>(
            builder: (context, obsState) {
              if (obsState is ObservationsLoaded) {
                if (obsState.observations.isEmpty) {
                  return const SliverToBoxAdapter(child: EmptyObservations());
                }
                return SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.lg,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final record = obsState.observations[index];
                        final bird = obsState.birdsMap[record.speciesId];
                        if (bird == null) return const SizedBox.shrink();
                        return ObservationCard(record: record, bird: bird);
                      },
                      childCount: obsState.observations.length,
                    ),
                  ),
                );
              }
              return const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              );
            },
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
      bottomNavigationBar: isReadOnly
          ? null
          : BottomNavBar(
              child: Row(
                children: [
                  AppButton.destructiveSoft(
                    icon: Icons.delete_outline,
                    onPressed: () => onDelete(context),
                  ),
                  const Spacer(),
                  AppButton(
                    label: l10n.reviewFinalizeBtn,
                    icon: Icons.send_outlined,
                    onPressed: () => onFinalize(context),
                  ),
                ],
              ),
            ),
    );
  }
}
