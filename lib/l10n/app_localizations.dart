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

  /// No description provided for @settingsTitle.
  ///
  /// In ca, this message translates to:
  /// **'Configuració'**
  String get settingsTitle;

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

  /// No description provided for @censusLabel.
  ///
  /// In ca, this message translates to:
  /// **'Cens'**
  String get censusLabel;

  /// No description provided for @stationLabel.
  ///
  /// In ca, this message translates to:
  /// **'Estació de Seguiment'**
  String get stationLabel;

  /// No description provided for @incidentalLabel.
  ///
  /// In ca, this message translates to:
  /// **'Observació Incidental'**
  String get incidentalLabel;

  /// No description provided for @homeTitle.
  ///
  /// In ca, this message translates to:
  /// **'Inici'**
  String get homeTitle;

  /// No description provided for @errorSessionAlreadyExists.
  ///
  /// In ca, this message translates to:
  /// **'Ja hi ha una sessió activa. Finalitza-la o cancel·la-la primer.'**
  String get errorSessionAlreadyExists;

  /// No description provided for @errorUnknown.
  ///
  /// In ca, this message translates to:
  /// **'S\'ha produït un error desconegut.'**
  String get errorUnknown;

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

  /// No description provided for @stopAndReview.
  ///
  /// In ca, this message translates to:
  /// **'Aturar'**
  String get stopAndReview;

  /// No description provided for @deleteSession.
  ///
  /// In ca, this message translates to:
  /// **'Cancel·lar Sessió'**
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

  /// No description provided for @confirmDelete.
  ///
  /// In ca, this message translates to:
  /// **'Sí, elimina'**
  String get confirmDelete;

  /// No description provided for @confirmDeleteSessionMessage.
  ///
  /// In ca, this message translates to:
  /// **'Es perdran totes les observacions d\'aquesta sessió. Aquesta acció no es pot desfer.'**
  String get confirmDeleteSessionMessage;

  /// No description provided for @confirmDeleteSessionTitle.
  ///
  /// In ca, this message translates to:
  /// **'Vols eliminar la sessió?'**
  String get confirmDeleteSessionTitle;

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

  /// No description provided for @continueObserving.
  ///
  /// In ca, this message translates to:
  /// **'Continuar observant'**
  String get continueObserving;

  /// No description provided for @observingTitle.
  ///
  /// In ca, this message translates to:
  /// **'Observant'**
  String get observingTitle;

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
