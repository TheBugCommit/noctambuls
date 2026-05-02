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
  String get cancel => 'Cancelar';

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

  @override
  String get noImageAvailable => 'La imagen no esta disponible';

  @override
  String get downloadingCatalog => 'Descargando los pájaros...';

  @override
  String get connectionError => 'Error de connexion';

  @override
  String get catalogDownloadError =>
      'No se ha podido descargar el catálago de pájaros. Comprueba tu connexion a internet.';

  @override
  String get retry => 'Volver a intentar';

  @override
  String get ignore => 'Ignorar';

  @override
  String get requiredBirdCatalog => 'Catálago de pájaros requerido';

  @override
  String get requiredBirdCatalogMsg =>
      'Para usar esta sección necessitas descargar el catálago de pájaros almenos una vez.';

  @override
  String get downloadNow => 'Descargar ahora';

  @override
  String get homeErrorDownloadCatalog =>
      'Descarga del catálogo de pájaros fallida';

  @override
  String get homeErrorDownloadCatalogMsg =>
      'No se ha podido descargar el catálago de pájaros. Puedes seguir usando la aplicación o volver a intentar la descarga.';

  @override
  String get usageWarningTitle => 'Advertencia de uso';

  @override
  String get usageWarningMessage =>
      'La reproducción de este audio durante un censo puede alterar el comportamiento de las aves y distorsionar los resultados de la observación.\n\nPor favor, haz un uso responsable.';

  @override
  String get usageWarningConfirm => 'Sí, lo entiendo';

  @override
  String get cantOpenLink => 'No se ha podido abrir el enlace';

  @override
  String get cantPlayAudio => 'No se ha podido reproducir el audio';

  @override
  String get stopPlayingAudio => 'Detener';

  @override
  String get observingMethodTitle => 'Sobre los métodos de observación';

  @override
  String get observingMethodConfirmLabel => 'Entendido';

  @override
  String get observingMethodCensTitle => 'Censo';

  @override
  String get observingMethodCensDescription =>
      'Es un trabajo coordinado entre varios grupos de personas en puntos fijos de forma simultánea. Se utiliza en campañas oficiales o jornadas de censo colectivo privadas.';

  @override
  String get observingMethodESTitle => 'Estación de Seguimiento';

  @override
  String get observingMethodESDescription =>
      'Es una observación típicamente individual desde un único punto fijo durante un tiempo determinado. Se utiliza para muestreos repetitivos en el mismo lugar.';

  @override
  String get observingMethodIncTitle => 'Observación incidental';

  @override
  String get observingMethodIncDescription =>
      'Es una observación inesperada o aislada mientras realizas otra actividad. Úsalo cuando veas un ave de forma casual y quieras anotarlo rápidamente sin seguir un protocolo fijo.';

  @override
  String get loginTitle => 'Bienvenido/a';

  @override
  String get loginSubtitle => 'Inicia sesión para continuar';

  @override
  String get signInWithGoogle => 'Iniciar sesión con Google';

  @override
  String get signInError => 'No se pudo iniciar sesión. Inténtalo de nuevo.';

  @override
  String get signOutLabel => 'Cerrar sesión';

  @override
  String get signUpTitle => 'Completa tu perfil';

  @override
  String get signUpSessionExpired =>
      'La sesión ha caducado, por favor, vuelve a iniciar sesión';

  @override
  String get signUpError => 'Se ha producido un error. Vuelve a intentarlo.';

  @override
  String get signUpHeaderTitle => '¡Ya casi estamos!';

  @override
  String get signUpHeaderSubTitle =>
      'Necesitamos algunos datos básicos para finalizar tu registro.';

  @override
  String get signUpFormNameLabel => 'Nombre completo';

  @override
  String get signUpFormNameLength =>
      'El nombre debe tener al menos 3 caracteres';

  @override
  String get signUpFormFieldRequired => 'Este campo es obligatorio';

  @override
  String get signUpFormPhoneLabel => 'Teléfono';

  @override
  String get signUpFormPhoneFormat => 'Introduce un teléfono válido';

  @override
  String get signUpSendButton => 'Finalizar registro';

  @override
  String get signUpSendButtonLoading => 'Registrando...';
}
