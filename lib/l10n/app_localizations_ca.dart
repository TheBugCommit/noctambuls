// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class AppLocalizationsCa extends AppLocalizations {
  AppLocalizationsCa([String locale = 'ca']) : super(locale);

  @override
  String get appTitle => 'Noctàmbuls';

  @override
  String get settingsTitle => 'Configuració';

  @override
  String get languageLabel => 'Idioma';

  @override
  String get systemLabel => 'Sistema';

  @override
  String get catalanLabel => 'Català';

  @override
  String get spanishLabel => 'Castellà';

  @override
  String get themeLightLabel => 'Clar';

  @override
  String get themeDarkLabel => 'Fosc';

  @override
  String get themeSystemLabel => 'Sistema';

  @override
  String get homeLabel => 'Inici';

  @override
  String get guideLabel => 'Guia';

  @override
  String get exploreLabel => 'Explora';

  @override
  String get profileLabel => 'Perfil';

  @override
  String get censusLabel => 'Cens';

  @override
  String get stationLabel => 'Estació de Seguiment';

  @override
  String get incidentalLabel => 'Observació Incidental';

  @override
  String get homeTitle => 'Inici';

  @override
  String get errorSessionAlreadyExists =>
      'Ja hi ha una sessió activa. Finalitza-la o cancel·la-la primer.';

  @override
  String get errorUnknown => 'S\'ha produït un error desconegut.';

  @override
  String get activeSessionTitle => 'Sessió en curs';

  @override
  String startedAt(String time) {
    return 'Observant des de $time';
  }

  @override
  String observationsRegistered(int count) {
    return '$count observacions registrades';
  }

  @override
  String get noObservationsRegistered => 'No hi ha cap observació registrada';

  @override
  String get stopAndReview => 'Aturar';

  @override
  String get deleteSession => 'Cancel·lar Sessió';

  @override
  String get deleteSessionTitle => 'Cancel·lar sessió?';

  @override
  String get deleteSessionBody =>
      'Es perdrà tota la informació i no es podrà recuperar.';

  @override
  String get back => 'Tornar';

  @override
  String get delete => 'Eliminar';

  @override
  String get cancel => 'Cancel·la';

  @override
  String get confirmDelete => 'Sí, elimina';

  @override
  String get confirmDeleteSessionMessage =>
      'Es perdran totes les observacions d\'aquesta sessió. Aquesta acció no es pot desfer.';

  @override
  String get confirmDeleteSessionTitle => 'Vols eliminar la sessió?';

  @override
  String get stopSessionTitle => 'Aturar la sessió?';

  @override
  String get stopSessionBody =>
      'Les observacions ja registrades es conservaran.';

  @override
  String get stopSessionConfirm => 'Aturar';

  @override
  String get reviewTitle => 'Revisió';

  @override
  String get sessionInReview => 'Sessió en revisió';

  @override
  String get continueReview => 'Continuar la revisió';

  @override
  String get continueObserving => 'Continuar observant';

  @override
  String get observingTitle => 'Observant';

  @override
  String get noBirdsFound => 'No s\'han trobat ocells';

  @override
  String get listen => 'Escoltar';

  @override
  String get moreInfo => 'Més info';

  @override
  String semanticLabelBirdImage(String bird) {
    return 'Fotografia de $bird';
  }

  @override
  String get cantOpenLink => 'No s\'ha pogut obrir l\'enllaç';
}
