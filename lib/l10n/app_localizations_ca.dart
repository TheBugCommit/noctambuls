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
  String get errorUnknown => 'S\'ha produït un error desconegut.';

  @override
  String get back => 'Tornar';

  @override
  String get delete => 'Eliminar';

  @override
  String get cancel => 'Cancel·la';

  @override
  String get retry => 'Tornar-ho a intentar';

  @override
  String get ignore => 'Ignorar';

  @override
  String get confirmDelete => 'Sí, elimina';

  @override
  String get homeLabel => 'Inici';

  @override
  String get guideLabel => 'Guia';

  @override
  String get exploreLabel => 'Explora';

  @override
  String get profileLabel => 'Perfil';

  @override
  String get loginTitle => 'Benvingut/da';

  @override
  String get loginSubtitle => 'Inicia sessió per continuar';

  @override
  String get signInWithGoogle => 'Inicia sessió amb Google';

  @override
  String get signInError =>
      'No s\'ha pogut iniciar sessió. Torna-ho a intentar.';

  @override
  String get signOutLabel => 'Tanca la sessió';

  @override
  String get signUpTitle => 'Completa el teu perfil';

  @override
  String get signUpSessionExpired =>
      'La sessió ha caducat, si us plau, torna a iniciar sessió';

  @override
  String get signUpError => 'S\'ha produït un error. Torna-ho a provar.';

  @override
  String get signUpHeaderTitle => 'Ja gairebé hi som!';

  @override
  String get signUpHeaderSubTitle =>
      'Necessitem algunes dades bàsiques per finalitzar el teu registre.';

  @override
  String get signUpFormNameLabel => 'Nom complet';

  @override
  String get signUpFormNameLength => 'El nom ha de tenir almenys 3 caràcters';

  @override
  String get signUpFormNameMaxLength =>
      'El nom no pot superar els 40 caràcters';

  @override
  String get signUpFormFieldRequired => 'Aquest camp és obligatori';

  @override
  String get signUpFormPhoneLabel => 'Telèfon';

  @override
  String get signUpFormPhoneFormat => 'Introdueix un telèfon vàlid';

  @override
  String get signUpSendButton => 'Finalitzar registre';

  @override
  String get signUpSendButtonLoading => 'Registrant...';

  @override
  String get accept_terms_prefix => 'He llegit i accepto els ';

  @override
  String get terms_and_conditions => 'Termes i Condicions';

  @override
  String get settingsTitle => 'Configuració';

  @override
  String get settingsPreferencesTitle => 'Preferències';

  @override
  String get settingsAccountTitle => 'Compte';

  @override
  String get languageLabel => 'Idioma';

  @override
  String get systemLabel => 'Sistema';

  @override
  String get catalanLabel => 'Català';

  @override
  String get spanishLabel => 'Castellà';

  @override
  String get themeLabel => 'Tema visual';

  @override
  String get themeLightLabel => 'Clar';

  @override
  String get themeDarkLabel => 'Fosc';

  @override
  String get themeSystemLabel => 'Sistema';

  @override
  String get homeTitle => 'Inici';

  @override
  String get censusLabel => 'Cens';

  @override
  String get stationLabel => 'Estació de seguiment';

  @override
  String get incidentalLabel => 'Observació incidental';

  @override
  String get observingMethodTitle => 'Sobre els mètodes d\'observació';

  @override
  String get observingMethodConfirmLabel => 'Entesos';

  @override
  String get observingMethodCensTitle => 'Cens';

  @override
  String get observingMethodCensDescription =>
      'És un treball coordinat entre diversos grups de persones en punts fixos de forma simultània. S\'utilitza en campanyes oficials o jornades de cens col·lectiu privades.';

  @override
  String get observingMethodESTitle => 'Estació de seguiment';

  @override
  String get observingMethodESDescription =>
      'És una observació típicament individual des d\'un únic punt fix durant un temps determinat. S\'utilitza per mostrejos repetitius en el mateix lloc.';

  @override
  String get observingMethodIncTitle => 'Observació incidental';

  @override
  String get observingMethodIncDescription =>
      'És una observació inesperada o aïllada mentre fas una altra activitat. Fes-la servir quan vegis un ocell de forma casual i el vulguis anotar ràpidament sense seguir un protocol fix.';

  @override
  String get activeSessionTitle => 'Sessió en curs';

  @override
  String startedAt(String time) {
    return 'Observant des de $time';
  }

  @override
  String get errorSessionAlreadyExists =>
      'Ja hi ha una sessió activa. Finalitza-la o cancel·la-la primer.';

  @override
  String observationsRegistered(int count) {
    return '$count observacions registrades';
  }

  @override
  String get noObservationsRegistered => 'No hi ha cap observació registrada';

  @override
  String get observingTitle => 'Observant';

  @override
  String get stopAndReview => 'Aturar';

  @override
  String get continueObserving => 'Continuar observant';

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
  String get deleteSession => 'Cancel·lar sessió';

  @override
  String get deleteSessionTitle => 'Cancel·lar sessió?';

  @override
  String get deleteSessionBody =>
      'Es perdrà tota la informació i no es podrà recuperar.';

  @override
  String get confirmDeleteSessionTitle => 'Vols eliminar la sessió?';

  @override
  String get confirmDeleteSessionMessage =>
      'Es perdran totes les observacions d\'aquesta sessió. Aquesta acció no es pot desfer.';

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
  String get noImageAvailable => 'La imatge no està disponible';

  @override
  String get downloadingCatalog => 'Descarregant els ocells...';

  @override
  String get connectionError => 'Error de connexió';

  @override
  String get catalogDownloadError =>
      'No s\'ha pogut descarregar el catàleg inicial. Comprova la teva connexió a internet.';

  @override
  String get requiredBirdCatalog => 'Catàleg d\'ocells requerit';

  @override
  String get requiredBirdCatalogMsg =>
      'Per utilitzar aquesta secció necessites descarregar el catàleg d\'ocells almenys un cop.';

  @override
  String get downloadNow => 'Descarregar ara';

  @override
  String get homeErrorDownloadCatalog =>
      'Descàrrega del catàleg d\'ocells fallida';

  @override
  String get homeErrorDownloadCatalogMsg =>
      'No s\'ha pogut actualitzar el catàleg d\'ocells. Pots seguir utilitzant l\'aplicació o tornar a intentar la descàrrega.';

  @override
  String get usageWarningTitle => 'Advertència d\'ús';

  @override
  String get usageWarningMessage =>
      'La reproducció d\'aquest àudio durant un cens pot alterar el comportament dels ocells i distorsionar els resultats de l\'observació.\n\nSi us plau, fes-ne un ús responsable.';

  @override
  String get usageWarningConfirm => 'Sí, ho entenc';

  @override
  String get cantOpenLink => 'No s\'ha pogut obrir l\'enllaç';

  @override
  String get cantPlayAudio => 'No s\'ha pogut reproduir l\'àudio';

  @override
  String get stopPlayingAudio => 'Atura';

  @override
  String get profileOrnithologistCode => 'Codi d\'ornitòleg';

  @override
  String get profileShowQr => 'Mostrar QR';

  @override
  String get profileQrDialogTitle => 'Codi QR d\'ornitòleg';

  @override
  String get profileQrDialogClose => 'Tancar';

  @override
  String get profileObservationsTab => 'Observacions';

  @override
  String get profileParticipationsTab => 'Participacions';

  @override
  String get profileEditTitle => 'Editar perfil';

  @override
  String get profileEditSaveButton => 'Desar canvis';

  @override
  String get profileEditSaveButtonLoading => 'Desant...';

  @override
  String get profileEditSuccess => 'Perfil actualitzat correctament';

  @override
  String get profileEditError => 'No s\'ha pogut actualitzar el perfil';

  @override
  String get profileLoadError => 'No s\'ha pogut carregar el perfil';

  @override
  String get profileObservationsEmpty => 'Encara no hi ha observacions.';

  @override
  String get profileRetry => 'Tornar a intentar';

  @override
  String get profileSignOut => 'Tanca la sessió';

  @override
  String get settingsSupportTitle => 'Suport';

  @override
  String get settingsHelp => 'Ajuda';

  @override
  String get settingsAbout => 'Acerca de Noctàmbuls';

  @override
  String get settingsTellAFriend => 'Digali a un amic';

  @override
  String get settingsTellAFriendText =>
      'Descobreix Noctàmbuls, l\'app per registrar les teves observacions d\'ocells! 🦉';

  @override
  String get settingsLegalTitle => 'Legal';

  @override
  String get settingsPrivacyPolicy => 'Política de privacitat';

  @override
  String get settingsTermsOfUse => 'Termes d\'ús';

  @override
  String get settingsDeleteAccount => 'Eliminar compte';

  @override
  String get settingsDeleteAccountDialogTitle => 'Eliminar compte?';

  @override
  String get settingsDeleteAccountDialogBody =>
      'Aquesta acció és irreversible. Totes les teves dades seran eliminades permanentment.';

  @override
  String get settingsDeleteAccountDialogConfirm => 'Sí, eliminar';

  @override
  String get settingsDeleteAccountError =>
      'No s\'ha pogut eliminar el compte. Torna-ho a intentar.';

  @override
  String get newObservationTitle => 'Nova Observació';

  @override
  String get editObservationTitle => 'Editar Observació';

  @override
  String get saveObservation => 'Desar';

  @override
  String get selectSpecies => 'Selecciona una espècie';

  @override
  String get timeRangeLabel => 'Franja horària';

  @override
  String get quantityLabel => 'Quantitat';

  @override
  String get contactTypeLabel => 'Tipus de Contacte';

  @override
  String get locationLabel => 'Ubicació';

  @override
  String get directionLabel => 'Direcció';

  @override
  String get notesLabel => 'Notes';

  @override
  String get notesHint => 'Afegeix notes...';

  @override
  String get fetchingLocation => 'Obtenint ubicació...';

  @override
  String get locationUnavailable => 'Ubicació no disponible';

  @override
  String get compassLabel => 'Orientació';

  @override
  String get confirmDeleteObservationTitle => 'Vols eliminar l\'observació?';

  @override
  String get confirmDeleteObservationMessage =>
      'Aquesta acció no es pot desfer.';

  @override
  String get errorSavingObservation =>
      'Hi ha hagut un error al guardar l\'observació';

  @override
  String get visualContactType => 'Visual';

  @override
  String get auditiveContactType => 'Auditiu';

  @override
  String get reduceQuantityTooltip => 'Redueix la quantitat';

  @override
  String get incrementQuantityTooltip => 'Augmenta la quantitat';

  @override
  String get orientationTitle => 'Orientació';

  @override
  String get orientationHint => 'Toca per definir l\'orientació';

  @override
  String get compassError => 'Error llegint els sensors.';

  @override
  String get compassNoSensor => 'El dispositiu no té sensor de brúixola.';

  @override
  String get compassInstruction =>
      'Apunta el telèfon cap a l\'observació i prem fixar.';

  @override
  String get compassFixDirection => 'Fixar Orientació';

  @override
  String get locationDirectionTitle => 'Ubicació i Orientació';

  @override
  String get orientationRequired => 'L\'orientació és obligatòria';

  @override
  String get updateGPS => 'Actualiza GPS';

  @override
  String get updateOrientation => 'Modificar orientació';

  @override
  String orientationValueLong(String orientation, String value) {
    return '$orientation $value°';
  }

  @override
  String get observationDateLabel => 'Data de l\'observació';

  @override
  String get dayLabel => 'Dia';

  @override
  String get startTimeLabel => 'Hora inici';

  @override
  String get endTimeLabel => 'Hora fi';

  @override
  String get statusObserving => 'En curs';

  @override
  String get statusReviewing => 'En revisió';

  @override
  String get statusDraft => 'Esborrany';

  @override
  String get statusPending => 'Pendent';

  @override
  String get statusSynced => 'Sincronitzat';

  @override
  String get statusSyncError => 'Error de xarxa';

  @override
  String get stopAndReviewTitle => 'Finalitzar observació';

  @override
  String get stopAndReviewMessage =>
      'Estàs segur que vols aturar el temps i passar a revisar les dades?';

  @override
  String get stopAndReviewConfirm => 'Finalitzar';

  @override
  String get sessionCardEndsAt => 'Finalitzada a les ';

  @override
  String get errorLoadingObservationSessions =>
      'Error carregant les sessions d\'observació';
}
