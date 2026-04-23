import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/constants/app_routes.dart';
import 'package:noctambuls/core/widgets/app_button.dart';
import 'package:noctambuls/core/widgets/taxus_app_bar.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:noctambuls/features/auth/presentation/bloc/auth_state.dart';
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
    SessionLifecycleIdle() || SessionLifecycleError() => SessionLifecycleIdle,
    SessionLifecycleLoading() => SessionLifecycleLoading,
    SessionObserving() => SessionObserving,
    SessionReviewing() || SessionFinished() => SessionReviewing,
  };

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SessionLifecycleBloc, SessionLifecycleState>(
      listenWhen: (prev, curr) {
        if (curr is SessionLifecycleError) return true;
        if (curr is SessionObserving) return prev is! SessionObserving;
        if (curr is SessionReviewing) return prev is! SessionReviewing;
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
          case SessionReviewing():
            unawaited(context.push(AppRoutes.review));
          default:
            break;
        }
      },
      buildWhen: (prev, curr) =>
          _getRebuildGroup(prev) != _getRebuildGroup(curr),
      builder: (context, state) {
        return switch (state) {
          SessionLifecycleIdle() || SessionLifecycleError() => _IdleScaffold(
            onTypeSelected: (type) =>
                context.read<SessionLifecycleBloc>().add(
                  StartNewSession(
                    sessionType: type,
                    annotatorId:
                        (context.read<AuthBloc>().state as Authenticated?)
                            ?.user
                            .id ??
                        'unknown',
                  ),
                ),
          ),
          SessionLifecycleLoading() => const _LoadingScaffold(),
          SessionObserving() => _ActiveScaffold(
            session: state.session,
            onResume: () => unawaited(context.push(AppRoutes.observing)),
          ),
          SessionReviewing() => const _ReviewingScaffold(),
          SessionFinished() => throw UnimplementedError(),
          // TODO(page): Implementar comporatament sessio finalitzada
        };
      },
    );
  }
}

class _BaseHomeLayout extends StatelessWidget {
  const _BaseHomeLayout({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

class _ReviewingScaffold extends StatelessWidget {
  const _ReviewingScaffold();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return _BaseHomeLayout(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.fact_check_outlined,
              size: AppDimensions.xxl * 1.5,
              color: colorScheme.primary,
            ),
            const SizedBox(height: AppDimensions.lg),
            Text(
              l10n.sessionInReview,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppDimensions.xl),
            AppButton.primary(
              onPressed: () => unawaited(context.push(AppRoutes.review)),
              label: l10n.continueReview,
            ),
          ],
        ),
      ),
    );
  }
}
