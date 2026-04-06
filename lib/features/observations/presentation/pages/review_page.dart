import 'package:flutter/material.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

// TODO(feature): Implementar el contingut de la pantalla de revisió:
// - Resum de les observacions registrades
// - Accions finals (finalitzar i bloquejar sessió, exportar, etc.)

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.reviewTitle),
        backgroundColor: colorScheme.surfaceContainer,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      body: const Center(
        child: Text('TODO: Resum de la sessió'),
      ),
    );
  }
}
