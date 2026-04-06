import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_dimensions.dart';
import 'package:noctambuls/core/constants/app_routes.dart';
import 'package:noctambuls/core/di/injection_container.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_record.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_lifecycle_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_lifecycle_event.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_lifecycle_state.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_bloc.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_event.dart';
import 'package:noctambuls/features/observations/presentation/bloc/session_observation_state.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

// TODO(feature): Nav bar, Appbar content...
class ObservingPage extends StatelessWidget {
  const ObservingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SessionLifecycleBloc, SessionLifecycleState>(
      listenWhen: (prev, curr) =>
          prev is SessionObserving && curr is! SessionObserving,
      listener: (context, state) {
        switch (state) {
          case SessionReviewing():
            context.go(AppRoutes.review);
          default:
            context.go(AppRoutes.home);
        }
      },
      buildWhen: (prev, curr) {
        final prevId = prev is SessionObserving ? prev.session.id : null;
        final currId = curr is SessionObserving ? curr.session.id : null;
        return prevId != currId;
      },
      builder: (context, state) {
        if (state is! SessionObserving) return const SizedBox.shrink();

        return BlocProvider(
          create: (_) =>
              sl<SessionObservationBloc>(param1: state.session.id)
                ..add(WatchObservations()),
          child: _ObservingContent(session: state.session),
        );
      },
    );
  }
}

class _ObservingContent extends StatelessWidget {
  const _ObservingContent({required this.session});

  final ObservationSession session;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.observingTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: l10n.cancelSession,
            onPressed: () => _showCancelDialog(context, l10n),
          ),
        ],
      ),
      body: const _ObservationListBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO(navigation): Navegar a la pantalla d'afegir observació.
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  void _showCancelDialog(BuildContext context, AppLocalizations l10n) {
    final colorScheme = Theme.of(context).colorScheme;
    unawaited(
      showDialog<void>(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(l10n.cancelSessionTitle),
          content: Text(l10n.cancelSessionBody),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l10n.back),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: colorScheme.error,
                foregroundColor: colorScheme.onError,
              ),
              onPressed: () {
                Navigator.pop(ctx);
                context.read<SessionLifecycleBloc>().add(DeleteActiveSession());
              },
              child: Text(l10n.delete),
            ),
          ],
        ),
      ),
    );
  }
}

class _ObservationListBody extends StatelessWidget {
  const _ObservationListBody();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SessionObservationBloc, SessionObservationState>(
      builder: (context, state) {
        final observations = state is ObservationsLoaded
            ? state.observations
            : const <ObservationRecord>[];

        if (observations.isEmpty) {
          return _EmptyObservations();
        }

        return ListView.builder(
          padding: const EdgeInsets.all(AppDimensions.md),
          itemCount: observations.length,
          itemBuilder: (context, index) =>
              _ObservationTile(record: observations[index]),
        );
      },
    );
  }
}

class _EmptyObservations extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.biotech_outlined,
            size: 64,
            color: colorScheme.outlineVariant,
          ),
          const SizedBox(height: AppDimensions.md),
          Text(
            // TODO(l10n): Afegir clau de traducció per a "Cap observació"
            'Cap observació registrada',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _ObservationTile extends StatelessWidget {
  const _ObservationTile({required this.record});

  final ObservationRecord record;

  @override
  Widget build(BuildContext context) {
    // TODO(design): Dissenyar la targeta d'observació definitiva.
    return Card(
      child: ListTile(
        leading: const Icon(Icons.pets_outlined),
        title: Text(record.speciesId),
        subtitle: Text(record.contactType),
      ),
    );
  }
}
