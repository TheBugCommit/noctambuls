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
  /// **'Observant des de {time}'**
  String startedAt(String time);

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
