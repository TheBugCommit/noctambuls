import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_deeplinks.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/constants/app_routes.dart';
import 'package:noctambuls/core/presentation/widgets/app_button_fab.dart';
import 'package:noctambuls/core/presentation/widgets/app_sheet.dart';
import 'package:noctambuls/core/presentation/widgets/taxus_app_bar.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_state.dart';
import 'package:noctambuls/features/censuses/domain/entities/census.dart';
import 'package:noctambuls/features/censuses/domain/failures/census_failures.dart';
import 'package:noctambuls/features/censuses/presentation/bloc/census_bloc.dart';
import 'package:noctambuls/features/censuses/presentation/bloc/census_event.dart';
import 'package:noctambuls/features/censuses/presentation/bloc/census_state.dart';
import 'package:noctambuls/features/censuses/presentation/widgets/census_confirmation_sheet.dart';
import 'package:noctambuls/features/censuses/presentation/widgets/census_lobby_card.dart';
import 'package:noctambuls/features/censuses/presentation/widgets/upcoming_censuses_section.dart';
import 'package:noctambuls/features/guide/presentation/bloc/catalog_sync_bloc.dart';
import 'package:noctambuls/features/guide/presentation/bloc/catalog_sync_event.dart';
import 'package:noctambuls/features/guide/presentation/bloc/catalog_sync_state.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/failures/session_failures.dart';
import 'package:noctambuls/features/observations/presentation/bloc/observing_session_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/observing_session_event.dart';
import 'package:noctambuls/features/observations/presentation/bloc/observing_session_state.dart';
import 'package:noctambuls/features/observations/presentation/pages/home/widgets/active_session_card.dart';
import 'package:noctambuls/features/observations/presentation/pages/home/widgets/home_header.dart';
import 'package:noctambuls/features/observations/presentation/pages/review/qr_scanner_page.dart';
import 'package:noctambuls/features/observations/presentation/shared_widgets/session_type_selector.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Type _getRebuildGroup(ObservingSessionState state) => switch (state) {
    ObservingSessionIdle() ||
    ObservingSessionError() ||
    ObservingSessionNavigatingToReview() => ObservingSessionIdle,
    ObservingSessionLoading() => ObservingSessionLoading,
    ObservingSessionActive() => ObservingSessionActive,
  };

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ObservingSessionBloc, ObservingSessionState>(
      listenWhen: (prev, curr) {
        if (curr is ObservingSessionError) return true;
        if (curr is ObservingSessionActive && prev is! ObservingSessionActive) {
          return true;
        }
        return false;
      },
      listener: (context, state) {
        switch (state) {
          case ObservingSessionError():
            final l10n = AppLocalizations.of(context)!;
            final message = switch (state.failure) {
              ActiveSessionAlreadyExistsFailure() =>
                l10n.errorSessionAlreadyExists,
              _ => l10n.errorUnknown,
            };
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                behavior: SnackBarBehavior.floating,
              ),
            );
            context.read<ObservingSessionBloc>().add(DismissObservingError());
          case ObservingSessionActive():
            unawaited(
              context.push(AppRoutes.observing, extra: state.session),
            );
          default:
            break;
        }
      },
      buildWhen: (prev, curr) =>
          _getRebuildGroup(prev) != _getRebuildGroup(curr),
      builder: (context, state) {
        return switch (state) {
          ObservingSessionIdle() ||
          ObservingSessionNavigatingToReview() ||
          ObservingSessionError() => _IdleScaffold(
            onTypeSelected: (type) => context.read<ObservingSessionBloc>().add(
              StartObservingSession(
                sessionType: type,
                annotatorId:
                    (context.read<AuthBloc>().state as Authenticated).user.id,
              ),
            ),
          ),
          ObservingSessionLoading() => const _LoadingScaffold(),
          ObservingSessionActive() => _ActiveScaffold(
            session: state.session,
            onResume: () => unawaited(
              context.push(AppRoutes.observing, extra: state.session),
            ),
          ),
        };
      },
    );
  }
}

class _BaseHomeLayout extends StatelessWidget {
  const _BaseHomeLayout({required this.child});

  final Widget child;

  Future<void> _handleSyncFailure(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;

    final shouldRetry = await AppSheet.showConfirm(
      context: context,
      title: l10n.homeErrorDownloadCatalog,
      message: l10n.homeErrorDownloadCatalogMsg,
      confirmText: l10n.retry,
      cancelText: l10n.ignore,
    );

    if (shouldRetry == true && context.mounted) {
      context.read<CatalogSyncBloc>().add(
        const CatalogSyncEventRequest(showGlobalError: true),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CatalogSyncBloc, CatalogSyncState>(
      listenWhen: (previous, current) {
        if (current is CatalogSyncFailure) {
          return current.isCatalogEmpty && current.showGlobalError;
        }
        return false;
      },
      listener: (context, state) async {
        if (state is CatalogSyncFailure && state.isCatalogEmpty) {
          await _handleSyncFailure(context);
        }
      },
      child: BlocListener<CensusBloc, CensusState>(
        listenWhen: (_, curr) =>
            curr is CensusJoinError || curr is CensusSessionStarted,
        listener: (context, state) {
          final l10n = AppLocalizations.of(context)!;
          switch (state) {
            case CensusJoinError(:final failure):
              final message = switch (failure) {
                CensusNotTodayFailure() => l10n.censusNotTodayBody,
                CensusJoinAlreadyHasLobbyFailure() =>
                  l10n.censusLobbyConflictBody,
                InvalidCensusTokenFailure() => l10n.censusInvalidTokenBody,
                ActiveSessionAlreadyExistsFailure() =>
                  l10n.censusAlreadySessionActive,
                CensusSessionAlreadyFinishedFailure() ||
                AlreadyCensusSessionCreatedFailure() =>
                  l10n.censusSessionExistentWarning,
                _ => l10n.errorUnknown,
              };

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(message),
                  behavior: SnackBarBehavior.floating,
                ),
              );

              context.read<CensusBloc>().add(DismissCensusError());
            case CensusSessionStarted(:final session):
              unawaited(context.push(AppRoutes.observing, extra: session));
            default:
              break;
          }
        },
        child: Scaffold(
          appBar: const TaxusAppBar(),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppDimensions.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HomeHeader(),
                  const SizedBox(height: AppDimensions.xl),
                  child,
                  const SizedBox(height: AppDimensions.lg),
                  const _CensusSection(),
                ],
              ),
            ),
          ),
          floatingActionButton: AppButtonFab.large(
            onPressed: () async {
              final l10n = AppLocalizations.of(context)!;
              final url = await context.push<String>(
                AppRoutes.qrScanner,
                extra: QrScannerArgs(
                  title: l10n.censusQrScanTitle,
                  helperText: l10n.censusQrScanHelper,
                  helpTitle: l10n.censusQrHelpTitle,
                  helpMessage: l10n.censusQrHelpBody,
                  validator: (rawValue) {
                    final uri = Uri.tryParse(rawValue);
                    if (uri != null && AppDeepLinks.isCensusDeepLink(uri)) {
                      return rawValue;
                    }
                    return null;
                  },
                ),
              );
              if (url != null && context.mounted) {
                context.read<CensusBloc>().add(JoinCensusByUrl(url));
              }
            },
            icon: Icons.qr_code_scanner,
          ),
        ),
      ),
    );
  }
}

class _CensusSection extends StatelessWidget {
  const _CensusSection();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    return BlocBuilder<ObservingSessionBloc, ObservingSessionState>(
      builder: (context, observingState) {
        final activeCensusId = observingState is ObservingSessionActive
            ? observingState.session.censusId
            : null;

        return BlocBuilder<CensusBloc, CensusState>(
          buildWhen: (prev, curr) =>
              prev is! CensusJoinError && curr is CensusLoaded,
          builder: (context, state) {
            final List<Census> censuses;
            final Census? lobbyCensus;

            switch (state) {
              case CensusLoaded():
                censuses = state.censuses;
                lobbyCensus = state.lobbyCensus;
              case CensusJoinError():
                censuses = state.censuses;
                lobbyCensus = state.lobbyCensus;
              default:
                return const SizedBox.shrink();
            }

            final isLobbyBeingObserved =
                lobbyCensus != null && lobbyCensus.id == activeCensusId;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (lobbyCensus != null &&
                    !isLobbyBeingObserved &&
                    lobbyCensus.isJoined) ...[
                  CensusLobbyCard(
                    census: lobbyCensus,
                    onEnter: () => CensusConfirmationSheet.show(context, () {
                      context.read<CensusBloc>().add(
                        StartCensusSession(
                          annotatorId:
                              (context.read<AuthBloc>().state as Authenticated)
                                  .user
                                  .id,
                          census: lobbyCensus!,
                        ),
                      );
                    }),
                    onAbandon: () => context.read<CensusBloc>().add(
                      AbandonCensus(lobbyCensus!.id),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.md),
                ],
                Text(
                  l10n.censusesUpcomingTitle,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: AppDimensions.sm),
                UpcomingCensusesSection(
                  censuses: censuses,
                  onCensusTap: (census) =>
                      context.push(AppRoutes.censusDetail, extra: census),
                ),
              ],
            );
          },
        );
      },
    );
  }
}

class _IdleScaffold extends StatelessWidget {
  const _IdleScaffold({required this.onTypeSelected});

  final void Function(SessionType) onTypeSelected;

  @override
  Widget build(BuildContext context) {
    return _BaseHomeLayout(
      child: SessionTypeSelector(onTypeSelected: onTypeSelected),
    );
  }
}

class _LoadingScaffold extends StatelessWidget {
  const _LoadingScaffold();

  @override
  Widget build(BuildContext context) {
    return const _BaseHomeLayout(
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

class _ActiveScaffold extends StatelessWidget {
  const _ActiveScaffold({required this.session, required this.onResume});

  final ObservationSession session;
  final VoidCallback onResume;

  @override
  Widget build(BuildContext context) {
    return _BaseHomeLayout(
      child: ActiveSessionCard(session: session, onResume: onResume),
    );
  }
}
