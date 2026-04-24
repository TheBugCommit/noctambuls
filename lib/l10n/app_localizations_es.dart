// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Noctámbulos';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get languageLabel => 'Idioma';

  @override
  String get systemLabel => 'Sistema';

  @override
  String get catalanLabel => 'Catalan';

  @override
  String get spanishLabel => 'Castellano';

  @override
  String get themeLightLabel => 'Claro';

  @override
  String get themeDarkLabel => 'Oscuro';

  @override
  String get themeSystemLabel => 'Sistema';

  @override
  String get homeLabel => 'Inicio';

  @override
  String get guideLabel => 'Guía';

  @override
  String get exploreLabel => 'Explora';

  @override
  String get profileLabel => 'Perfil';

  @override
  String get censusLabel => 'Censo';

  @override
  String get stationLabel => 'Estación de Seguimiento';

  @override
  String get incidentalLabel => 'Observación Incidental';

  @override
  String get homeTitle => 'Inicio';

  @override
  String get errorSessionAlreadyExists =>
      'Ya hay una sesión activa. Finalízala o cancélala primero.';

  @override
  String get errorUnknown => 'Se ha producido un error desconocido.';

  @override
  String get activeSessionTitle => 'Sesión en curso';

  @override
  String startedAt(String time) {
    return 'Observando desde $time';
  }

  @override
  String observationsRegistered(int count) {
    return '$count observaciones registradas';
  }

  @override
  String get noObservationsRegistered =>
      'No hay ninguna observacion registrada';

  @override
  String get stopAndReview => 'Detener';

  @override
  String get deleteSession => 'Cancelar Sesión';

  @override
  String get deleteSessionTitle => '¿Cancelar sesión?';

  @override
  String get deleteSessionBody =>
      'Se perderá toda la información y no se podrá recuperar.';

  @override
  String get back => 'Volver';

  @override
  String get delete => 'Eliminar';

  @override
  String get cancel => 'Cancela';

  @override
  String get confirmDelete => 'Sí, elimina';

  @override
  String get confirmDeleteSessionMessage =>
      'Se perderán todas las observaciones de esta sesión. Esta acción es irreversible.';

  @override
  String get confirmDeleteSessionTitle => 'Quieres eliminar la session?';

  @override
  String get stopSessionTitle => '¿Detener la sesión?';

  @override
  String get stopSessionBody =>
      'Las observaciones ya registradas se conservarán.';

  @override
  String get stopSessionConfirm => 'Detener';

  @override
  String get reviewTitle => 'Revisión';

  @override
  String get sessionInReview => 'Sesión en revisión';

  @override
  String get continueReview => 'Continuar la revisión';

  @override
  String get continueObserving => 'Continuar observando';

  @override
  String get observingTitle => 'Observando';

  @override
  String get noBirdsFound => 'No se han encontrado aves';

  @override
  String get listen => 'Escuchar';

  @override
  String get moreInfo => 'Más info';

  @override
  String semanticLabelBirdImage(String bird) {
    return 'Fotografía de $bird';
  }
}
