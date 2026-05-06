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
  String get errorUnknown => 'Se ha producido un error desconocido.';

  @override
  String get back => 'Volver';

  @override
  String get delete => 'Eliminar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get retry => 'Volver a intentar';

  @override
  String get ignore => 'Ignorar';

  @override
  String get confirmDelete => 'Sí, eliminar';

  @override
  String get homeLabel => 'Inicio';

  @override
  String get guideLabel => 'Guía';

  @override
  String get exploreLabel => 'Explora';

  @override
  String get profileLabel => 'Perfil';

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
  String get signUpFormNameMaxLength =>
      'El nombre no debe superar los 40 caracteres';

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

  @override
  String get accept_terms_prefix => 'He leído y acepto los ';

  @override
  String get terms_and_conditions => 'Términos y Condiciones';

  @override
  String get settingsTitle => 'Configuración';

  @override
  String get settingsPreferencesTitle => 'Preferencias';

  @override
  String get settingsAccountTitle => 'Cuenta';

  @override
  String get languageLabel => 'Idioma';

  @override
  String get systemLabel => 'Sistema';

  @override
  String get catalanLabel => 'Catalán';

  @override
  String get spanishLabel => 'Castellano';

  @override
  String get themeLabel => 'Tema visual';

  @override
  String get themeLightLabel => 'Claro';

  @override
  String get themeDarkLabel => 'Oscuro';

  @override
  String get themeSystemLabel => 'Sistema';

  @override
  String get homeTitle => 'Inicio';

  @override
  String get censusLabel => 'Censo';

  @override
  String get stationLabel => 'Estación de seguimiento';

  @override
  String get incidentalLabel => 'Observación incidental';

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
  String get observingMethodESTitle => 'Estación de seguimiento';

  @override
  String get observingMethodESDescription =>
      'Es una observación típicamente individual desde un único punto fijo durante un tiempo determinado. Se utiliza para muestreos repetitivos en el mismo lugar.';

  @override
  String get observingMethodIncTitle => 'Observación incidental';

  @override
  String get observingMethodIncDescription =>
      'Es una observación inesperada o aislada mientras realizas otra actividad. Úsalo cuando veas un ave de forma casual y quieras anotarlo rápidamente sin seguir un protocolo fijo.';

  @override
  String get activeSessionTitle => 'Sesión en curso';

  @override
  String startedAt(String time) {
    return 'Observando desde $time';
  }

  @override
  String get errorSessionAlreadyExists =>
      'Ya hay una sesión activa. Finalízala o cancélala primero.';

  @override
  String observationsRegistered(int count) {
    return '$count observaciones registradas';
  }

  @override
  String get noObservationsRegistered =>
      'No hay ninguna observación registrada';

  @override
  String get observingTitle => 'Observando';

  @override
  String get stopAndReview => 'Detener';

  @override
  String get continueObserving => 'Continuar observando';

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
  String get deleteSession => 'Cancelar sesión';

  @override
  String get deleteSessionTitle => '¿Cancelar sesión?';

  @override
  String get deleteSessionBody =>
      'Se perderá toda la información y no se podrá recuperar.';

  @override
  String get confirmDeleteSessionTitle => '¿Quieres eliminar la sesión?';

  @override
  String get confirmDeleteSessionMessage =>
      'Se perderán todas las observaciones de esta sesión. Esta acción es irreversible.';

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
  String get noImageAvailable => 'La imagen no está disponible';

  @override
  String get downloadingCatalog => 'Descargando las aves...';

  @override
  String get connectionError => 'Error de conexión';

  @override
  String get catalogDownloadError =>
      'No se ha podido descargar el catálogo de aves. Comprueba tu conexión a internet.';

  @override
  String get requiredBirdCatalog => 'Catálogo de aves requerido';

  @override
  String get requiredBirdCatalogMsg =>
      'Para usar esta sección necesitas descargar el catálogo de aves al menos una vez.';

  @override
  String get downloadNow => 'Descargar ahora';

  @override
  String get homeErrorDownloadCatalog =>
      'Descarga del catálogo de aves fallida';

  @override
  String get homeErrorDownloadCatalogMsg =>
      'No se ha podido descargar el catálogo de aves. Puedes seguir usando la aplicación o volver a intentar la descarga.';

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
  String get profileOrnithologistCode => 'Código de ornitólogo';

  @override
  String get profileShowQr => 'Mostrar QR';

  @override
  String get profileQrDialogTitle => 'Código QR de ornitólogo';

  @override
  String get profileQrDialogClose => 'Cerrar';

  @override
  String get profileObservationsTab => 'Observaciones';

  @override
  String get profileParticipationsTab => 'Participaciones';

  @override
  String get profileEditTitle => 'Editar perfil';

  @override
  String get profileEditSaveButton => 'Guardar cambios';

  @override
  String get profileEditSaveButtonLoading => 'Guardando...';

  @override
  String get profileEditSuccess => 'Perfil actualizado correctamente';

  @override
  String get profileEditError => 'No se pudo actualizar el perfil';

  @override
  String get profileLoadError => 'No se pudo cargar el perfil';

  @override
  String get profileObservationsEmpty => 'Aún no hay observaciones.';

  @override
  String get profileRetry => 'Volver a intentar';

  @override
  String get profileSignOut => 'Cerrar sesión';

  @override
  String get settingsSupportTitle => 'Soporte';

  @override
  String get settingsHelp => 'Ayuda';

  @override
  String get settingsAbout => 'Acerca de Noctámbulos';

  @override
  String get settingsTellAFriend => 'Díselo a un amigo';

  @override
  String get settingsTellAFriendText =>
      '¡Descubre Noctámbulos, la app para registrar tus observaciones de aves! 🦉';

  @override
  String get settingsLegalTitle => 'Legal';

  @override
  String get settingsPrivacyPolicy => 'Política de privacidad';

  @override
  String get settingsTermsOfUse => 'Términos de uso';

  @override
  String get settingsDeleteAccount => 'Eliminar cuenta';

  @override
  String get settingsDeleteAccountDialogTitle => '¿Eliminar cuenta?';

  @override
  String get settingsDeleteAccountDialogBody =>
      'Esta acción es irreversible. Todos tus datos serán eliminados permanentemente.';

  @override
  String get settingsDeleteAccountDialogConfirm => 'Sí, eliminar';

  @override
  String get settingsDeleteAccountError =>
      'No se pudo eliminar la cuenta. Inténtalo de nuevo.';

  @override
  String get newObservationTitle => 'Nueva Observación';

  @override
  String get editObservationTitle => 'Editar Observación';

  @override
  String get saveObservation => 'Guardar';

  @override
  String get selectSpecies => 'Especie';

  @override
  String get timeRangeLabel => 'Franja horaria';

  @override
  String get quantityLabel => 'Cantidad';

  @override
  String get contactTypeLabel => 'Tipo de Contacto';

  @override
  String get locationLabel => 'Ubicación';

  @override
  String get directionLabel => 'Dirección';

  @override
  String get notesLabel => 'Notas';

  @override
  String get notesHint => 'Añade notas...';

  @override
  String get fetchingLocation => 'Obteniendo ubicación...';

  @override
  String get locationUnavailable => 'Ubicación no disponible';

  @override
  String get compassLabel => 'Orientación';

  @override
  String get confirmDeleteObservationTitle =>
      '¿Quieres eliminar la observación?';

  @override
  String get confirmDeleteObservationMessage =>
      'Esta acción no se puede deshacer.';

  @override
  String get errorSavingObservation =>
      'Ha ocurido un error al guardar la observacion';

  @override
  String get visualContactType => 'Visual';

  @override
  String get auditiveContactType => 'Auditivo';

  @override
  String get reduceQuantityTooltip => 'Reduece la cantidad';

  @override
  String get incrementQuantityTooltip => 'Incrementa la cantidad';

  @override
  String get orientationTitle => 'Orientación';

  @override
  String get orientationHint => 'Toca para definir la orientación';

  @override
  String get compassError => 'Error leyendo los sensores.';

  @override
  String get compassNoSensor => 'El dispositivo no tiene sensor de brújula.';

  @override
  String get compassInstruction =>
      'Apunta el teléfono hacia la observación y pulsa fijar.';

  @override
  String get compassFixDirection => 'Fijar Dirección';

  @override
  String get locationDirectionTitle => 'Ubicación y Orientación';

  @override
  String get orientationRequired => 'La orientación es obligatoria';

  @override
  String get updateGPS => 'Actualizar GPS';

  @override
  String get updateOrientation => 'Modificar Orientación';

  @override
  String orientationValueLong(String orientation, String value) {
    return '$orientation $value°';
  }

  @override
  String get observationDateLabel => 'Fecha de la observación';

  @override
  String get dayLabel => 'Día';

  @override
  String get startTimeLabel => 'Hora inicio';

  @override
  String get endTimeLabel => 'Hora fin';

  @override
  String get changeDateLabel => 'Cambiar fecha';

  @override
  String obsCardQuantityLabel(int value) {
    return 'x$value';
  }

  @override
  String get statusObserving => 'En curso';

  @override
  String get statusReviewing => 'En revisión';

  @override
  String get statusDraft => 'Borrador';

  @override
  String get statusPending => 'Pendiente';

  @override
  String get statusSynced => 'Sincronizado';

  @override
  String get statusSyncError => 'Error de red';

  @override
  String get stopAndReviewTitle => 'Finalizar observación';

  @override
  String get stopAndReviewMessage =>
      '¿Estás seguro de que quieres detener el tiempo y pasar a revisar los datos?';

  @override
  String get stopAndReviewConfirm => 'Finalizar';

  @override
  String get sessionCardEndsAt => 'Finalitzada a las ';

  @override
  String get errorLoadingObservationSessions =>
      'Error cargando las sessiones de observación';

  @override
  String get reviewMeteoTitle => 'Meteorología';

  @override
  String get meteoTemp => 'Temperatura';

  @override
  String get meteoTempBelow0 => '< 0°C';

  @override
  String get meteoTemp0to10 => '0–10°C';

  @override
  String get meteoTemp10to20 => '10–20°C';

  @override
  String get meteoTemp20to30 => '20–30°C';

  @override
  String get meteoTempAbove30 => '> 30°C';

  @override
  String get meteoWind => 'Viento';

  @override
  String get meteoWindCalm => 'Calma';

  @override
  String get meteoWindBreeze => 'Brisa';

  @override
  String get meteoWindModerate => 'Moderado';

  @override
  String get meteoSky => 'Cielo';

  @override
  String get meteoSkyClear => 'Despejado';

  @override
  String get meteoSkyPartlyCloudy => 'Claros';

  @override
  String get meteoSkyOvercast => 'Cubierto';

  @override
  String get meteoRain => 'Lluvia';

  @override
  String get meteoRainAbsence => 'Ausencia';

  @override
  String get meteoRainDrizzle => 'Llovizna';

  @override
  String get meteoRainStorm => 'Tormenta';

  @override
  String get meteoVisibility => 'Visibilidad';

  @override
  String get meteoVisibilityPoor => 'Pésima';

  @override
  String get meteoVisibilityFair => 'Regular';

  @override
  String get meteoVisibilityGood => 'Buena';

  @override
  String get meteoMoon => 'Luna';

  @override
  String get meteoMoonAbsence => 'Ausente';

  @override
  String get meteoMoonPresence => 'Presente';

  @override
  String get listeningPointLabel => 'Punto de escucha';

  @override
  String get listeningPointHint => 'Número de punto';

  @override
  String get reviewDeleteBtn => 'Cancelar sesión';

  @override
  String get reviewFinalizeBtn => 'Finalizar';

  @override
  String get reviewAddObservationBtn => 'Añadir';

  @override
  String get reviewObservationsTitle => 'Observaciones';

  @override
  String get confirmFinalizeTitle => '¿Finalizar sesión?';

  @override
  String get confirmFinalizeMessage =>
      'Una vez finalizada, la sesión no se podrá editar.';

  @override
  String get confirmFinalizeConfirm => 'Finalizar';

  @override
  String get reviewRequiredFieldError => 'Campo obligatorio';

  @override
  String get reviewErrorSaving => 'Error guardando la revisión';
}
