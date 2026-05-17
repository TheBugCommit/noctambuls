import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ca.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ca'),
    Locale('es'),
  ];

  /// El títol principal de l'aplicació
  ///
  /// In ca, this message translates to:
  /// **'Noctàmbuls'**
  String get appTitle;

  /// No description provided for @errorUnknown.
  ///
  /// In ca, this message translates to:
  /// **'S\'ha produït un error desconegut.'**
  String get errorUnknown;

  /// No description provided for @back.
  ///
  /// In ca, this message translates to:
  /// **'Tornar'**
  String get back;

  /// No description provided for @delete.
  ///
  /// In ca, this message translates to:
  /// **'Eliminar'**
  String get delete;

  /// No description provided for @cancel.
  ///
  /// In ca, this message translates to:
  /// **'Cancel·la'**
  String get cancel;

  /// No description provided for @retry.
  ///
  /// In ca, this message translates to:
  /// **'Tornar-ho a intentar'**
  String get retry;

  /// No description provided for @ignore.
  ///
  /// In ca, this message translates to:
  /// **'Ignorar'**
  String get ignore;

  /// No description provided for @confirmDelete.
  ///
  /// In ca, this message translates to:
  /// **'Sí, elimina'**
  String get confirmDelete;

  /// No description provided for @homeLabel.
  ///
  /// In ca, this message translates to:
  /// **'Inici'**
  String get homeLabel;

  /// No description provided for @guideLabel.
  ///
  /// In ca, this message translates to:
  /// **'Guia'**
  String get guideLabel;

  /// No description provided for @exploreLabel.
  ///
  /// In ca, this message translates to:
  /// **'Explora'**
  String get exploreLabel;

  /// No description provided for @profileLabel.
  ///
  /// In ca, this message translates to:
  /// **'Perfil'**
  String get profileLabel;

  /// No description provided for @loginTitle.
  ///
  /// In ca, this message translates to:
  /// **'Benvingut/da'**
  String get loginTitle;

  /// No description provided for @loginSubtitle.
  ///
  /// In ca, this message translates to:
  /// **'Inicia sessió per continuar'**
  String get loginSubtitle;

  /// No description provided for @signInWithGoogle.
  ///
  /// In ca, this message translates to:
  /// **'Inicia sessió amb Google'**
  String get signInWithGoogle;

  /// No description provided for @signInError.
  ///
  /// In ca, this message translates to:
  /// **'No s\'ha pogut iniciar sessió. Torna-ho a intentar.'**
  String get signInError;

  /// No description provided for @signOutLabel.
  ///
  /// In ca, this message translates to:
  /// **'Tanca la sessió'**
  String get signOutLabel;

  /// No description provided for @signUpTitle.
  ///
  /// In ca, this message translates to:
  /// **'Completa el teu perfil'**
  String get signUpTitle;

  /// No description provided for @signUpSessionExpired.
  ///
  /// In ca, this message translates to:
  /// **'La sessió ha caducat, si us plau, torna a iniciar sessió'**
  String get signUpSessionExpired;

  /// No description provided for @signUpError.
  ///
  /// In ca, this message translates to:
  /// **'S\'ha produït un error. Torna-ho a provar.'**
  String get signUpError;

  /// No description provided for @signUpHeaderTitle.
  ///
  /// In ca, this message translates to:
  /// **'Ja gairebé hi som!'**
  String get signUpHeaderTitle;

  /// No description provided for @signUpHeaderSubTitle.
  ///
  /// In ca, this message translates to:
  /// **'Necessitem algunes dades bàsiques per finalitzar el teu registre.'**
  String get signUpHeaderSubTitle;

  /// No description provided for @signUpFormNameLabel.
  ///
  /// In ca, this message translates to:
  /// **'Nom complet'**
  String get signUpFormNameLabel;

  /// No description provided for @signUpFormNameLength.
  ///
  /// In ca, this message translates to:
  /// **'El nom ha de tenir almenys 3 caràcters'**
  String get signUpFormNameLength;

  /// No description provided for @signUpFormNameMaxLength.
  ///
  /// In ca, this message translates to:
  /// **'El nom no pot superar els 40 caràcters'**
  String get signUpFormNameMaxLength;

  /// No description provided for @signUpFormFieldRequired.
  ///
  /// In ca, this message translates to:
  /// **'Aquest camp és obligatori'**
  String get signUpFormFieldRequired;

  /// No description provided for @signUpFormPhoneLabel.
  ///
  /// In ca, this message translates to:
  /// **'Telèfon'**
  String get signUpFormPhoneLabel;

  /// No description provided for @signUpFormPhoneFormat.
  ///
  /// In ca, this message translates to:
  /// **'Introdueix un telèfon vàlid'**
  String get signUpFormPhoneFormat;

  /// No description provided for @signUpSendButton.
  ///
  /// In ca, this message translates to:
  /// **'Finalitzar registre'**
  String get signUpSendButton;

  /// No description provided for @signUpSendButtonLoading.
  ///
  /// In ca, this message translates to:
  /// **'Registrant...'**
  String get signUpSendButtonLoading;

  /// No description provided for @accept_terms_prefix.
  ///
  /// In ca, this message translates to:
  /// **'He llegit i accepto els '**
  String get accept_terms_prefix;

  /// No description provided for @terms_and_conditions.
  ///
  /// In ca, this message translates to:
  /// **'Termes i Condicions'**
  String get terms_and_conditions;

  /// No description provided for @settingsTitle.
  ///
  /// In ca, this message translates to:
  /// **'Configuració'**
  String get settingsTitle;

  /// No description provided for @settingsPreferencesTitle.
  ///
  /// In ca, this message translates to:
  /// **'Preferències'**
  String get settingsPreferencesTitle;

  /// No description provided for @settingsAccountTitle.
  ///
  /// In ca, this message translates to:
  /// **'Compte'**
  String get settingsAccountTitle;

  /// No description provided for @languageLabel.
  ///
  /// In ca, this message translates to:
  /// **'Idioma'**
  String get languageLabel;

  /// No description provided for @systemLabel.
  ///
  /// In ca, this message translates to:
  /// **'Sistema'**
  String get systemLabel;

  /// No description provided for @catalanLabel.
  ///
  /// In ca, this message translates to:
  /// **'Català'**
  String get catalanLabel;

  /// No description provided for @spanishLabel.
  ///
  /// In ca, this message translates to:
  /// **'Castellà'**
  String get spanishLabel;

  /// No description provided for @themeLabel.
  ///
  /// In ca, this message translates to:
  /// **'Tema visual'**
  String get themeLabel;

  /// No description provided for @themeLightLabel.
  ///
  /// In ca, this message translates to:
  /// **'Clar'**
  String get themeLightLabel;

  /// No description provided for @themeDarkLabel.
  ///
  /// In ca, this message translates to:
  /// **'Fosc'**
  String get themeDarkLabel;

  /// No description provided for @themeSystemLabel.
  ///
  /// In ca, this message translates to:
  /// **'Sistema'**
  String get themeSystemLabel;

  /// No description provided for @homeTitle.
  ///
  /// In ca, this message translates to:
  /// **'Inici'**
  String get homeTitle;

  /// No description provided for @censusLabel.
  ///
  /// In ca, this message translates to:
  /// **'Cens'**
  String get censusLabel;

  /// No description provided for @stationLabel.
  ///
  /// In ca, this message translates to:
  /// **'Estació de seguiment'**
  String get stationLabel;

  /// No description provided for @incidentalLabel.
  ///
  /// In ca, this message translates to:
  /// **'Observació incidental'**
  String get incidentalLabel;

  /// No description provided for @observingMethodTitle.
  ///
  /// In ca, this message translates to:
  /// **'Sobre els mètodes d\'observació'**
  String get observingMethodTitle;

  /// No description provided for @observingMethodConfirmLabel.
  ///
  /// In ca, this message translates to:
  /// **'Entesos'**
  String get observingMethodConfirmLabel;

  /// No description provided for @observingMethodCensTitle.
  ///
  /// In ca, this message translates to:
  /// **'Cens'**
  String get observingMethodCensTitle;

  /// No description provided for @observingMethodCensDescription.
  ///
  /// In ca, this message translates to:
  /// **'És un treball coordinat entre diversos grups de persones en punts fixos de forma simultània. S\'utilitza en campanyes oficials o jornades de cens col·lectiu privades.'**
  String get observingMethodCensDescription;

  /// No description provided for @observingMethodESTitle.
  ///
  /// In ca, this message translates to:
  /// **'Estació de seguiment'**
  String get observingMethodESTitle;

  /// No description provided for @observingMethodESDescription.
  ///
  /// In ca, this message translates to:
  /// **'És una observació típicament individual des d\'un únic punt fix durant un temps determinat. S\'utilitza per mostrejos repetitius en el mateix lloc.'**
  String get observingMethodESDescription;

  /// No description provided for @observingMethodIncTitle.
  ///
  /// In ca, this message translates to:
  /// **'Observació incidental'**
  String get observingMethodIncTitle;

  /// No description provided for @observingMethodIncDescription.
  ///
  /// In ca, this message translates to:
  /// **'És una observació inesperada o aïllada mentre fas una altra activitat. Fes-la servir quan vegis un ocell de forma casual i el vulguis anotar ràpidament sense seguir un protocol fix.'**
  String get observingMethodIncDescription;

  /// No description provided for @activeSessionTitle.
  ///
  /// In ca, this message translates to:
  /// **'Sessió en curs'**
  String get activeSessionTitle;

  /// No description provided for @startedAt.
  ///
  /// In ca, this message translates to:
  /// **'Observant des de les '**
  String get startedAt;

  /// No description provided for @errorSessionAlreadyExists.
  ///
  /// In ca, this message translates to:
  /// **'Ja hi ha una sessió activa. Finalitza-la o cancel·la-la primer.'**
  String get errorSessionAlreadyExists;

  /// No description provided for @observationsRegistered.
  ///
  /// In ca, this message translates to:
  /// **'{count} observacions registrades'**
  String observationsRegistered(int count);

  /// No description provided for @noObservationsRegistered.
  ///
  /// In ca, this message translates to:
  /// **'No hi ha cap observació registrada'**
  String get noObservationsRegistered;

  /// No description provided for @observingTitle.
  ///
  /// In ca, this message translates to:
  /// **'Observant'**
  String get observingTitle;

  /// No description provided for @stopAndReview.
  ///
  /// In ca, this message translates to:
  /// **'Aturar'**
  String get stopAndReview;

  /// No description provided for @continueObserving.
  ///
  /// In ca, this message translates to:
  /// **'Continuar observant'**
  String get continueObserving;

  /// No description provided for @stopSessionTitle.
  ///
  /// In ca, this message translates to:
  /// **'Aturar la sessió?'**
  String get stopSessionTitle;

  /// No description provided for @stopSessionBody.
  ///
  /// In ca, this message translates to:
  /// **'Les observacions ja registrades es conservaran.'**
  String get stopSessionBody;

  /// No description provided for @stopSessionConfirm.
  ///
  /// In ca, this message translates to:
  /// **'Aturar'**
  String get stopSessionConfirm;

  /// No description provided for @reviewTitle.
  ///
  /// In ca, this message translates to:
  /// **'Revisió'**
  String get reviewTitle;

  /// No description provided for @sessionInReview.
  ///
  /// In ca, this message translates to:
  /// **'Sessió en revisió'**
  String get sessionInReview;

  /// No description provided for @continueReview.
  ///
  /// In ca, this message translates to:
  /// **'Continuar la revisió'**
  String get continueReview;

  /// No description provided for @deleteSession.
  ///
  /// In ca, this message translates to:
  /// **'Cancel·lar sessió'**
  String get deleteSession;

  /// No description provided for @deleteSessionTitle.
  ///
  /// In ca, this message translates to:
  /// **'Cancel·lar sessió?'**
  String get deleteSessionTitle;

  /// No description provided for @deleteSessionBody.
  ///
  /// In ca, this message translates to:
  /// **'Es perdrà tota la informació i no es podrà recuperar.'**
  String get deleteSessionBody;

  /// No description provided for @confirmDeleteSessionTitle.
  ///
  /// In ca, this message translates to:
  /// **'Vols eliminar la sessió?'**
  String get confirmDeleteSessionTitle;

  /// No description provided for @confirmDeleteSessionMessage.
  ///
  /// In ca, this message translates to:
  /// **'Es perdran totes les observacions d\'aquesta sessió. Aquesta acció no es pot desfer.'**
  String get confirmDeleteSessionMessage;

  /// No description provided for @noBirdsFound.
  ///
  /// In ca, this message translates to:
  /// **'No s\'han trobat ocells'**
  String get noBirdsFound;

  /// No description provided for @listen.
  ///
  /// In ca, this message translates to:
  /// **'Escoltar'**
  String get listen;

  /// No description provided for @moreInfo.
  ///
  /// In ca, this message translates to:
  /// **'Més info'**
  String get moreInfo;

  /// No description provided for @semanticLabelBirdImage.
  ///
  /// In ca, this message translates to:
  /// **'Fotografia de {bird}'**
  String semanticLabelBirdImage(String bird);

  /// No description provided for @noImageAvailable.
  ///
  /// In ca, this message translates to:
  /// **'La imatge no està disponible'**
  String get noImageAvailable;

  /// No description provided for @downloadingCatalog.
  ///
  /// In ca, this message translates to:
  /// **'Descarregant els ocells...'**
  String get downloadingCatalog;

  /// No description provided for @connectionError.
  ///
  /// In ca, this message translates to:
  /// **'Error de connexió'**
  String get connectionError;

  /// No description provided for @catalogDownloadError.
  ///
  /// In ca, this message translates to:
  /// **'No s\'ha pogut descarregar el catàleg inicial. Comprova la teva connexió a internet.'**
  String get catalogDownloadError;

  /// No description provided for @requiredBirdCatalog.
  ///
  /// In ca, this message translates to:
  /// **'Catàleg d\'ocells requerit'**
  String get requiredBirdCatalog;

  /// No description provided for @requiredBirdCatalogMsg.
  ///
  /// In ca, this message translates to:
  /// **'Per utilitzar aquesta secció necessites descarregar el catàleg d\'ocells almenys un cop.'**
  String get requiredBirdCatalogMsg;

  /// No description provided for @downloadNow.
  ///
  /// In ca, this message translates to:
  /// **'Descarregar ara'**
  String get downloadNow;

  /// No description provided for @homeErrorDownloadCatalog.
  ///
  /// In ca, this message translates to:
  /// **'Descàrrega del catàleg d\'ocells fallida'**
  String get homeErrorDownloadCatalog;

  /// No description provided for @homeErrorDownloadCatalogMsg.
  ///
  /// In ca, this message translates to:
  /// **'No s\'ha pogut actualitzar el catàleg d\'ocells. Pots seguir utilitzant l\'aplicació o tornar a intentar la descàrrega.'**
  String get homeErrorDownloadCatalogMsg;

  /// No description provided for @usageWarningTitle.
  ///
  /// In ca, this message translates to:
  /// **'Advertència d\'ús'**
  String get usageWarningTitle;

  /// No description provided for @usageWarningMessage.
  ///
  /// In ca, this message translates to:
  /// **'La reproducció d\'aquest àudio durant un cens pot alterar el comportament dels ocells i distorsionar els resultats de l\'observació.\n\nSi us plau, fes-ne un ús responsable.'**
  String get usageWarningMessage;

  /// No description provided for @usageWarningConfirm.
  ///
  /// In ca, this message translates to:
  /// **'Sí, ho entenc'**
  String get usageWarningConfirm;

  /// No description provided for @cantOpenLink.
  ///
  /// In ca, this message translates to:
  /// **'No s\'ha pogut obrir l\'enllaç'**
  String get cantOpenLink;

  /// No description provided for @cantPlayAudio.
  ///
  /// In ca, this message translates to:
  /// **'No s\'ha pogut reproduir l\'àudio'**
  String get cantPlayAudio;

  /// No description provided for @stopPlayingAudio.
  ///
  /// In ca, this message translates to:
  /// **'Atura'**
  String get stopPlayingAudio;

  /// No description provided for @profileOrnithologistCode.
  ///
  /// In ca, this message translates to:
  /// **'Codi d\'ornitòleg'**
  String get profileOrnithologistCode;

  /// No description provided for @profileShowQr.
  ///
  /// In ca, this message translates to:
  /// **'Mostrar QR'**
  String get profileShowQr;

  /// No description provided for @profileQrDialogTitle.
  ///
  /// In ca, this message translates to:
  /// **'Codi QR d\'ornitòleg'**
  String get profileQrDialogTitle;

  /// No description provided for @profileQrDialogClose.
  ///
  /// In ca, this message translates to:
  /// **'Tancar'**
  String get profileQrDialogClose;

  /// No description provided for @profileObservationsTab.
  ///
  /// In ca, this message translates to:
  /// **'Observacions'**
  String get profileObservationsTab;

  /// No description provided for @profileParticipationsTab.
  ///
  /// In ca, this message translates to:
  /// **'Participacions'**
  String get profileParticipationsTab;

  /// No description provided for @profileEditTitle.
  ///
  /// In ca, this message translates to:
  /// **'Editar perfil'**
  String get profileEditTitle;

  /// No description provided for @profileEditSaveButton.
  ///
  /// In ca, this message translates to:
  /// **'Desar canvis'**
  String get profileEditSaveButton;

  /// No description provided for @profileEditSaveButtonLoading.
  ///
  /// In ca, this message translates to:
  /// **'Desant...'**
  String get profileEditSaveButtonLoading;

  /// No description provided for @profileEditSuccess.
  ///
  /// In ca, this message translates to:
  /// **'Perfil actualitzat correctament'**
  String get profileEditSuccess;

  /// No description provided for @profileEditError.
  ///
  /// In ca, this message translates to:
  /// **'No s\'ha pogut actualitzar el perfil'**
  String get profileEditError;

  /// No description provided for @profileLoadError.
  ///
  /// In ca, this message translates to:
  /// **'No s\'ha pogut carregar el perfil'**
  String get profileLoadError;

  /// No description provided for @profileObservationsEmpty.
  ///
  /// In ca, this message translates to:
  /// **'Encara no hi ha observacions.'**
  String get profileObservationsEmpty;

  /// No description provided for @profileRetry.
  ///
  /// In ca, this message translates to:
  /// **'Tornar a intentar'**
  String get profileRetry;

  /// No description provided for @profileSignOut.
  ///
  /// In ca, this message translates to:
  /// **'Tanca la sessió'**
  String get profileSignOut;

  /// No description provided for @settingsSupportTitle.
  ///
  /// In ca, this message translates to:
  /// **'Suport'**
  String get settingsSupportTitle;

  /// No description provided for @settingsHelp.
  ///
  /// In ca, this message translates to:
  /// **'Ajuda'**
  String get settingsHelp;

  /// No description provided for @settingsAbout.
  ///
  /// In ca, this message translates to:
  /// **'Acerca de Noctàmbuls'**
  String get settingsAbout;

  /// No description provided for @settingsTellAFriend.
  ///
  /// In ca, this message translates to:
  /// **'Digali a un amic'**
  String get settingsTellAFriend;

  /// No description provided for @settingsTellAFriendText.
  ///
  /// In ca, this message translates to:
  /// **'Descobreix Noctàmbuls, l\'app per registrar les teves observacions d\'ocells! 🦉'**
  String get settingsTellAFriendText;

  /// No description provided for @settingsLegalTitle.
  ///
  /// In ca, this message translates to:
  /// **'Legal'**
  String get settingsLegalTitle;

  /// No description provided for @settingsPrivacyPolicy.
  ///
  /// In ca, this message translates to:
  /// **'Política de privacitat'**
  String get settingsPrivacyPolicy;

  /// No description provided for @settingsTermsOfUse.
  ///
  /// In ca, this message translates to:
  /// **'Termes d\'ús'**
  String get settingsTermsOfUse;

  /// No description provided for @settingsNotifications.
  ///
  /// In ca, this message translates to:
  /// **'Notificacions'**
  String get settingsNotifications;

  /// No description provided for @notificationChannelSyncName.
  ///
  /// In ca, this message translates to:
  /// **'Sincronització'**
  String get notificationChannelSyncName;

  /// No description provided for @settingsDeleteAccount.
  ///
  /// In ca, this message translates to:
  /// **'Eliminar compte'**
  String get settingsDeleteAccount;

  /// No description provided for @settingsDeleteAccountDialogTitle.
  ///
  /// In ca, this message translates to:
  /// **'Eliminar compte?'**
  String get settingsDeleteAccountDialogTitle;

  /// No description provided for @settingsDeleteAccountDialogBody.
  ///
  /// In ca, this message translates to:
  /// **'Aquesta acció és irreversible. Totes les teves dades seran eliminades permanentment.'**
  String get settingsDeleteAccountDialogBody;

  /// No description provided for @settingsDeleteAccountDialogConfirm.
  ///
  /// In ca, this message translates to:
  /// **'Sí, eliminar'**
  String get settingsDeleteAccountDialogConfirm;

  /// No description provided for @settingsDeleteAccountError.
  ///
  /// In ca, this message translates to:
  /// **'No s\'ha pogut eliminar el compte. Torna-ho a intentar.'**
  String get settingsDeleteAccountError;

  /// No description provided for @newObservationTitle.
  ///
  /// In ca, this message translates to:
  /// **'Nova Observació'**
  String get newObservationTitle;

  /// No description provided for @editObservationTitle.
  ///
  /// In ca, this message translates to:
  /// **'Editar Observació'**
  String get editObservationTitle;

  /// No description provided for @saveObservation.
  ///
  /// In ca, this message translates to:
  /// **'Desar'**
  String get saveObservation;

  /// No description provided for @selectSpecies.
  ///
  /// In ca, this message translates to:
  /// **'Espècie'**
  String get selectSpecies;

  /// No description provided for @timeRangeLabel.
  ///
  /// In ca, this message translates to:
  /// **'Franja horària'**
  String get timeRangeLabel;

  /// No description provided for @quantityLabel.
  ///
  /// In ca, this message translates to:
  /// **'Quantitat'**
  String get quantityLabel;

  /// No description provided for @contactTypeLabel.
  ///
  /// In ca, this message translates to:
  /// **'Tipus de Contacte'**
  String get contactTypeLabel;

  /// No description provided for @locationLabel.
  ///
  /// In ca, this message translates to:
  /// **'Ubicació'**
  String get locationLabel;

  /// No description provided for @directionLabel.
  ///
  /// In ca, this message translates to:
  /// **'Direcció'**
  String get directionLabel;

  /// No description provided for @notesLabel.
  ///
  /// In ca, this message translates to:
  /// **'Notes'**
  String get notesLabel;

  /// No description provided for @notesHint.
  ///
  /// In ca, this message translates to:
  /// **'Afegeix notes...'**
  String get notesHint;

  /// No description provided for @fetchingLocation.
  ///
  /// In ca, this message translates to:
  /// **'Obtenint ubicació...'**
  String get fetchingLocation;

  /// No description provided for @locationUnavailable.
  ///
  /// In ca, this message translates to:
  /// **'Ubicació no disponible'**
  String get locationUnavailable;

  /// No description provided for @compassLabel.
  ///
  /// In ca, this message translates to:
  /// **'Orientació'**
  String get compassLabel;

  /// No description provided for @confirmDeleteObservationTitle.
  ///
  /// In ca, this message translates to:
  /// **'Vols eliminar l\'observació?'**
  String get confirmDeleteObservationTitle;

  /// No description provided for @confirmDeleteObservationMessage.
  ///
  /// In ca, this message translates to:
  /// **'Aquesta acció no es pot desfer.'**
  String get confirmDeleteObservationMessage;

  /// No description provided for @errorSavingObservation.
  ///
  /// In ca, this message translates to:
  /// **'Hi ha hagut un error al guardar l\'observació'**
  String get errorSavingObservation;

  /// No description provided for @visualContactType.
  ///
  /// In ca, this message translates to:
  /// **'Visual'**
  String get visualContactType;

  /// No description provided for @auditiveContactType.
  ///
  /// In ca, this message translates to:
  /// **'Auditiu'**
  String get auditiveContactType;

  /// No description provided for @reduceQuantityTooltip.
  ///
  /// In ca, this message translates to:
  /// **'Redueix la quantitat'**
  String get reduceQuantityTooltip;

  /// No description provided for @incrementQuantityTooltip.
  ///
  /// In ca, this message translates to:
  /// **'Augmenta la quantitat'**
  String get incrementQuantityTooltip;

  /// No description provided for @orientationTitle.
  ///
  /// In ca, this message translates to:
  /// **'Orientació'**
  String get orientationTitle;

  /// No description provided for @orientationHint.
  ///
  /// In ca, this message translates to:
  /// **'Toca per definir l\'orientació'**
  String get orientationHint;

  /// No description provided for @compassError.
  ///
  /// In ca, this message translates to:
  /// **'Error llegint els sensors.'**
  String get compassError;

  /// No description provided for @compassNoSensor.
  ///
  /// In ca, this message translates to:
  /// **'El dispositiu no té sensor de brúixola.'**
  String get compassNoSensor;

  /// No description provided for @compassInstruction.
  ///
  /// In ca, this message translates to:
  /// **'Apunta el telèfon cap a l\'observació i prem fixar.'**
  String get compassInstruction;

  /// No description provided for @compassFixDirection.
  ///
  /// In ca, this message translates to:
  /// **'Fixar Orientació'**
  String get compassFixDirection;

  /// No description provided for @locationDirectionTitle.
  ///
  /// In ca, this message translates to:
  /// **'Ubicació i Orientació'**
  String get locationDirectionTitle;

  /// No description provided for @orientationRequired.
  ///
  /// In ca, this message translates to:
  /// **'L\'orientació és obligatòria'**
  String get orientationRequired;

  /// No description provided for @updateGPS.
  ///
  /// In ca, this message translates to:
  /// **'Actualiza GPS'**
  String get updateGPS;

  /// No description provided for @updateOrientation.
  ///
  /// In ca, this message translates to:
  /// **'Modificar orientació'**
  String get updateOrientation;

  /// No description provided for @orientationValueLong.
  ///
  /// In ca, this message translates to:
  /// **'{orientation} {value}°'**
  String orientationValueLong(String orientation, String value);

  /// No description provided for @compassManualMode.
  ///
  /// In ca, this message translates to:
  /// **'Introduir manualment'**
  String get compassManualMode;

  /// No description provided for @compassDegreesHint.
  ///
  /// In ca, this message translates to:
  /// **'Graus'**
  String get compassDegreesHint;

  /// No description provided for @compassDegreesFormat.
  ///
  /// In ca, this message translates to:
  /// **'{value}° {orientation}'**
  String compassDegreesFormat(String orientation, String value);

  /// No description provided for @compassNoSensorFallback.
  ///
  /// In ca, this message translates to:
  /// **'No s\'ha detectat sensor. Ús manual requerit.'**
  String get compassNoSensorFallback;

  /// No description provided for @observationDateLabel.
  ///
  /// In ca, this message translates to:
  /// **'Data de l\'observació'**
  String get observationDateLabel;

  /// No description provided for @dayLabel.
  ///
  /// In ca, this message translates to:
  /// **'Dia'**
  String get dayLabel;

  /// No description provided for @startTimeLabel.
  ///
  /// In ca, this message translates to:
  /// **'Hora inici'**
  String get startTimeLabel;

  /// No description provided for @endTimeLabel.
  ///
  /// In ca, this message translates to:
  /// **'Hora fi'**
  String get endTimeLabel;

  /// No description provided for @changeDateLabel.
  ///
  /// In ca, this message translates to:
  /// **'Canvia la data'**
  String get changeDateLabel;

  /// No description provided for @obsCardQuantityLabel.
  ///
  /// In ca, this message translates to:
  /// **'x{value}'**
  String obsCardQuantityLabel(int value);

  /// No description provided for @statusObserving.
  ///
  /// In ca, this message translates to:
  /// **'En curs'**
  String get statusObserving;

  /// No description provided for @statusReviewing.
  ///
  /// In ca, this message translates to:
  /// **'En revisió'**
  String get statusReviewing;

  /// No description provided for @statusDraft.
  ///
  /// In ca, this message translates to:
  /// **'Esborrany'**
  String get statusDraft;

  /// No description provided for @statusPending.
  ///
  /// In ca, this message translates to:
  /// **'Pendent'**
  String get statusPending;

  /// No description provided for @statusSyncing.
  ///
  /// In ca, this message translates to:
  /// **'Sincronitzant'**
  String get statusSyncing;

  /// No description provided for @statusSynced.
  ///
  /// In ca, this message translates to:
  /// **'Sincronitzat'**
  String get statusSynced;

  /// No description provided for @statusSyncError.
  ///
  /// In ca, this message translates to:
  /// **'Error de xarxa'**
  String get statusSyncError;

  /// No description provided for @syncErrorValidation.
  ///
  /// In ca, this message translates to:
  /// **'Error a les dades.'**
  String get syncErrorValidation;

  /// No description provided for @syncErrorNetwork.
  ///
  /// In ca, this message translates to:
  /// **'Sense connexió. Es reintentarà més tard.'**
  String get syncErrorNetwork;

  /// No description provided for @syncErrorServer.
  ///
  /// In ca, this message translates to:
  /// **'S\'ha produït un error al servidor.'**
  String get syncErrorServer;

  /// No description provided for @syncErrorUnknown.
  ///
  /// In ca, this message translates to:
  /// **'Error desconegut a l\'hora de sincronitzar.'**
  String get syncErrorUnknown;

  /// No description provided for @notificationSyncPendingTitle.
  ///
  /// In ca, this message translates to:
  /// **'Sincronització pendent'**
  String get notificationSyncPendingTitle;

  /// No description provided for @notificationSyncPendingBody.
  ///
  /// In ca, this message translates to:
  /// **'{count, plural, =1{Tens 1 sessió pendent de pujar. Revisa-la quan puguis.} other{Tens {count} sessions pendents de pujar. Revisa-les quan puguis.}}'**
  String notificationSyncPendingBody(int count);

  /// No description provided for @notificationSyncErrorTitle.
  ///
  /// In ca, this message translates to:
  /// **'Error de sincronització'**
  String get notificationSyncErrorTitle;

  /// No description provided for @notificationSyncErrorBody.
  ///
  /// In ca, this message translates to:
  /// **'No hem pogut connectar amb el servidor per pujar les teves observacions.'**
  String get notificationSyncErrorBody;

  /// No description provided for @stopAndReviewTitle.
  ///
  /// In ca, this message translates to:
  /// **'Finalitzar observació'**
  String get stopAndReviewTitle;

  /// No description provided for @stopAndReviewMessage.
  ///
  /// In ca, this message translates to:
  /// **'Estàs segur que vols aturar el temps i passar a revisar les dades?'**
  String get stopAndReviewMessage;

  /// No description provided for @stopAndReviewConfirm.
  ///
  /// In ca, this message translates to:
  /// **'Finalitzar'**
  String get stopAndReviewConfirm;

  /// No description provided for @sessionCardEndsAt.
  ///
  /// In ca, this message translates to:
  /// **'Finalitzada a les '**
  String get sessionCardEndsAt;

  /// No description provided for @errorLoadingObservationSessions.
  ///
  /// In ca, this message translates to:
  /// **'Error carregant les sessions d\'observació'**
  String get errorLoadingObservationSessions;

  /// No description provided for @reviewMeteoTitle.
  ///
  /// In ca, this message translates to:
  /// **'Meteorologia'**
  String get reviewMeteoTitle;

  /// No description provided for @meteoTemp.
  ///
  /// In ca, this message translates to:
  /// **'Temperatura'**
  String get meteoTemp;

  /// No description provided for @meteoTempBelow0.
  ///
  /// In ca, this message translates to:
  /// **'< 0°C'**
  String get meteoTempBelow0;

  /// No description provided for @meteoTemp0to10.
  ///
  /// In ca, this message translates to:
  /// **'0–10°C'**
  String get meteoTemp0to10;

  /// No description provided for @meteoTemp10to20.
  ///
  /// In ca, this message translates to:
  /// **'10–20°C'**
  String get meteoTemp10to20;

  /// No description provided for @meteoTemp20to30.
  ///
  /// In ca, this message translates to:
  /// **'20–30°C'**
  String get meteoTemp20to30;

  /// No description provided for @meteoTempAbove30.
  ///
  /// In ca, this message translates to:
  /// **'> 30°C'**
  String get meteoTempAbove30;

  /// No description provided for @meteoWind.
  ///
  /// In ca, this message translates to:
  /// **'Vent'**
  String get meteoWind;

  /// No description provided for @meteoWindCalm.
  ///
  /// In ca, this message translates to:
  /// **'Calma'**
  String get meteoWindCalm;

  /// No description provided for @meteoWindBreeze.
  ///
  /// In ca, this message translates to:
  /// **'Brisa'**
  String get meteoWindBreeze;

  /// No description provided for @meteoWindModerate.
  ///
  /// In ca, this message translates to:
  /// **'Moderat'**
  String get meteoWindModerate;

  /// No description provided for @meteoSky.
  ///
  /// In ca, this message translates to:
  /// **'Cel'**
  String get meteoSky;

  /// No description provided for @meteoSkyClear.
  ///
  /// In ca, this message translates to:
  /// **'Serè'**
  String get meteoSkyClear;

  /// No description provided for @meteoSkyPartlyCloudy.
  ///
  /// In ca, this message translates to:
  /// **'Clarianes'**
  String get meteoSkyPartlyCloudy;

  /// No description provided for @meteoSkyOvercast.
  ///
  /// In ca, this message translates to:
  /// **'Cobert'**
  String get meteoSkyOvercast;

  /// No description provided for @meteoRain.
  ///
  /// In ca, this message translates to:
  /// **'Pluja'**
  String get meteoRain;

  /// No description provided for @meteoRainAbsence.
  ///
  /// In ca, this message translates to:
  /// **'Absència'**
  String get meteoRainAbsence;

  /// No description provided for @meteoRainDrizzle.
  ///
  /// In ca, this message translates to:
  /// **'Plovim'**
  String get meteoRainDrizzle;

  /// No description provided for @meteoRainStorm.
  ///
  /// In ca, this message translates to:
  /// **'Tempesta'**
  String get meteoRainStorm;

  /// No description provided for @meteoVisibility.
  ///
  /// In ca, this message translates to:
  /// **'Visibilitat'**
  String get meteoVisibility;

  /// No description provided for @meteoVisibilityPoor.
  ///
  /// In ca, this message translates to:
  /// **'Pèssima'**
  String get meteoVisibilityPoor;

  /// No description provided for @meteoVisibilityFair.
  ///
  /// In ca, this message translates to:
  /// **'Regular'**
  String get meteoVisibilityFair;

  /// No description provided for @meteoVisibilityGood.
  ///
  /// In ca, this message translates to:
  /// **'Bona'**
  String get meteoVisibilityGood;

  /// No description provided for @meteoMoon.
  ///
  /// In ca, this message translates to:
  /// **'Lluna'**
  String get meteoMoon;

  /// No description provided for @meteoMoonAbsence.
  ///
  /// In ca, this message translates to:
  /// **'Absent'**
  String get meteoMoonAbsence;

  /// No description provided for @meteoMoonPresence.
  ///
  /// In ca, this message translates to:
  /// **'Present'**
  String get meteoMoonPresence;

  /// No description provided for @listeningPointLabel.
  ///
  /// In ca, this message translates to:
  /// **'Punt d\'escolta'**
  String get listeningPointLabel;

  /// No description provided for @listeningPointHint.
  ///
  /// In ca, this message translates to:
  /// **'Número de punt'**
  String get listeningPointHint;

  /// No description provided for @reviewDeleteBtn.
  ///
  /// In ca, this message translates to:
  /// **'Cancel·lar sessió'**
  String get reviewDeleteBtn;

  /// No description provided for @reviewFinalizeBtn.
  ///
  /// In ca, this message translates to:
  /// **'Finalitzar'**
  String get reviewFinalizeBtn;

  /// No description provided for @reviewAddObservationBtn.
  ///
  /// In ca, this message translates to:
  /// **'Afegir'**
  String get reviewAddObservationBtn;

  /// No description provided for @reviewObservationsTitle.
  ///
  /// In ca, this message translates to:
  /// **'Observacions'**
  String get reviewObservationsTitle;

  /// No description provided for @confirmFinalizeTitle.
  ///
  /// In ca, this message translates to:
  /// **'Finalitzar sessió?'**
  String get confirmFinalizeTitle;

  /// No description provided for @confirmFinalizeMessage.
  ///
  /// In ca, this message translates to:
  /// **'Un cop finalitzada, la sessió no es podrà editar.'**
  String get confirmFinalizeMessage;

  /// No description provided for @confirmFinalizeConfirm.
  ///
  /// In ca, this message translates to:
  /// **'Finalitzar'**
  String get confirmFinalizeConfirm;

  /// No description provided for @requiredFieldError.
  ///
  /// In ca, this message translates to:
  /// **'Camp obligatori'**
  String get requiredFieldError;

  /// No description provided for @reviewErrorSaving.
  ///
  /// In ca, this message translates to:
  /// **'Error guardant la revisió'**
  String get reviewErrorSaving;

  /// No description provided for @reviewLocationIncidentalTitle.
  ///
  /// In ca, this message translates to:
  /// **'Ubicació de les observacions'**
  String get reviewLocationIncidentalTitle;

  /// No description provided for @reviewLocationSessionTitle.
  ///
  /// In ca, this message translates to:
  /// **'Ubicació de la sessió'**
  String get reviewLocationSessionTitle;

  /// No description provided for @reviewLocationRequiredError.
  ///
  /// In ca, this message translates to:
  /// **'Cal establir la ubicació de la sessió per finalitzar.'**
  String get reviewLocationRequiredError;

  /// No description provided for @reviewLocationModify.
  ///
  /// In ca, this message translates to:
  /// **'Modificar sessió'**
  String get reviewLocationModify;

  /// No description provided for @reviewLocationMissing.
  ///
  /// In ca, this message translates to:
  /// **'Sense ubicació'**
  String get reviewLocationMissing;

  /// No description provided for @reviewLocationIncidentalMissingDesc.
  ///
  /// In ca, this message translates to:
  /// **'Afegeix ubicacions editant cadascuna de les observacions del llistat inferior.'**
  String get reviewLocationIncidentalMissingDesc;

  /// No description provided for @reviewLocationSessionMissingDesc.
  ///
  /// In ca, this message translates to:
  /// **'La sessió no té coordenades registrades.'**
  String get reviewLocationSessionMissingDesc;

  /// No description provided for @reviewLocationSetMap.
  ///
  /// In ca, this message translates to:
  /// **'Establir al Mapa'**
  String get reviewLocationSetMap;

  /// No description provided for @reviewLocationNoInternet.
  ///
  /// In ca, this message translates to:
  /// **'Sense connexió'**
  String get reviewLocationNoInternet;

  /// No description provided for @reviewLocationNoInternetDesc.
  ///
  /// In ca, this message translates to:
  /// **'El mapa de previsualització requereix internet. Tot i això, les coordenades guardades als registres són segures.'**
  String get reviewLocationNoInternetDesc;

  /// No description provided for @reviewMissingLocationsIncidental.
  ///
  /// In ca, this message translates to:
  /// **'Cal afegir la ubicació a les observacions marcades en vermell.'**
  String get reviewMissingLocationsIncidental;

  /// No description provided for @participantsTitle.
  ///
  /// In ca, this message translates to:
  /// **'Participants'**
  String get participantsTitle;

  /// No description provided for @addParticipant.
  ///
  /// In ca, this message translates to:
  /// **'Afegir'**
  String get addParticipant;

  /// No description provided for @noParticipantsAdded.
  ///
  /// In ca, this message translates to:
  /// **'No hi ha participants afegits.'**
  String get noParticipantsAdded;

  /// No description provided for @participantAlreadyAdded.
  ///
  /// In ca, this message translates to:
  /// **'Aquest participant ja està afegit.'**
  String get participantAlreadyAdded;

  /// No description provided for @scannerTitle.
  ///
  /// In ca, this message translates to:
  /// **'Escanejar Participant'**
  String get scannerTitle;

  /// No description provided for @invalidQrCode.
  ///
  /// In ca, this message translates to:
  /// **'Codi QR no vàlid per aquesta app.'**
  String get invalidQrCode;

  /// No description provided for @enterCodeManually.
  ///
  /// In ca, this message translates to:
  /// **'Introduir codi manualment'**
  String get enterCodeManually;

  /// No description provided for @enterCodeTitle.
  ///
  /// In ca, this message translates to:
  /// **'Introduir Codi'**
  String get enterCodeTitle;

  /// No description provided for @codeHint.
  ///
  /// In ca, this message translates to:
  /// **'#OR-ABC-1234'**
  String get codeHint;

  /// No description provided for @emptyCodeError.
  ///
  /// In ca, this message translates to:
  /// **'Introdueix un codi.'**
  String get emptyCodeError;

  /// No description provided for @invalidCodeFormat.
  ///
  /// In ca, this message translates to:
  /// **'Format invàlid. Ex: #OR-ABCD-1234'**
  String get invalidCodeFormat;

  /// No description provided for @add.
  ///
  /// In ca, this message translates to:
  /// **'Afegir'**
  String get add;

  /// No description provided for @scannerHelperText.
  ///
  /// In ca, this message translates to:
  /// **'Escaneja el QR d\'ornitòleg del perfil del participant'**
  String get scannerHelperText;

  /// No description provided for @scannerHelpTitle.
  ///
  /// In ca, this message translates to:
  /// **'Com afegir un participant?'**
  String get scannerHelpTitle;

  /// No description provided for @scannerHelpMessage.
  ///
  /// In ca, this message translates to:
  /// **'Demana a l\'altre usuari que obri el seu perfil per mostrar el seu codi QR i apunta-hi amb la càmera. Si la càmera no funciona o no detecta el codi, pots introduir-lo manualment prement el botó inferior.'**
  String get scannerHelpMessage;

  /// No description provided for @understood.
  ///
  /// In ca, this message translates to:
  /// **'Entesos'**
  String get understood;

  /// No description provided for @locationErrorTooltip.
  ///
  /// In ca, this message translates to:
  /// **'Error de GPS'**
  String get locationErrorTooltip;

  /// No description provided for @locationManualTooltip.
  ///
  /// In ca, this message translates to:
  /// **'Ubicació Manual'**
  String get locationManualTooltip;

  /// No description provided for @locationAutoTooltip.
  ///
  /// In ca, this message translates to:
  /// **'Ubicació Automàtica (GPS)'**
  String get locationAutoTooltip;

  /// No description provided for @locationGpsOffTitle.
  ///
  /// In ca, this message translates to:
  /// **'Activa la ubicació del dispositiu'**
  String get locationGpsOffTitle;

  /// No description provided for @locationGpsOffContent.
  ///
  /// In ca, this message translates to:
  /// **'La ubicació del dispositiu està desactivada. Per poder registrar coordenades precises a les observacions i sessions, activa el GPS des de la configuració del telèfon i torna a intentar-ho.'**
  String get locationGpsOffContent;

  /// No description provided for @locationPermissionTitle.
  ///
  /// In ca, this message translates to:
  /// **'Permís d\'ubicació necessari'**
  String get locationPermissionTitle;

  /// No description provided for @locationPermissionContent.
  ///
  /// In ca, this message translates to:
  /// **'Noctàmbuls necessita accés a la ubicació per guardar la posició exacta de les observacions d\'ocells i de les sessions de cens.\n\nHas denegat el permís de manera permanent. Per continuar, obre la configuració del dispositiu i habilita el permís d\'ubicació per a l\'aplicació.'**
  String get locationPermissionContent;

  /// No description provided for @actionLater.
  ///
  /// In ca, this message translates to:
  /// **'Ara no'**
  String get actionLater;

  /// No description provided for @actionOpenSettings.
  ///
  /// In ca, this message translates to:
  /// **'Obrir configuració'**
  String get actionOpenSettings;

  /// No description provided for @observationLocationTitle.
  ///
  /// In ca, this message translates to:
  /// **'Ubicació de l\'observació'**
  String get observationLocationTitle;

  /// No description provided for @observationAtLocationToggle.
  ///
  /// In ca, this message translates to:
  /// **'Sóc al lloc exacte de l\'ocell'**
  String get observationAtLocationToggle;

  /// No description provided for @locationWaitingGps.
  ///
  /// In ca, this message translates to:
  /// **'Esperant senyal GPS...'**
  String get locationWaitingGps;

  /// No description provided for @locationMapRequired.
  ///
  /// In ca, this message translates to:
  /// **'Falta marcar el punt al mapa'**
  String get locationMapRequired;

  /// No description provided for @locationModifyMap.
  ///
  /// In ca, this message translates to:
  /// **'Modificar al mapa'**
  String get locationModifyMap;

  /// No description provided for @locationOpenMap.
  ///
  /// In ca, this message translates to:
  /// **'Obrir el mapa'**
  String get locationOpenMap;

  /// No description provided for @locationErrorPermission.
  ///
  /// In ca, this message translates to:
  /// **'Permisos de GPS denegats. Activa\'ls als ajustos o usa el mapa.'**
  String get locationErrorPermission;

  /// No description provided for @locationErrorDisabled.
  ///
  /// In ca, this message translates to:
  /// **'El GPS està apagat. Activa\'l o usa el mapa.'**
  String get locationErrorDisabled;

  /// No description provided for @locationErrorTimeout.
  ///
  /// In ca, this message translates to:
  /// **'Sense senyal GPS. Selecciona la ubicació manualment al mapa.'**
  String get locationErrorTimeout;

  /// No description provided for @permissionsRequired.
  ///
  /// In ca, this message translates to:
  /// **'Permisos necessaris'**
  String get permissionsRequired;

  /// No description provided for @gpsDisabled.
  ///
  /// In ca, this message translates to:
  /// **'GPS desactivat'**
  String get gpsDisabled;

  /// No description provided for @locationManualTitle.
  ///
  /// In ca, this message translates to:
  /// **'Ubicació manual'**
  String get locationManualTitle;

  /// No description provided for @locationAutoTitle.
  ///
  /// In ca, this message translates to:
  /// **'Ubicació automàtica'**
  String get locationAutoTitle;

  /// No description provided for @mapPickerTitle.
  ///
  /// In ca, this message translates to:
  /// **'Seleccionar ubicació'**
  String get mapPickerTitle;

  /// No description provided for @mapPickerConfirm.
  ///
  /// In ca, this message translates to:
  /// **'Confirmar ubicació'**
  String get mapPickerConfirm;

  /// No description provided for @mapPickerSelectPoint.
  ///
  /// In ca, this message translates to:
  /// **'Mantén premut per col·locar el marcador'**
  String get mapPickerSelectPoint;

  /// No description provided for @mapPickerHelpTitle.
  ///
  /// In ca, this message translates to:
  /// **'Com utilitzar el mapa'**
  String get mapPickerHelpTitle;

  /// No description provided for @mapPickerHelpContent.
  ///
  /// In ca, this message translates to:
  /// **'Mantén premut a qualsevol punt del mapa per col·locar el marcador. Pots utilitzar el botó de la diana per centrar el mapa a la teva posició actual.'**
  String get mapPickerHelpContent;

  /// No description provided for @ok.
  ///
  /// In ca, this message translates to:
  /// **'D\'acord'**
  String get ok;

  /// No description provided for @censusSessionExistentWarning.
  ///
  /// In ca, this message translates to:
  /// **'Ja existeix una sessió d\'aquest cens.'**
  String get censusSessionExistentWarning;

  /// No description provided for @censusConfirmStartTitle.
  ///
  /// In ca, this message translates to:
  /// **'Segur que vols iniciar la sessió d\'observació ara?'**
  String get censusConfirmStartTitle;

  /// No description provided for @censusConfirmStartButton.
  ///
  /// In ca, this message translates to:
  /// **'Sí, iniciar'**
  String get censusConfirmStartButton;

  /// No description provided for @censusDetailTitle.
  ///
  /// In ca, this message translates to:
  /// **'Detall del cens'**
  String get censusDetailTitle;

  /// No description provided for @censusDescriptionTitle.
  ///
  /// In ca, this message translates to:
  /// **'Descripció'**
  String get censusDescriptionTitle;

  /// No description provided for @censusNoDescription.
  ///
  /// In ca, this message translates to:
  /// **'Aquest cens no té cap descripció afegida.'**
  String get censusNoDescription;

  /// No description provided for @censusesUpcomingTitle.
  ///
  /// In ca, this message translates to:
  /// **'Pròxims censos'**
  String get censusesUpcomingTitle;

  /// No description provided for @censusLobbyWaiting.
  ///
  /// In ca, this message translates to:
  /// **'Cens en espera'**
  String get censusLobbyWaiting;

  /// No description provided for @censusEnterLobby.
  ///
  /// In ca, this message translates to:
  /// **'Entrar'**
  String get censusEnterLobby;

  /// No description provided for @censusAbandon.
  ///
  /// In ca, this message translates to:
  /// **'Cancel·lar'**
  String get censusAbandon;

  /// No description provided for @censusStartSession.
  ///
  /// In ca, this message translates to:
  /// **'Iniciar sessió'**
  String get censusStartSession;

  /// No description provided for @censusWarningPoint.
  ///
  /// In ca, this message translates to:
  /// **'Si us plau, no iniciïs la sessió fins que no estiguis al punt d\'escolta i sigui l\'hora acordada per començar el cens.'**
  String get censusWarningPoint;

  /// No description provided for @censusDirectionLabel.
  ///
  /// In ca, this message translates to:
  /// **'Direcció:'**
  String get censusDirectionLabel;

  /// No description provided for @censusNotTodayBody.
  ///
  /// In ca, this message translates to:
  /// **'Aquest cens no té lloc avui. Comprova la data i torna-ho a intentar el dia de la jornada.'**
  String get censusNotTodayBody;

  /// No description provided for @censusLobbyConflictBody.
  ///
  /// In ca, this message translates to:
  /// **'Ja estàs inscrit a un altre cens. Cancel·la\'l abans d\'unir-te a un nou cens.'**
  String get censusLobbyConflictBody;

  /// No description provided for @censusAlreadySessionActive.
  ///
  /// In ca, this message translates to:
  /// **'Tanca la sessió activa abans d\'iniciar la del cens.'**
  String get censusAlreadySessionActive;

  /// No description provided for @censusInvalidTokenBody.
  ///
  /// In ca, this message translates to:
  /// **'El codi QR o l\'enllaç del cens no s\'ha pogut verificar. Assegura\'t que és correcte.'**
  String get censusInvalidTokenBody;

  /// No description provided for @censusQrScanTitle.
  ///
  /// In ca, this message translates to:
  /// **'Escaneja el QR del cens'**
  String get censusQrScanTitle;

  /// No description provided for @censusQrScanHelper.
  ///
  /// In ca, this message translates to:
  /// **'Apunta la càmera al codi QR del cens'**
  String get censusQrScanHelper;

  /// No description provided for @censusQrHelpTitle.
  ///
  /// In ca, this message translates to:
  /// **'Com unir-se al cens?'**
  String get censusQrHelpTitle;

  /// No description provided for @censusQrHelpBody.
  ///
  /// In ca, this message translates to:
  /// **'Escaneja el codi QR compartit pel coordinador o la coordinadora del cens. Si no pots escanejar-lo, també pots obrir l’enllaç URL que hagi compartit.'**
  String get censusQrHelpBody;

  /// No description provided for @exploreTitle.
  ///
  /// In ca, this message translates to:
  /// **'Explora'**
  String get exploreTitle;

  /// No description provided for @exploreAllSpecies.
  ///
  /// In ca, this message translates to:
  /// **'Totes les espècies'**
  String get exploreAllSpecies;

  /// No description provided for @exploreHistoric.
  ///
  /// In ca, this message translates to:
  /// **'Històric'**
  String get exploreHistoric;

  /// No description provided for @exploreBreakdownTitle.
  ///
  /// In ca, this message translates to:
  /// **'Observacions Registrades'**
  String get exploreBreakdownTitle;

  /// No description provided for @exploreKpiSpecies.
  ///
  /// In ca, this message translates to:
  /// **'Espècies'**
  String get exploreKpiSpecies;

  /// No description provided for @exploreKpiObservations.
  ///
  /// In ca, this message translates to:
  /// **'Observacions'**
  String get exploreKpiObservations;

  /// No description provided for @exploreSyncing.
  ///
  /// In ca, this message translates to:
  /// **'Carregant dades...'**
  String get exploreSyncing;

  /// No description provided for @exploreSyncError.
  ///
  /// In ca, this message translates to:
  /// **'Error en carregar les dades'**
  String get exploreSyncError;

  /// No description provided for @exploreNoData.
  ///
  /// In ca, this message translates to:
  /// **'Sense dades d\'observació'**
  String get exploreNoData;

  /// No description provided for @exploreRetry.
  ///
  /// In ca, this message translates to:
  /// **'Tornar a intentar'**
  String get exploreRetry;

  /// No description provided for @exploreNoInternet.
  ///
  /// In ca, this message translates to:
  /// **'Sense connexió'**
  String get exploreNoInternet;

  /// No description provided for @exploreNoInternetDesc.
  ///
  /// In ca, this message translates to:
  /// **'El mapa requereix connexió a internet per visualitzar-se.'**
  String get exploreNoInternetDesc;

  /// No description provided for @exploreBubbleObservations.
  ///
  /// In ca, this message translates to:
  /// **'{count} observacions'**
  String exploreBubbleObservations(int count);

  /// No description provided for @exploreMapPickerHelpTitle.
  ///
  /// In ca, this message translates to:
  /// **'Com funciona l\'explorador?'**
  String get exploreMapPickerHelpTitle;

  /// No description provided for @exploreMapPickerHelpContent.
  ///
  /// In ca, this message translates to:
  /// **'Navega pel mapa per descobrir on s\'han observat les diferents espècies. \n\n• La mida de les bombolles canvien segons la quantitat d\'observacions.\n• Toca qualsevol bombolla per veure\'n el resum exacte.\n• Fes servir el panell inferior per filtrar els resultats per una espècie concreta o per l\'any d\'observació.'**
  String get exploreMapPickerHelpContent;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ca', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ca':
      return AppLocalizationsCa();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
