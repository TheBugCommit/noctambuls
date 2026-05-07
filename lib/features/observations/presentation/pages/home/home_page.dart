import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/constants/app_routes.dart';
import 'package:noctambuls/core/presentation/widgets/app_sheet.dart';
import 'package:noctambuls/core/presentation/widgets/taxus_app_bar.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_state.dart';
import 'package:noctambuls/features/guide/presentation/bloc/catalog_sync_bloc.dart';
import 'package:noctambuls/features/guide/presentation/bloc/catalog_sync_event.dart';
import 'package:noctambuls/features/guide/presentation/bloc/catalog_sync_state.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/domain/enums/session_type.dart';
import 'package:noctambuls/features/observations/domain/failures/session_failures.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_lifecycle_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_lifecycle_event.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_lifecycle_state.dart';
import 'package:noctambuls/features/observations/presentation/pages/home/widgets/active_session_card.dart';
import 'package:noctambuls/features/observations/presentation/pages/home/widgets/home_header.dart';
import 'package:noctambuls/features/observations/presentation/shared_widgets/session_type_selector.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Type _getRebuildGroup(SessionLifecycleState state) => switch (state) {
    SessionLifecycleIdle() ||
    SessionLifecycleError() ||
    SessionNavigatingToReview() ||
    SessionReviewing() ||
    SessionFinished() => SessionLifecycleIdle,
    SessionLifecycleLoading() => SessionLifecycleLoading,
    SessionObserving() => SessionObserving,
  };

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SessionLifecycleBloc, SessionLifecycleState>(
      listenWhen: (prev, curr) {
        if (curr is SessionLifecycleError) return true;
        if (curr is SessionObserving && prev is! SessionObserving) return true;
        return false;
      },
      listener: (context, state) {
        switch (state) {
          case SessionLifecycleError():
            final l10n = AppLocalizations.of(context)!;
            final message = switch (state.failure) {
              ActiveSessionAlreadyExistsFailure() =>
                l10n.errorSessionAlreadyExists,
              _ => l10n.errorUnknown,
            };
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(message)),
            );
            context.read<SessionLifecycleBloc>().add(DismissError());
          case SessionObserving():
            unawaited(context.push(AppRoutes.observing));
          default:
            break;
        }
      },
      buildWhen: (prev, curr) =>
          _getRebuildGroup(prev) != _getRebuildGroup(curr),
      builder: (context, state) {
        return switch (state) {
          SessionLifecycleIdle() ||
          SessionNavigatingToReview() ||
          SessionReviewing() ||
          SessionFinished() ||
          SessionLifecycleError() => _IdleScaffold(
            onTypeSelected: (type) => context.read<SessionLifecycleBloc>().add(
              StartNewSession(
                sessionType: type,
                annotatorId:
                    (context.read<AuthBloc>().state as Authenticated).user.id,
              ),
            ),
          ),
          SessionLifecycleLoading() => const _LoadingScaffold(),
          SessionObserving() => _ActiveScaffold(
            session: state.session,
            onResume: () => unawaited(context.push(AppRoutes.observing)),
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
      child: Scaffold(
        appBar: const TaxusAppBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimensions.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeader(),
              const SizedBox(height: AppDimensions.xl),
              child,
            ],
          ),
        ),
      ),
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
