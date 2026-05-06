import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_routes.dart';
import 'package:noctambuls/features/observations/domain/entities/observation_session.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

// TODO(feature): Implementar el contingut de la pantalla de revisió:
// - Resum de les observacions registrades
// - Accions finals (finalitzar i bloquejar sessió, exportar, etc.)

class ReviewPage extends StatelessWidget {
  const ReviewPage({required this.session, super.key});

  final ObservationSession session;

  bool get isReadOnly => !session.isReviewing;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        leading: context.canPop()
            ? BackButton(onPressed: () => context.pop())
            : IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => context.go(AppRoutes.profile),
              ),
        title: Text(l10n.reviewTitle),
        backgroundColor: colorScheme.surfaceContainer,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: Center(
        // Ara ja pots utilitzar `session` a qualsevol lloc del teu widget!
        child: Text(
          'Revisant la sessió: ${session.id}\n'
          'Només lectura: $isReadOnly',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
