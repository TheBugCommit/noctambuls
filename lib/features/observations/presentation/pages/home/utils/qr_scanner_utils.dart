import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:noctambuls/core/constants/app_deeplinks.dart';
import 'package:noctambuls/core/constants/app_routes.dart';
import 'package:noctambuls/features/censuses/presentation/bloc/census_bloc.dart';
import 'package:noctambuls/features/censuses/presentation/bloc/census_event.dart';
import 'package:noctambuls/features/observations/presentation/pages/review/qr_scanner_page.dart';
import 'package:noctambuls/l10n/app_localizations.dart';

Future<void> openCensusQrScanner(BuildContext context) async {
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
}
